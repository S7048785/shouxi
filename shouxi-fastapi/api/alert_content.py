# api/alert_content.py
from datetime import datetime
from fastapi import APIRouter, HTTPException, Depends, Request
from pydantic import BaseModel, Field
from sqlmodel.ext.asyncio.session import AsyncSession
from sqlmodel import select

from db.session import get_session
from model.models import AlertContent, User
from model.result import Result
from dependencies.auth import get_current_user

router = APIRouter(prefix="/alert-content", tags=["预警文案"])


class AlertContentUpdate(BaseModel):
    """更新预警文案"""
    title: str = Field(..., max_length=10, description="预警标题")
    content: str = Field(..., max_length=255, description="预警内容")
    time: int = Field(..., ge=1, le=1440, description="自动发送预警邮件的倒计时时长（分钟）")


@router.get("/", response_model=Result[AlertContent])
async def get_alert_content(
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """获取当前用户的预警文案"""
    user = await get_current_user(request, session)

    result = await session.execute(
        select(AlertContent).where(AlertContent.user_id == user.id)
    )
    alert_content = result.scalar_one_or_none()

    if not alert_content:
        raise HTTPException(status_code=404, detail="预警文案不存在")

    return Result.success(data=alert_content)


@router.put("/", response_model=Result[AlertContent])
async def update_alert_content(
    content: AlertContentUpdate,
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """更新预警文案"""
    user = await get_current_user(request, session)

    result = await session.execute(
        select(AlertContent).where(AlertContent.user_id == user.id)
    )
    alert_content = result.scalar_one_or_none()

    if not alert_content:
        raise HTTPException(status_code=404, detail="预警文案不存在")

    alert_content.title = content.title
    alert_content.content = content.content
    alert_content.time = content.time

    await session.commit()
    await session.refresh(alert_content)

    return Result.success(data=alert_content, msg="更新成功")
