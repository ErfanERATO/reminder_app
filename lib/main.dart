import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/great_check.dart';
import './screens/check_list_screen.dart';
import './screens/add_check_screen.dart';

//نقطه آغاز به کار نرم افزار
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      //مقداری value باید instance باشه
      value: GreatCheck(),
      child: MaterialApp(
          title: 'چک‌من',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //صفحه اصلی نرم افزار و تعیین راست چین ای چپ چین بودن آن
          // home: CheckListScreen(),
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: CheckListScreen(),
          ),
          // مشخص کردن Navigation دکمه ها
          routes: {
            AddCheckScreen.routeName: (ctx) => AddCheckScreen(),
          }),
    );
  }
}
