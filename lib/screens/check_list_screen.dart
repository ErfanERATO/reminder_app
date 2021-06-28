//این صفحه برای نمایش اطلاعات ورودی توسط کاربر میباشد
//ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import './add_check_screen.dart';
import '../providers/great_check.dart';

class CheckListScreen extends StatelessWidget {
  // final formatter = new NumberFormat("###,###,###,###,###");
  @override
  Widget build(BuildContext context) {
    //ساخت ساختمان اولیه نمایش چک ها
    return Scaffold(
      appBar: AppBar(
        title: Text('چک های شما'),

        // دکمه Add برای منتقل شدن به صفحه اضافه کردن چک
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddCheckScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
        Provider.of<GreatCheck>(context, listen: false).fetchAndSetChecks(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
            ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<GreatCheck>(
          child: Center(
            child: const Text('Got no places yet, start adding some!'),
          ),
          builder: (ctx, greatCheck, ch) => ListView.builder(
            itemCount: greatCheck.items.length,
            //GestureDetector برای اضافه کردن خاصیت کلیک شدن هر چک
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () {
                print("card pressed");
              },

              //ساخت فیلد نمایش عناوین پرداخت در وجه‌/ نام بانک / مبلغ چک / تاریخ سر رسید /  زمان یادآوری
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //فیلد نمایش نام شخص گیرنده چک
                        Text(
                          'در وجه: ' + greatCheck.items[i].payTo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ],
                    ),

                    //فیلد نمایش نام بانک
                    Text(
                      'بانک: ' + greatCheck.items[i].bankName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blueGrey),
                    ),
                    // Text('مبلغ چک: ' + formatter.format(greatCheck.items[i].amount.toString()),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),

                    //فیلد نمایش مبلغ چک
                    Text(
                      'مبلغ چک: ' + greatCheck.items[i].amount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blueGrey),
                    ),

                    //فیلد نمایش تاریخ انتخابی کاربر
                    Text(
                      'تاریخ سرسید: ' +
                          DateFormat.yMMMd()
                              .format(DateTime.parse(
                              greatCheck.items[i].date))
                              .toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blueGrey),
                    ),

                    // DateFormat.yMMMd()
                    //     .format(greatCheck.items[i].date)).toString(),
                    //فیلد نمایش ساعت انتخابی توسط کاربر
                    // Text(
                    //   'زمان یادآوری: ',
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 15,
                    //       color: Colors.blueGrey),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//formatter.format(this.checkList[index].amount.toString()),
