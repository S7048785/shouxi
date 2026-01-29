import smtplib
import ssl
from email.mime.text import MIMEText
from email.utils import formataddr
import os
import asyncio
from threading import Thread
from dotenv import load_dotenv

load_dotenv()


def _send_sync(email: str, code: str, smtp_host: str, smtp_port: int, smtp_user: str, smtp_password: str):
    """同步发送邮件"""
    subject = "验证码"
    body = f"""
    <html>
    <body>
        <h2>登录到守息App的验证码</h2>
        <p>您的验证码是: <strong style="font-size: 24px; letter-spacing: 4px;">{code}</strong></p>
        <p>验证码 5 分钟内有效，请勿泄露给他人。</p>
    </body>
    </html>
    """

    msg = MIMEText(body, "html", "utf-8")
    msg["Subject"] = subject
    msg["From"] = formataddr(("守息", smtp_user))
    msg["To"] = email

    context = ssl.create_default_context()

    if smtp_port == 465:
        with smtplib.SMTP_SSL(smtp_host, smtp_port, context=context, timeout=30) as server:
            server.login(smtp_user, smtp_password)
            server.send_message(msg)
    else:
        with smtplib.SMTP(smtp_host, smtp_port, timeout=30) as server:
            server.starttls(context=context)
            server.login(smtp_user, smtp_password)
            server.send_message(msg)


async def send_verification_code(email: str, code: str):
    """发送验证码到邮箱（异步封装同步发送）"""
    smtp_host = os.getenv("SMTP_HOST", "smtp.qq.com")
    smtp_port = int(os.getenv("SMTP_PORT", 465))
    smtp_user = os.getenv("SMTP_USER")
    smtp_password = os.getenv("SMTP_PASSWORD")

    if not smtp_user or not smtp_password:
        raise Exception("SMTP credentials not configured")

    loop = asyncio.get_event_loop()
    await loop.run_in_executor(None, _send_sync, email, code, smtp_host, smtp_port, smtp_user, smtp_password)
