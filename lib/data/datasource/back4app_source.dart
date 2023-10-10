import 'dart:convert';

import 'package:dio/dio.dart';

import '../../model/back4app_cep.dart';
import '../../model/viacep.dart';

class Back4appSource {
  late Dio dio;
  Back4appSource() {
    dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "IBF2EPqVIW0VKysmP7DVyAmhRrCJ8kKLPJ8atSBI";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "3Y9Axrs6gVBgoFEghD4J2NswE2866J031aYTC43E";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.baseUrl = "https://parseapi.back4app.com/classes";
  }

  Future<List<Back4AppCEP>?> get() async {
    String url = '/ViaCep';
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      List<dynamic> data = response.data["results"];
      return data.map((e) => Back4AppCEP.fromJson(e)).toList();
    }
    return null;
  }

  Future<void> create(ViaCEP viaCEP) async {
    if (viaCEP.cep == null) {
      return;
    }
    try {
      await dio.post("/ViaCep", data: viaCEP.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> update(Back4AppCEP back4appCEP) async {
    try {
      await dio.put("/ViaCep/${back4appCEP.objectId}",
          data: back4appCEP.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> delet(Back4AppCEP back4appCEP) async {
    try {
      await dio.delete(
        "/ViaCep/${back4appCEP.objectId}",
      );
    } catch (e) {
      print(e);
      return;
    }
  }
}
