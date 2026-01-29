import 'package:get/get.dart';
import 'package:shouxi/models/emergency_contact_person.dart';
import 'package:shouxi/services/emergency_api.dart';

class EmergencyController extends GetxController {
  final list = <EmergencyContactPerson>[].obs;

  @override
  void onInit() {
    super.onInit();
    query();
  }

  /// 查询
  Future<void> query() async {
    final result = await EmergencyApi.getAllEmergencyContacts();
    list.value = result;
  }

  /// 添加紧急联系人
  Future<void> addEmergencyContact(String email) async {
    await EmergencyApi.addEmergencyContact(email);
    await query();
  }

  /// 更新紧急联系人
  Future<void> updateEmergencyContact(String id, String email) async {
    final result = await EmergencyApi.updateEmergencyContact(id, email);
    list.value = list.map((item) => item.id == id ? result : item).toList();
  }

  /// 删除紧急联系人
  Future<void> deleteEmergencyContact(String id) async {
    await EmergencyApi.deleteEmergencyContact(id);
    await query();
  }

}