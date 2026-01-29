import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shouxi/pages/frame/frame_page.dart';
import 'package:shouxi/pages/login/login_page.dart';
import 'package:shouxi/stores/user_store.dart';
import 'package:styled_widget/styled_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isLogged = UserStore.isLogged();

    // 定时器，3秒后跳转
    Future.delayed(Duration(seconds: 3), () {
      if (isLogged) {
        Get.offAll(() => FramePage());
      }
    });
    return Scaffold(
      body:
          <Widget>[
                <Widget>[
                      FaIcon(
                            FontAwesomeIcons.heartPulse,
                            color: colorScheme.primary,
                            size: 60,
                          )
                          .padding(all: 20)
                          .decorated(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(15),
                          )
                          .boxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 15),
                            blurRadius: 25,
                            spreadRadius: -10,
                          ),
                      Gap(5),
                      Text(
                        "死了吗",
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(5),
                      Text(
                        "让爱，不错过最后一次告别",
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ]
                    .toColumn(mainAxisAlignment: MainAxisAlignment.center)
                    .expanded(),
// 未登录显示启动按钮
                !isLogged
                    ? ElevatedButton(
                        onPressed: () {
                          Get.offAll(
                            () => LoginPage(),
                            transition: Transition.fade,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const .symmetric(
                            horizontal: 35,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          "开始守护",
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SizedBox(),
                Gap(80),
              ]
              .toColumn()
              .alignment(Alignment.bottomCenter)
              .backgroundLinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xfffb923c), Color(0xffea580c)],
              ),
    );
  }
}
