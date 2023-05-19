import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAsistenciaPage extends StatefulWidget {
  const AddAsistenciaPage({super.key});
  @override
  State<AddAsistenciaPage> createState() => _AddAsistenciaPageState();
}

class _AddAsistenciaPageState extends State<AddAsistenciaPage> {
  String? docenteS;
  List<String> listaDocentes = [];
  TextEditingController docente = TextEditingController();
  TextEditingController fecha_hora = TextEditingController();
  TextEditingController revisor = TextEditingController();
  TextEditingController fechaHoraController = TextEditingController();

  void capturarFechaHoraSistema() {
    DateTime now = DateTime.now(); // Obtiene la fecha y hora actual del sistema
    String fechaHora = DateFormat('yyyy-MM-dd HH:mm:ss').format(now); // Formatea la fecha y hora
    fechaHoraController.text = fechaHora; // Establece el valor en el controlador
  }
  @override
  void initState() {
    super.initState();
    obtenerYcargardocenteS();
    capturarFechaHoraSistema();
  }

  Future<void> obtenerYcargardocenteS() async {
    List<String> docenteSObtenidas = await docentes(); // Obtener la lista de docentes
    setState(() {
      listaDocentes = docenteSObtenidas;
      docenteS = listaDocentes.isNotEmpty ? listaDocentes[0] : null;
      docente.text = docenteS ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar asistencia'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          DropdownButtonFormField<String>(
            value: docenteS,
            items: listaDocentes.map((String valor) {
              return DropdownMenuItem<String>(
                value: valor,
                child: Text(valor),
              );
            }).toList(),
            onChanged: (String? valorSeleccionado) {
              setState(() {
                docenteS = valorSeleccionado;
                docente.text = valorSeleccionado ?? '';
              });
            },
            decoration: InputDecoration(
              labelText: 'Selecciona una docente',
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: docente,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'docente seleccionado',
            ),
          ),
          TextField(
            decoration: InputDecoration(labelText: "FECHA Y HORA"),
            controller: fechaHoraController,
            enabled: false,
            autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "REVISOR"),
            controller: revisor,
            autofocus: true,
          ),
          ElevatedButton(
              onPressed: () async {
                await addasis(
                    docente.text,
                    fechaHoraController.text,
                    revisor.text,
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
