# api/checkin.py
from datetime import date, datetime
from typing import Optional

from fastapi import APIRouter, Depends, Request
from pydantic import BaseModel
from sqlmodel import select, func
from sqlmodel.ext.asyncio.session import AsyncSession

from db.session import get_session
from dependencies.auth import get_current_user
from model.models import CheckIn, EmergencyContactPerson
from model.result import Result

router = APIRouter(prefix="/checkin", tags=["签到"])

class CheckInInfo(BaseModel):
    is_checkin: bool
    checkin_time: Optional[datetime] = None

@router.post("/", response_model=Result)
async def create_checkin(
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """签到（每天只能签到一次）"""
    user = await get_current_user(request, session)
    today = date.today()

    # 检查是否添加过紧急联系人
    contacts = await session.execute(
        select(EmergencyContactPerson)
        .where(EmergencyContactPerson.user_id == user.id)
    )
    if not contacts.scalar_one_or_none():
        return Result.error(msg="请先添加紧急联系人")

    # 检查今天是否已签到
    existing = await session.execute(
        select(CheckIn)
        .where(
            CheckIn.user_id == user.id,
            CheckIn.checkin_date == today
        )
    )
    if existing.scalar_one_or_none():
        return Result.error(msg="今天已签到")

    # 创建签到记录
    checkin = CheckIn(
        user_id=user.id,
        created_at=datetime.now(),
    )
    session.add(checkin)
    await session.commit()
    await session.refresh(checkin)

    return Result.success(msg="签到成功")


@router.get("/month", response_model=Result[list[str]])
async def get_month_checkin(
    year: int,
    month: int,
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """
    查询某年某月的签到记录

    Args:
        year: 年份 (如 2026)
        month: 月份 (如 2)

    Returns:
        该月签到的日期数组，如 ['2026-02-12', '2026-02-15', ...]
    """
    user = await get_current_user(request, session)

    # 验证月份参数
    if month < 1 or month > 12:
        return Result.bad_request(msg="月份无效")

    # 查询该月的签到记录
    result = await session.execute(
        select(CheckIn.created_at)
        .where(
            CheckIn.user_id == user.id,
            func.year(CheckIn.created_at) == year,
            func.month(CheckIn.created_at) == month
        )
        .order_by(CheckIn.created_at)
    )
    dates = result.scalars().all()

    # 转换为字符串格式
    date_strings = [d.isoformat() for d in dates]

    return Result.success(data=date_strings)


@router.get("/today", response_model=Result[CheckInInfo])
async def get_today_status(
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """查询今天是否已签到"""
    user = await get_current_user(request, session)
    today = date.today()

    existing = await session.execute(
        select(CheckIn)
        .where(
            CheckIn.user_id == user.id,
            func.date(CheckIn.created_at) == today
        )
    )
    checkin = existing.scalar_one_or_none()

    return Result.success(data=CheckInInfo(
        is_checkin=checkin is not None,
        checkin_time=checkin.created_at if checkin else None
    ), msg="查询成功")


@router.get("/stats", response_model=Result[dict])
async def get_checkin_stats(
    request: Request,
    session: AsyncSession = Depends(get_session)
):
    """获取签到统计"""
    user = await get_current_user(request, session)

    # 总签到次数
    total_result = await session.execute(
        select(func.count(CheckIn.id)).where(CheckIn.user_id == user.id)
    )
    total = total_result.scalar_one()

    # 本月签到次数
    today = date.today()
    month_result = await session.execute(
        select(func.count(CheckIn.id))
        .where(
            CheckIn.user_id == user.id,
            func.year(CheckIn.created_at) == today.year,
            func.month(CheckIn.created_at) == today.month
        )
    )
    month_count = month_result.scalar_one()

    return Result.success(data={
        "total": total,
        "month_count": month_count,
        "today_checked_in": False  # 前端可单独调用 /today 接口
    })
