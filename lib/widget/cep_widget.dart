import 'package:flutter/material.dart';

import '../model/back4app_cep.dart';

class CepWidget extends StatefulWidget {
  final Back4AppCEP result;
  final Function(Back4AppCEP back4appCEP) deleteCep;
  final Function(Back4AppCEP back4appCEP, GlobalKey<FormState> form) updateCep;

  const CepWidget(
      {super.key,
      required this.result,
      required this.deleteCep,
      required this.updateCep});

  @override
  State<CepWidget> createState() => _CepWidgetState();
}

class _CepWidgetState extends State<CepWidget> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide()),
                ),
                child: Text("CEP: ${widget.result.cep.toString()}"),
              ),
              Text("Bairro: ${widget.result.bairro.toString()}"),
              Text("Complemento: ${widget.result.complemento.toString()}"),
              Text("DDD: ${widget.result.ddd.toString()}"),
              Text("Gia: ${widget.result.gia.toString()}"),
              Text("IBGE: ${widget.result.ibge.toString()}"),
              Text("Localidade: ${widget.result.localidade.toString()}"),
              Text("Logradouro: ${widget.result.logradouro.toString()}"),
              Text("SIAFI: ${widget.result.siafi.toString()}"),
              Text("UF: ${widget.result.uf.toString()}"),
            ],
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: ContinuousRectangleBorder(),
                  side: BorderSide(color: Colors.black, width: 0.5)),
              onPressed: () {
                widget.updateCep(widget.result, _form);
              },
              child: Icon(Icons.upload),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: ContinuousRectangleBorder(),
                  side: BorderSide(color: Colors.black, width: 0.5)),
              onPressed: () => widget.deleteCep(widget.result),
              child: Icon(Icons.delete),
            ),
          ],
        )
      ],
    );
  }
}
