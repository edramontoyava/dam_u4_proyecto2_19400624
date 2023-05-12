import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAutoPage extends StatefulWidget {
  const AddAutoPage({super.key});
  @override
  State<AddAutoPage> createState() => _AddAutoPageState();
}

class _AddAutoPageState extends State<AddAutoPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar vehiculo'),
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
          ElevatedButton(
              onPressed: () async {
                await addAuto(
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
              child: const Text("Guardar"))
        ],
      ),
    );
  }
}
