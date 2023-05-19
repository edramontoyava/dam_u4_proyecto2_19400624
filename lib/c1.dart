import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class C1 extends StatefulWidget {
  @override
  _C1State createState() => _C1State();
}

class _C1State extends State<C1> {
  String? docenteS;
  List<String> listaDocentes = [];
  TextEditingController _docenteController = TextEditingController();
  List<Map<String, dynamic>> _asistencias = [];

  @override
  void initState() {
    super.initState();
    obtenerYcargardocenteS();
  }

  void obtenerYcargardocenteS() async {
    try {
      List<String> docenteSObtenidas = await docentes(); // Obtener la lista de docentes
      setState(() {
        listaDocentes = docenteSObtenidas;
        docenteS = listaDocentes.isNotEmpty ? listaDocentes[0] : null;
        _docenteController.text = docenteS ?? '';
      });
    } catch (e) {
      print('Error al obtener los docentes: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Ocurrió un error al obtener los docentes.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _buscarAsistencias() async {
    String docente = _docenteController.text.trim();

    if (docente.isNotEmpty) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('asistencia')
            .where('docente', isEqualTo: docente)
            .get();

        List<Map<String, dynamic>> asistencias = [];

        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
          DateTime fechaHora = (data["fecha/hora"] as Timestamp).toDate();
          Map<String, dynamic> asistencia = {
            "uid": doc.id,
            "docente": data["docente"],
            "fecha/hora": DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaHora),
            "revisor": data["revisor"],
          };
          asistencias.add(asistencia);
        }

        setState(() {
          _asistencias = asistencias;
        });
      } catch (e) {
        print('Error al buscar asistencias: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Ocurrió un error al buscar asistencias.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Ingrese un docente.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Asistencias por Docente'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  _docenteController.text = valorSeleccionado ?? '';
                });
              },
              decoration: InputDecoration(
                labelText: 'Selecciona un docente',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _docenteController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Docente seleccionado',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _buscarAsistencias,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Asistencias encontradas:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            if (_asistencias.isEmpty) Text('No se encontraron asistencias.'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _asistencias.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> asistencia = _asistencias[index];
                return ListTile(
                  title: Text('${asistencia["docente"]}'),
                  subtitle: Text('${asistencia["fecha/hora"]}'),
                  trailing: Text('${asistencia["revisor"]}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
