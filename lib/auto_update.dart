import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';

class UpdateAutoPage extends StatefulWidget {
  const UpdateAutoPage({super.key});
  @override
  State<UpdateAutoPage> createState() => _UpdateAutoPageState();
}

class _UpdateAutoPageState extends State<UpdateAutoPage> {
  TextEditingController placa = TextEditingController();
  TextEditingController tipo = TextEditingController();
  TextEditingController numeroserie = TextEditingController();
  TextEditingController depto = TextEditingController();
  TextEditingController trabajador = TextEditingController();
  TextEditingController resguardadopor = TextEditingController();
  TextEditingController combustible = TextEditingController();
  TextEditingController tanque = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
     placa.text = arguments['placa'];
     tipo.text = arguments['tipo'];
     numeroserie.text = arguments['numeroserie'];
     depto.text = arguments['depto'];
     trabajador.text = arguments['trabajador'];
     resguardadopor.text = arguments['resguardadopor'];
     combustible.text = arguments['combustible'];
     tanque.text = arguments['tanque'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar vehiculo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          TextField(
            decoration: InputDecoration(labelText: "PLACA"),
            controller: placa,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "TIPO"),
            controller: tipo,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "NUMERO DE SERIE"),
            controller: numeroserie,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "DEPARTAMENTO"),
            controller: depto,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "TRABAJADOR"),
            controller: trabajador,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "RESGUARDADO POR..."),
            controller: resguardadopor,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "COMBUSTIBLE"),
            controller: combustible,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "TANQUE"),
            controller: tanque,
            autofocus: true,
          ),
          Text(
            arguments['uid'],
            style: const TextStyle(fontSize: 10),
          ),
          ElevatedButton(
              onPressed: () async {
                await updateAuto(
                    arguments['uid'],
                    placa.text,
                    tipo.text,
                    numeroserie.text,
                    depto.text,
                    trabajador.text,
                    resguardadopor.text,
                    combustible.text,
                    tanque.text
                ).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Actualizar"))
        ],
      ),
    );
  }
}
