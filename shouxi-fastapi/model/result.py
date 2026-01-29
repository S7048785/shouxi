from typing import Generic, TypeVar, Optional, List
from pydantic import BaseModel
from enum import IntEnum

T = TypeVar('T')

class ResponseCode(IntEnum):
    """响应码枚举"""
    SUCCESS = 200
    CREATED = 201
    ACCEPTED = 202
    NO_CONTENT = 204
    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    FORBIDDEN = 403
    NOT_FOUND = 404
    INTERNAL_ERROR = 500

class PageResult(BaseModel, Generic[T]):
    """分页信息"""
    page: int = 1
    page_size: int = 10
    total: int = 0
    list: List[T]

class Result(BaseModel, Generic[T]):
    """通用响应类"""
    code: int = ResponseCode.SUCCESS
    data: Optional[T] = None
    msg: str = "success"

    @classmethod
    def success(cls, data: T = None, msg: str = "success", code: int = ResponseCode.SUCCESS) -> 'Result[T]':
        """成功响应"""
        return cls(code=code, data=data, msg=msg)

    @classmethod
    def error(cls, msg: str = "error", code: int = ResponseCode.INTERNAL_ERROR) -> 'Result[T]':
        """错误响应"""
        return cls(code=code, data=None, msg=msg)

    @classmethod
    def not_found(cls, msg: str = "Not found") -> 'Result[T]':
        """未找到响应"""
        return cls(code=ResponseCode.NOT_FOUND, data=None, msg=msg)

    @classmethod
    def bad_request(cls, msg: str = "Bad request") -> 'Result[T]':
        """请求错误响应"""
        return cls(code=ResponseCode.BAD_REQUEST, data=None, msg=msg)
