# api/emergency_contact.py
from typing import Optional
from fastapi import APIRouter, HTTPException, Depends, Request
from pydantic import BaseModel, Field
from sqlalchemy import func
from sqlmodel.ext.asyncio.session import AsyncSession
from sqlmodel import select, delete

from db.session import get_session
from model.models import EmergencyContactPerson, User
from model.result import Result
from dependencies.auth import get_current_user
from utils.valid import is_valid_email

router = APIRouter(prefix="/emergency-contacts", tags=["紧急联系人"])


class ContactCreate(BaseModel):
    """创建紧急联系人请求"""
    contact_person_email: str = Field(..., description="紧急联系人邮箱")


class ContactUpdate(BaseModel):
    """更新紧急联系人请求"""
    contact_person_email: str = Field(..., description="紧急联系人邮箱")


@router.get("/", response_model=Result[list[EmergencyContactPerson]])
async def list_contacts(
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """获取当前用户的所有紧急联系人"""
    user = await get_current_user(request, session)

    contacts = await session.execute(
        select(EmergencyContactPerson)
        .where(EmergencyContactPerson.user_id == user.id)
        .order_by(EmergencyContactPerson.created_at.desc())
    )
    contacts = contacts.scalars().all()

    return Result.success(data=contacts)


@router.post("/", response_model=Result)
async def create_contact(
    contact: ContactCreate,
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """添加紧急联系人"""
    user = await get_current_user(request, session)

    # 校验邮箱格式
    if not is_valid_email(contact.contact_person_email):
        return Result.bad_request(msg="紧急联系人邮箱格式错误")

    # 检查联系人是否超出10人
    total_result = await session.execute(
        select(func.count(EmergencyContactPerson.id))
        .where(EmergencyContactPerson.user_id == user.id)
    )
    total = total_result.scalar_one()
    if total >= 10:
        return Result.error("联系人数量最多 10 人")

    # 检查是否已存在
    existing = await session.execute(
        select(EmergencyContactPerson)
        .where(
            EmergencyContactPerson.user_id == user.id,
            EmergencyContactPerson.contact_person_email == contact.contact_person_email
        )
    )
    if existing.scalar_one_or_none():
        return Result.bad_request(msg="该联系人已存在")

    new_contact = EmergencyContactPerson(
        user_id=user.id,
        contact_person_email=contact.contact_person_email
    )
    session.add(new_contact)
    await session.commit()
    await session.refresh(new_contact)

    return Result.success(msg="添加成功")


@router.put("/{contact_id}", response_model=Result[EmergencyContactPerson])
async def update_contact(
    contact_id: int,
    contact: ContactUpdate,
    request: Request,
    session: AsyncSession = Depends(get_session)
):

    """更新紧急联系人"""
    user = await get_current_user(request, session)

    # 校验邮箱格式
    if not is_valid_email(contact.contact_person_email):
        return Result.bad_request(msg="紧急联系人邮箱格式错误")

    # 查找联系人
    existing = await session.execute(
        select(EmergencyContactPerson)
        .where(
            EmergencyContactPerson.id == contact_id,
            EmergencyContactPerson.user_id == user.id
        )
    )
    db_contact = existing.scalar_one_or_none()
    if not db_contact:
        return Result.not_found(msg="联系人不存在")

    # 检查新邮箱是否被其他联系人使用
    duplicate = await session.execute(
        select(EmergencyContactPerson)
        .where(
            EmergencyContactPerson.user_id == user.id,
            EmergencyContactPerson.contact_person_email == contact.contact_person_email,
            EmergencyContactPerson.id != contact_id
        )
    )
    if duplicate.scalar_one_or_none():
        return Result.bad_request(msg="该邮箱已被其他联系人使用")

    db_contact.contact_person_email = contact.contact_person_email
    await session.commit()
    await session.refresh(db_contact)

    return Result.success(data=db_contact, msg="更新成功")


@router.delete("/{contact_id}", response_model=Result)
async def delete_contact(
    contact_id: int,
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """删除紧急联系人"""
    user = await get_current_user(request, session)

    # 查找并删除
    result = await session.execute(
        select(EmergencyContactPerson)
        .where(
            EmergencyContactPerson.id == contact_id,
            EmergencyContactPerson.user_id == user.id
        )
    )
    db_contact = result.scalar_one_or_none()
    if not db_contact:
        return Result.not_found(msg="联系人不存在")

    await session.delete(db_contact)
    await session.commit()

    return Result.success(msg="删除成功")
