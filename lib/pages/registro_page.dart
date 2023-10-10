import 'package:flutter/material.dart';

import '../controller/registro_page_controller.dart';
import '../model/back4app_cep.dart';
import '../widget/cep_widget.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  late RegistroPageController registroPageController;

  @override
  void initState() {
    registroPageController = RegistroPageController();
    super.initState();
  }

  void deleteCepOnBack4App(Back4AppCEP back4appCEP) {
    registroPageController.deletBack4AppCEPList(back4appCEP);
    setState(() {});
  }

  void updateCepOnBack4App(Back4AppCEP back4appCEP, GlobalKey<FormState> form) {
    openDialog(back4appCEP, form);
  }

  openDialog(Back4AppCEP result, GlobalKey<FormState> form) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alterar registro"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (form.currentState!.validate()) {
                    form.currentState!.save();
                    setState(() {
                      registroPageController.updateBack4AppCEPList(result);
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text("OK")),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
          ],
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: form,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLength: 9,
                          initialValue: result.cep,
                          decoration: InputDecoration(
                            labelText: "CEP",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            var regex = RegExp(r'\d{5}-\d{3}');
                            if (value == "" || value == null) {
                              return "Insira um CEP valido ";
                            } else if (!regex.hasMatch(value)) {
                              return "insira apenas os números";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) async {
                            result.cep = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.bairro,
                          decoration: InputDecoration(
                            labelText: "Bairro",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.bairro = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.complemento,
                          decoration: InputDecoration(
                            labelText: "Complemento",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.complemento = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.ddd,
                          decoration: InputDecoration(
                            labelText: "DDD",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.ddd = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.gia,
                          decoration: InputDecoration(
                            labelText: "Gia",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.gia = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.ibge,
                          decoration: InputDecoration(
                            labelText: "IBGE",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.ibge = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.localidade,
                          decoration: InputDecoration(
                            labelText: "Localidade",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.localidade = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.logradouro,
                          decoration: InputDecoration(
                            labelText: "Logradouro",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.logradouro = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.siafi,
                          decoration: InputDecoration(
                            labelText: "Siafi",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.siafi = newValue!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: result.uf,
                          decoration: InputDecoration(
                            labelText: "UF",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (newValue) async {
                            result.uf = newValue!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "ViaCEP: Registros",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 20,
              color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        decoration: const BoxDecoration(),
        child: Center(
          child: FutureBuilder(
            future: registroPageController.getBack4AppCEPList(),
            builder: (context, snapshot) {
              Widget child;
              if (snapshot.hasData) {
                child = ListView.builder(
                  itemCount: (snapshot.data ?? []).length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CepWidget(
                          result: snapshot.data![index],
                          deleteCep: deleteCepOnBack4App,
                          updateCep: updateCepOnBack4App),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                child = const Text("error");
              } else {
                child = const CircularProgressIndicator();
              }
              return child;
            },
          ),
        ),
      ),
    );
  }
}
