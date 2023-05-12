import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateBitPage extends StatefulWidget {
  const UpdateBitPage({super.key});
  @override
  State<UpdateBitPage> createState() => _UpdateBitPageState();
}

class _UpdateBitPageState extends State<UpdateBitPage> {
  TextEditingController placa = TextEditingController();
  TextEditingController evento = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController recursos = TextEditingController();
  TextEditingController verifico = TextEditingController();
  TextEditingController fechaverificacion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    placa.text = arguments['placa'];
    evento.text = arguments['evento'];
    fecha.text = arguments['fecha'];
    recursos.text = arguments['recursos'];
    verifico.text = arguments['verifico'];
    fechaverificacion.text = arguments['fechaverificacion'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar bitacora'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          TextField(
            decoration: InputDecoration(labelText: "VERIFICO"),
            controller: verifico,
            autofocus: true,
          ),
          TextField(
            decoration:
                InputDecoration(labelText: "FECHA DE VERIFICACION(yyyy-MM-dd)"),
            controller: fechaverificacion,
            autofocus: true,
          ),
          Text(
            arguments['uid'],
            style: const TextStyle(fontSize: 10),
          ),
          ElevatedButton(
            onPressed: () async {
              await updateBit(
                placa.text,
                evento.text,
                DateTime.parse(fecha.text),
                recursos.text,
                arguments['uid'],
                verifico.text,
                DateTime.parse(fechaverificacion.text),
              ).then((_) {
                Navigator.pop(context);
              });
            },
            child: const Text("Actualizar"),
          ),
        ],
      ),
    );
  }
}
