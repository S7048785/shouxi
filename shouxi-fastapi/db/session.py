# app/db/session.py
from sqlmodel import create_engine, SQLModel
from sqlalchemy.ext.asyncio import AsyncEngine, AsyncSession
from sqlalchemy.pool import NullPool
import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

# 使用异步引擎
engine = AsyncEngine(
    create_engine(
        DATABASE_URL,
        echo=True,  # 开发时可开启 SQL 日志
        poolclass=NullPool,  # FastAPI + Uvicorn 推荐用 NullPool 避免连接池冲突
    )
)

async def init_db():
    """创建所有表（仅在开发时使用，生产建议用 Alembic）"""
    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.create_all)

async def get_session() -> AsyncSession:
    """依赖注入：获取数据库会话"""
    async with AsyncSession(engine) as session:
        yield session
