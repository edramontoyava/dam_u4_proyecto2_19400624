import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class C2 extends StatefulWidget {
  @override
  _C2State createState() => _C2State();
}

class _C2State extends State<C2> {
  final TextEditingController _fechaController = TextEditingController();
  List<Map<String, dynamic>> _bitacoras = [];

  void _fetchBitacorasByFecha() async {
    final String fecha = _fechaController.text.trim();

    if (fecha.isEmpty) {
      return;
    }

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bitacora')
        .where('fecha', isEqualTo: Timestamp.fromDate(DateFormat('yyyy-MM-dd').parse(fecha)))
        .get();

    setState(() {
      _bitacoras = querySnapshot.docs
          .map((doc) => {
        "uid": doc.id,
        "placa": doc["placa"],
        "evento": doc["evento"],
        "fecha": DateFormat('yyyy-MM-dd').format((doc["fecha"] as Timestamp).toDate()).toString(),
        "verifico": doc["verifico"],
        "fechaverificacion": DateFormat('yyyy-MM-dd').format((doc["fechaverificacion"] as Timestamp).toDate()).toString(),
        "recursos": doc["recursos"],
      })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitacoras por fecha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fechaController,
              decoration: InputDecoration(
                labelText: 'Ingrese la fecha (yyyy-MM-dd)',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fetchBitacorasByFecha,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _bitacoras.length,
                itemBuilder: (context, index) {
                  final bitacora = _bitacoras[index];
                  return ListTile(
                    title: Text(bitacora['fecha']),
                    subtitle: Text(bitacora['evento']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
