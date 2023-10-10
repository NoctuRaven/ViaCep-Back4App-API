import 'package:flutter/material.dart';
import 'package:viacep/pages/registro_page.dart';
import '../controller/home_page_controller.dart';
import '../data/datasource/back4app_source.dart';
import '../data/datasource/viacep_source.dart';
import '../model/viacep.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late HomePageController controller;
  String? cep;

  @override
  void initState() {
    // TODO: implement initState
    controller = HomePageController(
      viaCEPSource: ViaCEPSource(),
      back4appSource: Back4appSource(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        height: 100,
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegistroPage(),
              ),
            );
          },
          child: Column(
            children: [
              Expanded(
                child: Icon(
                  Icons.dataset_outlined,
                  size: 50,
                ),
              ),
              Text("Registro"),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(
            //     'assets/images/background.png',
            //   ),
            //   fit: BoxFit.fill,
            // ),
            ),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  width: double.maxFinite,
                  alignment: Alignment(-0.9, 0),
                  height: 170,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text(
                    'ViaCEP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 100,
                        color: Colors.white),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 10,
                  decoration: BoxDecoration(color: Colors.yellow),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Pesquisar CEP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      maxLength: 9,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        var regex = RegExp(r'\d{5}-\d{3}');
                        if (value == "" || value == null || value.length < 9) {
                          return "Insira um CEP valido ";
                        } else if (!regex.hasMatch(value)) {
                          return "insira apenas os números";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) async {
                        setState(() {
                          cep = newValue;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                      child: const Text('OK')),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: cep == null
                  ? Image.asset(
                      'assets/images/mapa.png',
                      height: 100,
                      color: Colors.grey,
                    )
                  : FutureBuilder(
                      future: controller.getCEP(cep!),
                      builder: (context, snapshot) {
                        Widget child;
                        if (snapshot.hasData) {
                          ViaCEP result = snapshot.data!;
                          if (result.cep == null) {
                            child = Text('CEP inválido');
                          } else {
                            child = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CEP: ${result.cep.toString()}"),
                                Text("Bairro: ${result.bairro.toString()}"),
                                Text(
                                    "Complemento: ${result.complemento.toString()}"),
                                Text("DDD: ${result.ddd.toString()}"),
                                Text("Gia: ${result.gia.toString()}"),
                                Text("IBGE: ${result.ibge.toString()}"),
                                Text(
                                    "Localidade: ${result.localidade.toString()}"),
                                Text(
                                    "Logradouro: ${result.logradouro.toString()}"),
                                Text("SIAFI: ${result.siafi.toString()}"),
                                Text("UF: ${result.uf.toString()}"),
                              ],
                            );
                          }
                        } else if (snapshot.hasError) {
                          child = Text("Error");
                        } else {
                          child = CircularProgressIndicator();
                        }
                        return child;
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
