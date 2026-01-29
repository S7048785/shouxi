import smtplib
import ssl
from email.mime.text import MIMEText
from email.utils import formataddr

# 配置
smtp_host = "smtp.qq.com"
smtp_port = 587
smtp_user = "195726662@qq.com"
smtp_password = "ccvrwjxsiurcbhhf"

def send_sync():
    """同步发送测试"""
    subject = "测试"
    body = "测试邮件"

    msg = MIMEText(body, "html", "utf-8")
    msg["Subject"] = subject
    msg["From"] = formataddr(("手西", smtp_user))
    msg["To"] = smtp_user

    context = ssl.create_default_context()

    print(f"Connecting to {smtp_host}:{smtp_port}...")
    with smtplib.SMTP(smtp_host, smtp_port, timeout=30) as server:
        print("Connected, starting TLS...")
        server.starttls(context=context)
        print("TLS started, logging in...")
        server.login(smtp_user, smtp_password)
        print("Login success, sending...")
        server.send_message(msg)
        print("Sent!")

if __name__ == "__main__":
    try:
        send_sync()
        print("邮件发送成功！")
    except Exception as e:
        print(f"错误: {type(e).__name__}: {e}")
