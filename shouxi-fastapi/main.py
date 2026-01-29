import os
from contextlib import asynccontextmanager

from dotenv import load_dotenv
from fastapi import FastAPI

from db.session import init_db

# 必须先加载 .env 文件
load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

@asynccontextmanager
async def lifespan(app: FastAPI):
    # 启动时初始化数据库（仅开发用！）
    await init_db()
    yield
    # 关闭时清理（可选）


app = FastAPI()

# 注册路由
from api.user_api import router as user_router
from api.emergency_contact import router as emergency_contact_router
from api.checkin import router as checkin_router
from api.alert_content import router as alert_content_router

app.include_router(user_router)
app.include_router(emergency_contact_router)
app.include_router(checkin_router)
app.include_router(alert_content_router)

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}
