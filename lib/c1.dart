import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class C1 extends StatefulWidget {
  @override
  _C1State createState() => _C1State();
}

class _C1State extends State<C1> {
  final TextEditingController _placaController = TextEditingController();
  List<Map<String, dynamic>> _bitacoras = [];

  void _fetchBitacorasByPlaca() async {
    final String placa = _placaController.text.trim();

    if (placa.isEmpty) {
      return;
    }

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bitacora')
        .where('placa', isEqualTo: placa)
        .get();

    setState(() {
      _bitacoras = querySnapshot.docs
          .map((doc) => {
        "uid": doc.id,
        "placa": doc["placa"],
        "evento": doc["evento"],
        "fecha": DateFormat('yyyy-MM-dd').format(doc["fecha"].toDate()).toString(),
        "verifico": doc["verifico"],
        "fechaverificacion": DateFormat('yyyy-MM-dd').format(doc["fechaverificacion"].toDate()).toString(),
        "recursos": doc["recursos"],
      })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitácora por placa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _placaController,
              decoration: InputDecoration(
                labelText: 'Ingrese Placa',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fetchBitacorasByPlaca,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _bitacoras.length,
                itemBuilder: (context, index) {
                  final bitacora = _bitacoras[index];
                  return ListTile(
                    title: Text(bitacora['placa']),
                    subtitle: Text(bitacora['verifico']),
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
