import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';

class UpdateAsignadoPage extends StatefulWidget {
  const UpdateAsignadoPage({super.key});
  @override
  State<UpdateAsignadoPage> createState() => _UpdateAsignadoPageState();
}

class _UpdateAsignadoPageState extends State<UpdateAsignadoPage> {
  TextEditingController docente = TextEditingController();
  TextEditingController materia = TextEditingController();
  TextEditingController horario = TextEditingController();
  TextEditingController edificio = TextEditingController();
  TextEditingController salon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    docente.text = arguments['docente'];
    materia.text = arguments['materia'];
    horario.text = arguments['horario'];
    edificio.text = arguments['edificio'];
    salon.text = arguments['salon'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar vehiculo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          TextField(
            decoration: InputDecoration(labelText: "DOCENTE"),
            controller: docente,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "MATERIA"),
            controller: materia,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "HORARIO"),
            controller: horario,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "EDIFICIO"),
            controller: edificio,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "SALON"),
            controller: salon,
            autofocus: true,
          ),
          Text(
            arguments['uid'],
            style: const TextStyle(fontSize: 10),
          ),
          ElevatedButton(
              onPressed: () async {
                await updateasig(
                    arguments['uid'],
                    docente.text,
                    materia.text,
                    horario.text,
                    edificio.text,
                    salon.text
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
