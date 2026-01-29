import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shouxi/pages/login/login_controller.dart';
import 'package:shouxi/stores/user_store.dart';
import 'package:styled_widget/styled_widget.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  Widget header(ColorScheme colorScheme) => <Widget>[
    Text("欢迎回来", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
    Text("验证您的身份，继续守护", style: TextStyle(fontSize: 16, color: Colors.grey)),
  ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);

  Widget input(ColorScheme colorScheme) => <Widget>[
    TextField(
      controller: controller.emailController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.tertiary),
        ),
        hintText: "邮箱号",
        hintStyle: TextStyle(color: Colors.grey),
      ),
    ),
    Gap(20),
    TextField(
      controller: controller.passwordController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.tertiary),
        ),
        hintText: "验证码",
        hintStyle: TextStyle(color: Colors.grey),
        suffixIcon: IconButton(
          // 禁用按钮的背景色
          highlightColor: Colors.transparent,
          icon: Obx(() {
            if (controller.isCodePress.value) {
              return Text(
                controller.countdown.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 18),
              );
            }
            return Text(
              "获取验证码",
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
          onPressed: controller.sendCode,
        ),
      ),
    ),
  ].toColumn();

  Widget button(ColorScheme colorScheme) =>
      Text(
            "登录",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
          .alignment(Alignment.center)
          .constrained(width: double.infinity, height: 50)
          .ripple()
          .backgroundLinearGradient(
            colors: [Color(0xfffb923c), Color(0xffea580c)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            animate: true,
          )
          .clipRRect(all: 25) // clip ripple
          .gestures(onTap: controller.login)
          .elevation(
            15,
            borderRadius: BorderRadius.circular(25),
            shadowColor: Color(0x50000000),
          )
          .animate(Duration(milliseconds: 150), Curves.easeOut);


  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final colorScheme = Theme.of(context).colorScheme;

    print("user_id: ${UserStore.getUserId()}");

    return Scaffold(
      body: SafeArea(
        child:
            <Widget>[
                  header(colorScheme),
                  Gap(40),
                  input(colorScheme),
                  Gap(50),
                  button(colorScheme),
                ]
                .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                .padding(top: 100, horizontal: 30),
      ),
    );
  }
}
