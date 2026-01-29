import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('用户设置')),
      body: <Widget>[
        <Widget>[
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidBell,
              color: Colors.grey,
              size: 20,
            ),
            title: Text("静默期时长(48h)", style: TextStyle(fontSize: 16)),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidBell,
              color: Colors.grey,
              size: 20,
            ),
            title: Text("隐私模式", style: TextStyle(fontSize: 16)),
            trailing: Switch(value: true, onChanged: (value) {}),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidBell,
              color: Colors.grey,
              size: 20,
            ),
            title: Text("法律免责", style: TextStyle(fontSize: 16)),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidBell,
              color: Colors.grey,
              size: 20,
            ),
            title: Text(
              "它是如何工作的?",
              style: TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ),
        ].toColumn(separator: Divider(height: 10, color: Colors.grey.shade200)),
        Gap(60),
        Text(
          "退出登录",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ).gestures(onTap: () {})
      ].toColumn().scrollable().marginSymmetric(horizontal: 30, vertical: 20),
    );
  }
}
