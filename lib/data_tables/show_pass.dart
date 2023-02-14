import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api_link.dart';
import '../components/colors.dart';
import '../dll.dart';
import '../switch_screen/switch_screen.dart';

class ShowPass extends StatefulWidget {
  const ShowPass({Key? key}) : super(key: key);

  @override
  State<ShowPass> createState() => _ShowPassState();
}

class _ShowPassState extends State<ShowPass> with DLL {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController code =  TextEditingController();
  bool isLoading = false;

  loginFunction() async {

    try {
      if (formState.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await postRequest("$linkServerName/Login/ShowPass.php", {"CusCode": code.text});
        isLoading = false;
        setState(() {});
        if (response['status'] == "success") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: "الرقم السري للعميل",
            desc: response["data"][0]["CusPass"].toString(),
            descTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            btnCancelOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SwitchScreen(
                  ),
                ),
              );
            },
            btnCancelText: 'تم',
            btnCancelColor: kMainColor,
          ).show();
        }
        else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'خطأ',
            desc:
            "الكود غير صحيح برجاء التأكد واعاده المحاوله",
            btnCancelOnPress: () {},
            btnCancelText: 'إلغاء',
            btnCancelColor: Colors.red,
          ).show();
        }
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'خطأ',
        desc:
        "الرجاء التأكد من الاتصال بالإنترنت",
        btnCancelOnPress: () {},
        btnCancelText: 'إلغاء',
        btnCancelColor: Colors.red,
      ).show();
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
        title: const Center(
          child: Text
            (
            "عرض كلمه السر",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),

      ),
      body: isLoading == true
          ? const Center(
        child: CircularProgressIndicator(),
      )
          :Center(
        child: SingleChildScrollView(
          child: Column(
            children:
            [
              Image.asset(
                'assets/images/Logo.png',
                width: 120,
                height: 120,
              ),
              Container(
                padding: const EdgeInsets.all(50),
                child: Form(
                  key: formState,
                  child: Column(
                    children:
                    [
                      TextFormField(
                        controller: code,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: (val) {if ((val)!.isEmpty){return "الكود غير صحيح";}return null;} ,
                        enabled: true,
                        readOnly: false,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kMainColor,
                            ),
                          ),
                          labelText: 'كود العميل',
                          labelStyle: TextStyle(
                            color: kMainColor,
                          ),
                          prefixIcon: Icon(
                            Icons.account_box,
                            color: kMainColor,
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
                            'عرض',
                          ),
                          onPressed: () async {
                            await loginFunction();
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