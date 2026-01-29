from typing import Optional
from fastapi import Request, HTTPException, Depends
from sqlmodel.ext.asyncio.session import AsyncSession
from sqlmodel import select

from db.session import get_session
from model.models import User


async def get_current_user(request: Request, session: AsyncSession = Depends(get_session)) -> User:
    """身份校验依赖：验证请求头中的 user_id"""
    user_id = request.headers.get("user_id")

    if not user_id:
        raise HTTPException(status_code=401, detail="Missing user_id header")

    # 验证 user_id 格式（UUID）
    try:
        from sqlmodel import col
        user = await session.execute(select(User).where(User.id == user_id))
        user = user.scalar_one_or_none()
    except Exception:
        raise HTTPException(status_code=401, detail="Invalid user_id")

    if not user:
        raise HTTPException(status_code=401, detail="User not found")

    return user


class RequireUser:
    """类依赖，用于需要身份校验的路由"""

    def __init__(self, require_auth: bool = True):
        self.require_auth = require_auth

    async def __call__(self, request: Request, session: AsyncSession = Depends(get_session)) -> Optional[User]:
        if not self.require_auth:
            return None

        return await get_current_user(request, session)
