// این صحفه برای اضافه کردن دیتا و مدیریت آن ها می باشد
//ــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:check_final_way/helpers/db_helper.dart';
import '../models/check.dart';

class GreatCheck with ChangeNotifier {
  List<Check> _items = [];

  List<Check> get items {
    //مقداری return کپی از _items
    return [..._items];
  }


  void addCheck(
    String pickedPayTo,
    String pickedBankName,
    double pickedAmount,
    // DateTime pickedDate,
  ) {
    final newCheck = Check(
      id: DateTime.now().toString(),
      payTo: pickedPayTo,
      bankName: pickedBankName,
      amount: pickedAmount,
      // date: pickedDate,
    );
    _items.add(newCheck);
    notifyListeners();


    DBHelper.insert('user_checks', {
      'id': newCheck.id,
      'payTo': newCheck.payTo,
      'bankName': newCheck.bankName,
      'amount': newCheck.amount,
      // 'date': newCheck.date,
    });
  }


  Future<void> fetchAndSetChecks() async {
    final dataList = await DBHelper.getData('user_checks');
    _items = dataList
        .map(
          (item) => Check(
            id: item['id'],
            payTo: item['payTo'],
            bankName: item['bankName'],
            amount: item['amount'],
            // date: item['date'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
