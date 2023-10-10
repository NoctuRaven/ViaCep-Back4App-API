import '../data/datasource/back4app_source.dart';
import '../data/datasource/viacep_source.dart';
import '../model/back4app_cep.dart';
import '../model/viacep.dart';

class HomePageController {
  ViaCEP? cepResult;
  List<Back4AppCEP> back4AppCEPList = [];
  ViaCEPSource viaCEPSource;
  Back4appSource back4appSource;
  HomePageController({
    required this.viaCEPSource,
    required this.back4appSource,
  });

  Future<ViaCEP?> getCEP(String cep) async {
    // getBack4AppCEPList();
    cepResult = await viaCEPSource.getCEP(cep);
    back4AppCEPList = await back4appSource.get() ?? [];

    if (!(back4AppCEPList.any((element) => element.cep == cepResult!.cep))) {
      addCepToBack4App(cepResult!);
    }

    return cepResult;
  }

  Future<List<Back4AppCEP>> getBack4AppCEPList() async {
    // back4AppCEPList = (await back4appSource.getCEP() ?? [])
    //     .map((e) => ViaCEP(
    //           cep: e.cep,
    //           bairro: e.bairro,
    //           complemento: e.complemento,
    //           ddd: e.ddd,
    //           gia: e.gia,
    //           ibge: e.ibge,
    //           localidade: e.localidade,
    //           logradouro: e.logradouro,
    //           siafi: e.siafi,
    //           uf: e.uf,
    //         ))
    //     .toList();
    back4AppCEPList = (await back4appSource.get() ?? []);

    return back4AppCEPList;
  }

  Future<void> addCepToBack4App(ViaCEP viaCEP) async {
    back4appSource.create(viaCEP);
  }
}
