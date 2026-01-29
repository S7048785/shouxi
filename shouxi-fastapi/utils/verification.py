import asyncio
import random
import string
import redis.asyncio as redis
import os
from dotenv import load_dotenv

load_dotenv()

# Redis 配置
REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")
CODE_EXPIRE_SECONDS = 300  # 验证码 5 分钟过期

# 内存存储（备用/开发环境）
_memory_store = {}


async def get_redis_client():
    """获取 Redis 客户端"""
    try:
        return await redis.from_url(REDIS_URL, decode_responses=True)
    except Exception:
        return None


async def generate_code(length: int = 6) -> str:
    """生成数字验证码"""
    return "".join(random.choices(string.digits, k=length))


async def save_verification_code(email: str, code: str) -> bool:
    """保存验证码到 Redis"""
    try:
        client = await get_redis_client()
        if client:
            key = f"verify_code:{email}"
            await client.setex(key, CODE_EXPIRE_SECONDS, code)
            return True
        else:
            # 降级到内存存储
            _memory_store[email] = code
            # 使用定时器 5 分钟后删除
            asyncio.create_task(_auto_delete_code(email))
            return True
    except Exception:
        return False


async def _auto_delete_code(email: str):
    """5 分钟后自动删除验证码"""
    await asyncio.sleep(CODE_EXPIRE_SECONDS)
    _memory_store.pop(email, None)


async def verify_code(email: str, code: str) -> bool:
    """验证验证码"""
    try:
        client = await get_redis_client()
        if client:
            key = f"verify_code:{email}"
            stored_code = await client.get(key)
            return stored_code == code
        else:
            # 从内存验证
            stored_code = _memory_store.get(email)
            return stored_code == code
    except Exception:
        return False


async def delete_code(email: str):
    """删除验证码（验证成功后删除）"""
    try:
        client = await get_redis_client()
        if client:
            key = f"verify_code:{email}"
            await client.delete(key)
        else:
            _memory_store.pop(email, None)
    except Exception:
        pass
