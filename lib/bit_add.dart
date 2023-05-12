import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddBitPage extends StatefulWidget {
  const AddBitPage({super.key});
  @override
  State<AddBitPage> createState() => _AddBitPageState();
}

class _AddBitPageState extends State<AddBitPage> {
  String? placaS;
  List<String> listaPlacas = [];
  TextEditingController placa = TextEditingController();
  TextEditingController evento = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController recursos = TextEditingController();
  TextEditingController verifico = TextEditingController();
  TextEditingController fechaverificacion = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerYcargarPlacas();
  }

  Future<void> obtenerYcargarPlacas() async {
    List<String> placasObtenidas = await placas(); // Obtener la lista de placas
    setState(() {
      listaPlacas = placasObtenidas;
      placaS = listaPlacas.isNotEmpty ? listaPlacas[0] : null;
      placa.text = placaS ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar bitacora'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          /*TextField(
            decoration: InputDecoration(labelText: "PLACA"),
            controller: placa,
            autofocus: true,
          ),*/
          DropdownButtonFormField<String>(
            value: placaS,
            items: listaPlacas.map((String valor) {
              return DropdownMenuItem<String>(
                value: valor,
                child: Text(valor),
              );
            }).toList(),
            onChanged: (String? valorSeleccionado) {
              setState(() {
                placaS = valorSeleccionado;
                placa.text = valorSeleccionado ?? '';
              });
            },
            decoration: InputDecoration(
              labelText: 'Selecciona una placa',
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: placa,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Placa seleccionada',
            ),
          ),
          TextField(
            decoration: InputDecoration(labelText: "EVENTO"),
            controller: evento,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "FECHA(yyyy-MM-dd)"),
            controller: fecha,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "RECURSOS"),
            controller: recursos,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "VERIFICO"),
            controller: verifico,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "FECHA DE VERIFICACION(yyyy-MM-dd)"),
            controller: fechaverificacion,
            autofocus: true,
          ),
          ElevatedButton(
              onPressed: () async {
                await addBit(
                    placa.text,
                    evento.text,
                    fecha.text,
                    recursos.text,
                    verifico.text,
                    fechaverificacion.text,
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
