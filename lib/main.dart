import 'package:flutter/material.dart';
import 'package:practice_2_apple_tv/shared_preferences/shared_preferences.dart';
import 'package:practice_2_apple_tv/ui/home_page/home_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey.shade800,
        iconTheme:  const IconThemeData(color: Color(0xffee0342)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Color(0xffee0342),),
          titleMedium: TextStyle(color: Color(0xffee0342)),
          titleSmall: TextStyle(color: Color(0xffee0342), fontSize: 16),
          bodyMedium: TextStyle(color: Colors.grey),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
