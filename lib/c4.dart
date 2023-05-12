import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class C4 extends StatefulWidget {
  @override
  _C4State createState() => _C4State();
}

class _C4State extends State<C4> {
  final TextEditingController departamento = TextEditingController();
  List<Map<String, dynamic>> _autos = [];

  void _fetchAutosByDepartment() async {
    final String department = departamento.text.trim();

    if (department.isEmpty) {
      return;
    }

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('vehiculo')
        .where('depto', isEqualTo: department)
        .get();

    setState(() {
      _autos = querySnapshot.docs
          .map((doc) => {
        "uid": doc.id,
        "placa": doc["placa"],
        "tipo": doc["tipo"],
        "numeroserie": doc["numeroserie"],
        "depto": doc["depto"],
        "trabajador": doc["trabajador"],
        "resguardadopor": doc["resguardadopor"],
        "combustible": doc["combustible"],
        "tanque": doc["tanque"].toString(),
      })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehiculos por departamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: departamento,
              decoration: InputDecoration(
                labelText: 'Ingrese el departamento',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fetchAutosByDepartment,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _autos.length,
                itemBuilder: (context, index) {
                  final auto = _autos[index];
                  return ListTile(
                    title: Text(auto['placa'].toString()),
                    subtitle: Text(auto['tipo'].toString()),
                    trailing: Text(auto['depto'].toString()),
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
