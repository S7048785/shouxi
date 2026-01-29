# 守息 (shouxi)

仿"死了吗"App的安全监控应用。如果用户在设定时间内未签到，系统将自动向紧急联系人发送预警邮件。

## 技术栈

**前端**
- Flutter
- GetX（状态管理）
- Dio（网络请求）
- styled_widget（UI构建）

**后端**

- FastAPI
- SQLModel
- MySQL

**其他**
- SMTP（邮件发送）

## 功能

- 邮箱验证码登录
- 每日签到（"我还活着"按钮）
- 月度签到记录查看
- 签到统计数据
- 紧急联系人管理（最多10人）
- 自定义预警文案（标题、内容、超时时间）
- 自动预警邮件发送

## 项目状态

**未完成**。由于精力有限，以下功能尚未实现：

- 自动预警定时任务（当前仅手动签到，邮件发送功能未接入）
- 设置页面
- 完整的错误处理和边界情况

## 目录结构

```
shouxi/
├── shouxi-flutter/     # Flutter 前端
│   └── lib/
│       ├── pages/      # 页面
│       ├── services/   # API 服务
│       ├── models/     # 数据模型
│       └── utils/      # 工具类
└── shouxi-fastapi/     # FastAPI 后端
    ├── api/            # API 路由
    ├── db/             # 数据库
    ├── model/          # 数据模型
    └── utils/          # 工具类
```

## 运行方式

**前端**
```bash
cd shouxi-flutter
flutter run
```

**后端**
```bash
cd shouxi-fastapi
.venv/Scripts/activate  # Windows
uvicorn main:app --reload
```
