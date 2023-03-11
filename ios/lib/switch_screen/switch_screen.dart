import 'package:flutter/material.dart';
import '../change_password/change_password.dart';
import '../coming_soon.dart';
import '../components/colors.dart';
import '../data_tables/color_coding.dart';
import '../data_tables/finstock_detail.dart';
import '../data_tables/rawstore_detail.dart';
import '../data_tables/rawstore_total.dart';
import '../data_tables/show_pass.dart';
import '../data_tables/under_process.dart';
import '../main.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({Key? key}) : super(key: key);

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {

  bool isOwner = false;

  @override
  void initState() {
    super.initState();
    if (sharedPref.getString("S_UserType") == '0') {
      isOwner = false;
    } else {
      isOwner = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: kMainColor,
        actions: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              'assets/images/Logo.png',
              width: 50,
            ),
          ),
        ],
        title: const Center(
          child: Text(
            "الرئيسيه",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 7, top: 25),
            height: 104,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 17),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kSecondaryColor, kMainColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.5],
                  tileMode: TileMode.repeated,
                ),
                //color: Color(0xff7B89CA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      offset: const Offset(-7.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0),
                ],
              ),
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/RawStore02.png"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const RawstoreDetail(),
                          ),
                        );
                      },
                      child: const Text(
                        'رصيد الخام مفصل',
                        style: TextStyle(
                            color: Color(0xFFe0e0e0),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            height: 104,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 17),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kSecondaryColor, kMainColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.5],
                  tileMode: TileMode.repeated,
                ),
                //color: Color(0xff7B89CA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      offset: const Offset(-7.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0),
                ],
              ),
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage("assets/images/RawStore01.jpg"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RawStoreTotal(),
                          ),
                        );
                      },
                      child: const Text(
                        'رصيد الخام مجمع',
                        style: TextStyle(
                            color: Color(0xFFe0e0e0),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            height: 104,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 17),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kSecondaryColor, kMainColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.5],
                  tileMode: TileMode.repeated,
                ),
                //color: Color(0xff7B89CA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      offset: const Offset(-7.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0),
                ],
              ),
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/FinishedStock.png"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FinstockDetail(),
                          ),
                        );
                      },
                      child: const Text(
                        'رصيد الجاهز مفصل',
                        style: TextStyle(
                            color: Color(0xFFe0e0e0),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            height: 104,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 17),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kSecondaryColor, kMainColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.5],
                  tileMode: TileMode.repeated,
                ),
                //color: Color(0xff7B89CA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      offset: const Offset(-7.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0),
                ],
              ),
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/UnderProcess.png"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UnderProcess(),
                          ),
                        );
                      },
                      child: const Text(
                        'تحت التشغيل',
                        style: TextStyle(
                            color: Color(0xFFe0e0e0),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            height: 104,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 17),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kSecondaryColor, kMainColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.5],
                  tileMode: TileMode.repeated,
                ),
                //color: Color(0xff7B89CA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      offset: const Offset(-7.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0),
                ],
              ),
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/color.png"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ColorCoding(),
                          ),
                        );
                      },
                      child: const Text(
                        'كارتله الالوان',
                        style: TextStyle(
                            color: Color(0xFFe0e0e0),
                            fontSize:21,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            height: 104,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 17),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kSecondaryColor, kMainColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.5],
                  tileMode: TileMode.repeated,
                ),
                //color: Color(0xff7B89CA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      offset: const Offset(-7.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0),
                ],
              ),
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/colours.png"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CommingSoon(),
                          ),
                        );
                      },
                      child: const Text(
                        'طلب التشكيل',
                        style: TextStyle(
                            color: Color(0xFFe0e0e0),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isOwner,
            child: Container(
              margin: const EdgeInsets.only(bottom: 7),
              height: 104,
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 17),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kSecondaryColor, kMainColor],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.1, 0.5],
                    tileMode: TileMode.repeated,
                  ),
                  //color: Color(0xff7B89CA),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(75.0),
                    bottomRight: Radius.circular(75.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: kMainColor.withOpacity(0.3),
                        offset: const Offset(-7.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 3.0),
                  ],
                ),
                padding: const EdgeInsets.only(
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: MediaQuery.of(context).size.height * 0.23,
                      child: const CircleAvatar(
                        backgroundImage:
                        AssetImage("assets/images/show-password.png"),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShowPass(),
                            ),
                          );
                        },
                        child: const Text(
                          'عرض كلمه السر',
                          style: TextStyle(
                              color: Color(0xFFe0e0e0),
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            height: 104,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 17),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kSecondaryColor, kMainColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.1, 0.5],
                  tileMode: TileMode.repeated,
                ),
                //color: Color(0xff7B89CA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: kMainColor.withOpacity(0.3),
                      offset: const Offset(-7.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0),
                ],
              ),
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/ChangePass.png"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'تغيير كلمه السر',
                        style: TextStyle(
                            color: Color(0xFFe0e0e0),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
