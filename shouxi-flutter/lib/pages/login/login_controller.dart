import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shouxi/pages/frame/frame_page.dart';
import 'package:shouxi/services/user_api.dart';
import 'package:shouxi/stores/user_store.dart';
import 'package:shouxi/utils/ToastUtil.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isCodePress = false.obs;
  // 倒计时
  var countdown = 60.obs;

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    UserStore.setUserId("abc7f869-113d-49ed-a82d-95ab3550aae7");

    Get.offAll(() => FramePage());
    return;


    final RegExp emailRegExp = RegExp(r'^\w+@\w+\.\w+');
    final RegExp passwordRegExp = RegExp(r'^\w{6,}$');

    // 校验邮箱
    if (!emailRegExp.hasMatch(emailController.text)) {
      ToastUtil.showText("请输入正确的邮箱");
      return;
    }
    // 校验密码
    if (!passwordRegExp.hasMatch(passwordController.text)) {
      ToastUtil.showText("请输入正确的密码");
      return;
    }

    final userId = await UserService.login(emailController.text, passwordController.text);
    UserStore.setUserId(userId);

    Get.offAll(() => FramePage());
  }

  void sendCode() {
    // 正则校验
    final RegExp emailRegExp = RegExp(r'^\w+@\w+\.\w+');
    if (!emailRegExp.hasMatch(emailController.text)) {
      ToastUtil.showText("请输入正确的邮箱");
      return;
    }
    if (isCodePress.value) return;
    isCodePress.value = true;

    UserService.sendCode(emailController.text);
    // 开始倒计时
    var timer = Timer.periodic(Duration(seconds: 1), (timer) {
      countdown--;
      if (countdown <= 0) {
        timer.cancel();
        isCodePress.value = false;
        countdown.value = 60;
      }
    });
  }

}