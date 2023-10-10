import 'package:dio/dio.dart';

import '../../model/viacep.dart';

class ViaCEPSource {
  Future<ViaCEP?> getCEP(String cep) async {
    var response = await Dio().get('http://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      return ViaCEP.fromJson(response.data);
    }
    return null;
  }
}
