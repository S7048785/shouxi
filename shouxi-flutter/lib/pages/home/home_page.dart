import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shouxi/pages/emergency/emergency_page.dart';
import 'package:shouxi/pages/warning/warning_page.dart';
import 'package:styled_widget/styled_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // 创建动画控制器（800ms 动画）
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // 缩放动画：1.0 → 2.0
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // 透明度动画：0.4 → 0.0
    _opacityAnimation = Tween<double>(
      begin: 0.4,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // 启动定时器：每 3 秒触发一次
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_controller.isAnimating) {
        _controller.forward(from: 0.0); // 从头开始播放
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// 构建签到按钮
  Widget _buildCheckInButton(ColorScheme colorScheme) {
    return <Widget>[
      // 波浪涟漪背景
      AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Styled.widget()
                .padding(all: 69)
                .decorated(
                  color: colorScheme.primary.withAlpha(0x50),
                  shape: BoxShape.circle,
                )
                .opacity(_opacityAnimation.value),
          );
        },
      ).positioned(top: 0, right: 0, left: 0, bottom: 0),

      // 按钮内容
      <Widget>[
            Text(
              "我还活着",
              style: TextStyle(
                fontSize: 24,
                color: colorScheme.primaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "点击签到",
              style: TextStyle(fontSize: 16, color: colorScheme.onSecondary),
            ),
          ]
          .toColumn()
          .padding(all: 64)
          .decorated(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xfffb923c), Color(0xffea580c)],
            ),
          )
          .padding(all: 5)
          .decorated(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(0x30),
                blurRadius: 25,
                offset: Offset(0, 15),
              ),
            ],
          ),
    ].toStack();
  }

  /// 构建状态框
  Widget _buildState(ColorScheme colorScheme) {
    return <Widget>[
          <Widget>[
            Text(
              "当前状态",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            Text(
                  "安全监控中",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .padding(horizontal: 16, vertical: 6)
                .decorated(
                  color: Color(0xffdcfce7),
                  borderRadius: BorderRadius.circular(30),
                ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          _buildCheckInButton(colorScheme),
          Gap(35),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '下次自动预警倒计时: ',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onPrimaryFixedVariant,
                  ),
                ),
                TextSpan(
                  text: '47:59:59',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Gap(40),
        ]
        .toColumn()
        .padding(all: 16)
        .decorated(
          borderRadius: BorderRadius.circular(20),
          color: colorScheme.primaryContainer,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: colorScheme.primary.withAlpha(0x30),
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        );
  }

  /// 构建底部菜单
  Widget _buildFooterMenu(ColorScheme colorScheme) {
    final List<MenuItem> menuItems = [
      MenuItem(
        title: "紧急联系人",
        subTitle: "已关联 2 人",
        icon: FontAwesomeIcons.users,
        iconColor: colorScheme.primary,
        bgColor: colorScheme.primary.withAlpha(0x30),
        onTap: () => Get.to(() => const EmergencyPage()),
      ),
      MenuItem(
        title: "预警信息",
        subTitle: "自定义内容",
        icon: FontAwesomeIcons.envelope,
        iconColor: Color(0xff3b82f6),
        bgColor: Color(0xff3b82f6).withAlpha(0x30),
        onTap: () => Get.to(() => const WarningPage()),
      ),
    ];
    return GridView.count(
      // 禁用滚动
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: menuItems.length,
      childAspectRatio: 1.5,
      // 设置宽高比，可根据需要调整
      mainAxisSpacing: 10,
      // 主轴间距
      crossAxisSpacing: 25,
      // 交叉轴间距
      children: [
        for (var item in menuItems)
          InkWell(
            onTap: item.onTap,
            child: <Widget>[
              FaIcon(item.icon, color: item.iconColor, size: 20)
                  .padding(all: 12)
                  .decorated(
                borderRadius: BorderRadius.circular(12),
                color: item.bgColor,
              ),
              Gap(10),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item.subTitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ]
                .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                .padding(horizontal: 24, vertical: 12)
                .decorated(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: colorScheme.primary.withAlpha(0x30),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;
    return <Widget>[
      <Widget>[
        Text(
          "你好，活着的自己",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      Gap(20),
      _buildState(colorScheme),
      Gap(30),
      _buildFooterMenu(colorScheme),
    ].toColumn().scrollable().marginSymmetric(horizontal: 25);
  }
}

class MenuItem {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Function()? onTap;

  MenuItem({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.onTap,
  });
}
