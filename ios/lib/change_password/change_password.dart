import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../api_link.dart';
import '../components/colors.dart';
import '../dll.dart';
import '../main.dart';
import '../switch_screen/switch_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with DLL {
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController oldPassword =  TextEditingController();
  TextEditingController newPassword =  TextEditingController();
  TextEditingController confirmPassword =  TextEditingController();

  bool isLoading = false;

  bool isVisibleOld = true;
  bool isVisibleNew = true;
  bool isVisibleConfirm = true;

  updatePass() async {

    try {
      if (formState.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await postRequest(

            "$linkServerName/Login/UpdatePass.php", {
          "CusCode": sharedPref.getString("S_CusCode"),
          "CusPass": oldPassword.text,
          "NewCusPass": newPassword.text,});
        //installedApps.toString()
        isLoading = false;
        setState(() {});
        if (response['status'] == "success") {

          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: const Center(
                      child: Text('')
                  ),
                  content: const Text('تم تغيير كلمه السر بنجاح'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('دخول'),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SwitchScreen(
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              });

        } else {
          AwesomeDialog(
              context: context,
              showCloseIcon: true,
              title: "Alert",
              body: const Text(
                  "كلمه السر الحاليه غير صحيحه"))
              .show();
        }
      }
    } catch (e) {
      AwesomeDialog(
          context: context,
          showCloseIcon: true,
          title: "Alert",
          body: Text(e.toString()))
          .show();
    }
  }

  @override
  void initState() {
    super.initState();
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
              height: 50,
            ),
          ),
        ],
        title: const Text
          (
          "تغيير كلمه السر",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children:
            [
              Container(
              ),
              Image.asset(
                'assets/images/Logo.png',
                width: 240,
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formState,
                  child: Column(
                    children:
                    [
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: oldPassword,
                        validator: (val) {if ((val)!.isEmpty){return "كلمه السر الحاليه غير موجوده";}return null;},
                        enabled: true,
                        readOnly: false,
                        obscureText:  isVisibleOld,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kMainColor
                            ),
                          ),
                          labelText: 'كلمه السر الحاليه',
                          labelStyle: const TextStyle(
                            color: kMainColor,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: kMainColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isVisibleOld = !isVisibleOld;
                              });
                            },
                            icon:
                            Icon(
                              isVisibleOld ? Icons.visibility_off : Icons.visibility,
                              color: kMainColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: newPassword,
                        validator: (val) {if ((val)!.isEmpty){return "كلمه السر الجديده غير موجوده";}return null;},
                        enabled: true,
                        readOnly: false,
                        obscureText: isVisibleNew,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kMainColor,
                            ),
                          ),
                          labelText: 'كلمه السر الجديده',
                          labelStyle: const TextStyle(
                            color: kMainColor,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: kMainColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibleNew = !isVisibleNew;
                              });
                            },
                            icon:
                            Icon(
                              isVisibleNew ? Icons.visibility_off : Icons.visibility,
                              color: kMainColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: confirmPassword,
                        validator: (val) {
                          if(val!.isEmpty) {
                            return 'كلمه السر الجديده غير موجوده';
                          }
                          if(val != newPassword.text) {
                            return 'كلمه السر غير متطابقه';
                          }
                          return null;
                        },
                        enabled: true,
                        readOnly: false,
                        obscureText: isVisibleConfirm,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kMainColor,
                            ),
                          ),
                          labelText: 'تأكيد كلمه السر',
                          labelStyle: const TextStyle(
                            color: kMainColor,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: kMainColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibleConfirm = !isVisibleConfirm;
                              });
                            },
                            icon:
                            Icon(
                              isVisibleConfirm ? Icons.visibility_off : Icons.visibility,                                color: kMainColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: 170.0,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: Colors.white,
                            backgroundColor: kMainColor,
                            textStyle: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          child: const Text(
                            'تغيير',
                          ),
                          onPressed: () async {
                            await updatePass();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
