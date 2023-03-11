import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/app_info.dart';
import 'api_link.dart';
import 'package:package_info_plus/package_info_plus.dart';


class APIManger{
  static String appinfoIsMandory = "" ;
  static String appVersion = "" ;
  static String appCurrentVerison = "" ;

  static Future<AppInfo> GetAppInfo() async {
    Map<String, String> data = {"CoName":"DyeHouse"};
    try{
      var response = await http.post(Uri.parse(appsSetting)
          ,body: data);
      var res = jsonDecode(response.body) ;

      AppInfo appInfo = AppInfo(version: res["data"][0]["Version"], isMandatory: res["data"][0]["IsMandatory"]);
       APIManger.appinfoIsMandory = res["data"][0]["IsMandatory"];
       APIManger.appVersion = res["data"][0]["Version"];

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      APIManger.appCurrentVerison = packageInfo.version;

      return appInfo;

    }catch(e){

    }
    return AppInfo(version: "", isMandatory: "");
  }
}