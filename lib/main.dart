// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_password/change_password.dart';
import 'login/login_screen.dart';
import 'switch_screen/switch_screen.dart';


 SharedPreferences sharedPref;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale> [
        Locale('en'),
        Locale('ar'),// Arabic,
      ],
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      initialRoute: "login_screen",
      routes: {
        "login_screen" : (context) =>  const LoginScreen() ,
        "switch_screen" : (context) =>  const SwitchScreen(),
        "change_password" : (context) =>  const ChangePassword(),
      },
    );
  }
}

