import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class C2 extends StatefulWidget {
  @override
  _C2State createState() =>
      _C2State();
}

class _C2State
    extends State<C2> {
  TextEditingController _revisorController = TextEditingController();
  List<Map<String, dynamic>> _asistencias = [];

  void _buscarAsistencias() async {
    String revisor = _revisorController.text.trim();

    if (revisor.isNotEmpty) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('asistencia')
            .where('revisor', isEqualTo: revisor)
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
          content: Text('Ingrese un revisor.'),
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
        title: Text('Buscar Asistencias por Revisor'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _revisorController,
              decoration: InputDecoration(
                labelText: 'Revisor',
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
            if (_asistencias.isEmpty)
              Text('No se encontraron asistencias.'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _asistencias.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> asistencia = _asistencias[index];
                return ListTile(
                  title: Text('${asistencia["docente"]}'),
                  subtitle: Text('${asistencia["fecha/hora"]}'),
                  trailing:Text('${asistencia["revisor"]}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
