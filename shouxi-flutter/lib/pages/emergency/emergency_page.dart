import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'emergency_controller.dart';

class EmergencyPage extends GetView<EmergencyController> {
  const EmergencyPage({super.key});

  Widget _buildAddButton() => <Widget>[
    Icon(Icons.add_circle_outlined, color: Colors.grey),
    Gap(10),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '添加联系人', style: TextStyle(fontSize: 16)),
          TextSpan(text: '    ', style: TextStyle(fontSize: 16)),
          TextSpan(
            text: '${controller.list.length}/10',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  ].toRow(mainAxisAlignment: MainAxisAlignment.center).padding(all: 16);

  Widget _buildPersonList() => Obx(
    () => <Widget>[
      for (var item in controller.list)
        <Widget>[
          Text(
            item.contactPersonName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(item.contactPersonEmail, style: TextStyle(color: Colors.grey)),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toColumn(),
  );

  @override
  Widget build(BuildContext context) {
    Widget page({required Widget child}) => Styled.widget(child: child)
        .marginSymmetric(vertical: 20, horizontal: 20)
        .constrained(minHeight: MediaQuery.of(context).size.height - (2 * 30))
        .scrollable();

    return Scaffold(
      appBar: AppBar(title: Text('紧急联系人')),
      body: Obx(
        () => <Widget>[
          _buildPersonList(),
          _buildAddButton(),
          Gap(20),
          Text(
            "提示：当您长时间未签到，系统将按顺序通过邮件和短信通知以上联系人。",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ).marginSymmetric(horizontal: 20),
        ].toColumn().parent(page),
      ),
    );
  }
}
