import 'dart:convert';

AppInfo appInfoFromJson(String str) => AppInfo.fromJson(json.decode(str));

String appInfoToJson(AppInfo data) => json.encode(data.toJson());

class AppInfo {
  AppInfo({
    required this.version,
    required this.isMandatory,
  });

  String version;
  String isMandatory;

  factory AppInfo.fromJson(Map<String, dynamic> json) => AppInfo(
    version: json["Version"],
    isMandatory: json["IsMandatory"],
  );

  Map<String, dynamic> toJson() => {
    "Version": version,
    "IsMandatory": isMandatory,
  };
}
