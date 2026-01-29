import re


def is_valid_email(email: str) -> bool:
    """
    校验邮箱地址是否符合基本格式规范。

    注意：此函数仅进行格式校验，不验证邮箱是否真实存在或可接收邮件。

    Args:
        email (str): 待校验的邮箱字符串

    Returns:
        bool: 格式合法返回 True，否则返回 False
    """
    if not isinstance(email, str) or not email.strip():
        return False

    email = email.strip()

    # RFC 5322 官方推荐的简化正则（兼顾可读性与实用性）
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

    return re.match(pattern, email) is not None
