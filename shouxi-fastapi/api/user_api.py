# api/users.py
import uuid

from fastapi import APIRouter, Depends, Request
from sqlmodel import select
from sqlmodel.ext.asyncio.session import AsyncSession
from pydantic import BaseModel

from db.session import get_session
from dependencies.auth import get_current_user
from model.models import User, AlertContent
from model.result import Result
from utils.email import send_verification_code
from utils.valid import is_valid_email
from utils.verification import generate_code, save_verification_code, verify_code, delete_code

router = APIRouter(prefix="/users", tags=["用户"])

class LoginRequest(BaseModel):
    email: str
    code: str

class SendCodeRequest(BaseModel):
    email: str

@router.get("/", response_model=Result[User])
async def get_user(
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """获取当前登录用户信息（需要身份校验）"""
    user = await get_current_user(request, session)
    return Result.success(data=user)


@router.post("/send-code", response_model=Result)
async def send_code(request_data: SendCodeRequest):
    """发送验证码到邮箱（无需身份校验）"""
    # 校验邮箱格式
    if not is_valid_email(request_data.email):
        return Result.bad_request(msg="邮箱格式错误")

    # 生成验证码
    code = await generate_code()

    # 保存验证码
    saved = await save_verification_code(request_data.email, code)
    if not saved:
        return Result.error(msg="验证码存储失败，请稍后重试")

    # 发送邮件
    try:
        await send_verification_code(request_data.email, code)
    except Exception as e:
        return Result.error(msg=f"邮件发送失败: {str(e)}")

    return Result.success(msg="验证码已发送")


@router.post("/login", response_model=Result[str])
async def login(request_data: LoginRequest, session: AsyncSession = Depends(get_session)):
    """使用邮箱 + 验证码登录（无需身份校验）"""
    # 校验邮箱格式
    if not is_valid_email(request_data.email):
        return Result.bad_request(msg="邮箱格式错误")

    # 验证验证码
    valid = await verify_code(request_data.email, request_data.code)
    if not valid:
        return Result.error(msg="验证码错误或已过期")

    # 验证成功后删除验证码
    await delete_code(request_data.email)

    # 检查用户是否已存在
    existing_user = await session.execute(select(User).where(User.email == request_data.email))

    # 检查用户是否已存在
    existing_user = existing_user.scalars().one_or_none()

    if existing_user:
        # 用户已存在，返回 user_id
        return Result.success(data=existing_user.id, msg="Login successful")

    # 创建新用户
    user_id = str(uuid.uuid4())
    new_user = User(
        id=user_id,
        email=request_data.email,
        name=request_data.email.split("@")[0]
    )
    session.add(new_user)

    # 创建默认预警文案
    default_alert = AlertContent(
        user_id=user_id,
        title="我可能出事了，请查看",
        content="亲爱的朋友： 当你收到这封邮件时，我已经超过48小时没有在“死了" "我可能遇到了意外或处于危险中，请尝试给我打电话，或前往我的住处查" "我的常用地址：北京市朝阳区XX街道... 保险单位置：书柜第二层",
        time=48
    )
    session.add(default_alert)

    await session.commit()
    await session.refresh(new_user)

    return Result.success(data=user_id, msg="User created")
