import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shouxi/pages/warning/warning_controller.dart';
import 'package:styled_widget/styled_widget.dart';

class WarningPage extends GetView<WarningController> {
  const WarningPage({super.key});

  Widget _buildSaveButton(ColorScheme colorScheme) =>
      Text(
            "保存修改",
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
          .clipRRect(all: 15) // clip ripple
          .gestures(onTap: controller.save)
          .elevation(
            15,
            borderRadius: BorderRadius.circular(25),
            shadowColor: Color(0x50000000),
          )
          .animate(Duration(milliseconds: 150), Curves.easeOut);

  @override
  Widget build(BuildContext context) {
    Get.put(WarningController());
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text('预警文案')),
      body: <Widget>[
        // 文案
        <Widget>[
              Text(
                '标题',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: controller.titleController,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.tertiary),
                  ),
                ),
              ),

              Gap(30),

              // 正文
              Text(
                '正文内容',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10),
              TextField(
                    maxLines: 6,
                    // 最小 3 行
                    minLines: 2,
                    // 最少显示 2 行（可选）
                    maxLength: 200,
                    // 可选：限制字符数
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    controller: controller.contentController,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  )
                  .padding(horizontal: 16, vertical: 10)
                  .decorated(
                    color: Color(0xfff9fafb),
                    borderRadius: BorderRadius.circular(15),
                  ),
            ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .padding(all: 24)
            .decorated(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(15),
            ),
        Gap(40),
        // 保存修改
        _buildSaveButton(colorScheme),
      ].toColumn().scrollable().marginSymmetric(horizontal: 30, vertical: 20),
    );
  }
}
