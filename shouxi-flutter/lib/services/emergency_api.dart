import 'package:shouxi/models/emergency_contact_person.dart';
import 'package:shouxi/utils/json_util.dart';
import 'package:shouxi/utils/request.dart';

import '../constant/api-constant.dart';
import '../utils/ToastUtil.dart';

class EmergencyApi {
  // 获取所有紧急联系人
  static Future<List<EmergencyContactPerson>> getAllEmergencyContacts() async {
    final response = await dioRequest.get(ApiConstant.EMERGENCY_CONTACT_URI);
    return JsonResParseUtil.parseJsonListData(
      EmergencyContactPerson.fromJson,
      response.data,
    );
  }

  // 添加紧急联系人
  static Future<void> addEmergencyContact(String email) async {
    final res = await dioRequest.post(ApiConstant.EMERGENCY_CONTACT_URI, params: {
      "contact_person_email": email
    });
    if (res.code == 200) {
      ToastUtil.showText("添加成功");
    }
  }

  // 更新
  static Future<EmergencyContactPerson> updateEmergencyContact(String id, String email) async {
    final res = await dioRequest.put("${ApiConstant.EMERGENCY_CONTACT_URI}/${id}", params: {
      "contact_person_email": email
    });
    if (res.code == 200) {
      ToastUtil.showText("更新成功");
    }
    return EmergencyContactPerson.fromJson(res.data);
  }

  // 删除
  static Future<void> deleteEmergencyContact(String id) async {
    final res = await dioRequest.delete("${ApiConstant.EMERGENCY_CONTACT_URI}/${id}");
    if (res.code == 200) {
      ToastUtil.showText("删除成功");
    }
  }

}
