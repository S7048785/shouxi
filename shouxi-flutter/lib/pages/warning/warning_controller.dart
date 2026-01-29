import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class WarningController extends GetxController{

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void save() {
    print("保存修改");
  }
}