import '../data/datasource/back4app_source.dart';
import '../model/back4app_cep.dart';

class RegistroPageController {
  late Back4appSource back4appSource;
  List<Back4AppCEP> cepList = [];
  RegistroPageController() {
    back4appSource = Back4appSource();
    getBack4AppCEPList();
  }

  Future<List<Back4AppCEP>> getBack4AppCEPList() async {
    cepList = await back4appSource.get() ?? [];
    return cepList;
  }

  Future<void> updateBack4AppCEPList(Back4AppCEP back4appCEP) async {
    back4appSource.update(
      back4appCEP,
    );

    getBack4AppCEPList();
  }

  Future<void> deletBack4AppCEPList(Back4AppCEP back4appCEP) async {
    back4appSource.delet(
      back4appCEP,
    );

    getBack4AppCEPList();
  }
}
