// این صحفه برای گرفتن ورودی اطلاعات کاربر هست
//ــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_check.dart';
import 'package:intl/intl.dart';

class AddCheckScreen extends StatefulWidget {
  static const routeName = '/add-check';

  @override
  _AddCheckScreenState createState() => _AddCheckScreenState();
}

class _AddCheckScreenState extends State<AddCheckScreen> {

  //ساخت تقویم برای نمایش تاریخ
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(DateTime.now().year + 15),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('xxxx');
  }


  DateTime? _selectedDate;
  final _payToController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _amountController = TextEditingController();

  Future<void> _saveCheck() async {
    final enteredPayTo = _payToController.text;
    final enteredBankName = _bankNameController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredPayTo.isEmpty || enteredBankName.isEmpty || enteredAmount <=0 || _selectedDate == null){
      return;
    }
    // if (enteredPayTo.isEmpty || enteredBankName.isEmpty || enteredAmount <=0 || _selectedDate == null){
    //   return;
    // }
    // Provider.of<GreatCheck>(context, listen: false)
    //     .addCheck(_payToController.text, _bankNameController.text, double.parse(_amountController.text),_selectedDate!,);
    // Navigator.of(context).pop();
    Provider.of<GreatCheck>(context, listen: false)
        .addCheck(_payToController.text, _bankNameController.text, double.parse(_amountController.text) , _selectedDate!,);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافه کردن چک جدید'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    //فیلد دریافت پرداخت در وجه
                    TextField(
                      decoration: InputDecoration(labelText: 'در وجه'),
                      controller: _payToController,
                    ),
                    //فیلد دریافت نام بانک
                    TextField(
                      decoration: InputDecoration(labelText: 'نام بانک'),
                      controller: _bankNameController,
                    ),
                    //فیلد دریافت مبلغ چک
                    TextField(
                      decoration: InputDecoration(labelText: 'مبلغ'),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                    ),

                    //فیلد دریافت تاریخ ورودی کاربر
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(_selectedDate == null
                                  ? 'هنوز تاریخ مشخص نشده'
                                  : DateFormat.yMd().format(_selectedDate!))),
                          TextButton(
                            child: Text(
                              "تاریخ را مشخص کنید",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //ساخت دکمه برای تایید ورودی های کاربر
          // ignore: deprecated_member_use
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('اضافه کردن چک'),
            onPressed: _saveCheck,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
