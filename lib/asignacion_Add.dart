import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAsignadoPage extends StatefulWidget {
  const AddAsignadoPage({super.key});
  @override
  State<AddAsignadoPage> createState() => _AddAsignadoPageState();
}

class _AddAsignadoPageState extends State<AddAsignadoPage> {
  TextEditingController docente = TextEditingController();
  TextEditingController materia = TextEditingController();
  TextEditingController horario = TextEditingController();
  TextEditingController edificio = TextEditingController();
  TextEditingController salon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar asignacion'),
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
          ElevatedButton(
              onPressed: () async {
                await addasig(
                    docente.text,
                    materia.text,
                    horario.text,
                    edificio.text,
                    salon.text,
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
