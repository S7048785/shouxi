from datetime import datetime, date
from typing import Optional
from sqlmodel import SQLModel, Field, Relationship

# 用户表
class User(SQLModel, table=True):
    __tablename__ = "users"

    id: str = Field(default=None, primary_key=True)
    email: str = Field(max_length=100, nullable=False)
    name: str = Field(max_length=25, nullable=False)
    created_at: Optional[datetime] = Field(default_factory=datetime.utcnow)

    # 反向关系（可选，用于方便访问关联数据）
    alerts: list["Alert"] = Relationship(back_populates="user")
    check_ins: list["CheckIn"] = Relationship(back_populates="user")
    emergency_contacts: list["EmergencyContactPerson"] = Relationship(back_populates="user")


# 预警发送记录
class Alert(SQLModel, table=True):
    __tablename__ = "alerts"
    __table_args__ = {"comment": "预警发送记录"}

    id: int = Field(default=None, primary_key=True)
    user_id: str = Field(foreign_key="users.id", nullable=False)
    alerted_at: datetime = Field(nullable=False, description="预警时间")
    sent_email: str = Field(max_length=100, nullable=False, description="发送的邮箱")
    created_at: Optional[datetime] = Field(default_factory=datetime.utcnow)

    user: User = Relationship(back_populates="alerts")

# 预警文案
class AlertContent(SQLModel, table=True):
    __tablename__ = "alerts_content"
    __table_args__ = {"comment": "预警文案"}

    id: int = Field(default=None, primary_key=True)
    user_id: str = Field(foreign_key="users.id", nullable=False)
    title: Optional[str] = Field(
        default="我可能出事了，请查看",
        max_length=10,
        nullable=True
    )
    content: Optional[str] = Field(
        default=(
            "亲爱的朋友： 当你收到这封邮件时，我已经超过48小时没有在“死了么”App签到了。"
            "我可能遇到了意外或处于危险中，请尝试给我打电话，或前往我的住处查看。  "
            "我的常用地址：北京市朝阳区XX街道... 保险单位置：书柜第二层..."
        ),
        max_length=255,
        nullable=True
    )
    time: Optional[int] = Field(
        default=48,
        nullable=True,
        description="自动发送预警邮件的倒计时时长"
    )

# 签到记录
class CheckIn(SQLModel, table=True):
    __tablename__ = "check_in"

    id: int = Field(default=None, primary_key=True)
    user_id: str = Field(foreign_key="users.id", nullable=False)
    created_at: Optional[datetime] = Field(default_factory=datetime.utcnow)

    user: User = Relationship(back_populates="check_ins")


# 紧急联系人
class EmergencyContactPerson(SQLModel, table=True):
    __tablename__ = "emergency_contact_persion"  # 注意：DDL 中拼写为 persion（应为 person），此处保持一致
    __table_args__ = {"comment": "紧急联系人"}

    id: int = Field(default=None, primary_key=True)
    user_id: str = Field(foreign_key="users.id", nullable=False)
    contact_person_name: str = Field(max_length=10, nullable=False)
    contact_person_email: str = Field(max_length=100, nullable=False)
    created_at: Optional[datetime] = Field(default_factory=datetime.utcnow)

    user: User = Relationship(back_populates="emergency_contacts")