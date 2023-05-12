import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:intl/intl.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getAuto() async {
  List autos = [];
  QuerySnapshot querySnapshot = await db.collection('vehiculo').get();

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map auto = {
      "uid": doc.id,
      "placa": data["placa"],
      "tipo": data["tipo"],
      "numeroserie": data["numeroserie"],
      "depto": data["depto"],
      "trabajador": data["trabajador"],
      "resguardadopor": data["resguardadopor"],
      "combustible": data["combustible"],
      "tanque": data["tanque"].toString(),
    };

    autos.add(auto);
  }
  return autos;
}

Future<List> getBit() async {
  List Bitacoras = [];
  QuerySnapshot querySnapshot = await db.collection('bitacora').get();

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map bitacora = {
      "uid": doc.id,
      "placa": data["placa"],
      "evento": data["evento"],
      "fecha": DateFormat('yyyy-MM-dd').format(data["fecha"].toDate()).toString(),
      "verifico": data["verifico"],
      "fechaverificacion": DateFormat('yyyy-MM-dd').format(data["fechaverificacion"].toDate()).toString(),
      "recursos": data["recursos"],
    };

    Bitacoras.add(bitacora);
  }
  return Bitacoras;
}

Future<void> addAuto(
    String placa,
    String tipo,
    String numeroserie,
    String depto,
    String trabajador,
    String resguardadopor,
    String combustible,
    String tanque,
) async {await db.collection("vehiculo").add(
      {
        "placa": placa,
        "tipo": tipo,
        "numeroserie": numeroserie,
        "depto": depto,
        "trabajador": trabajador,
        "resguardadopor": resguardadopor,
        "combustible": combustible,
        "tanque": int.parse(tanque)
  });
}

Future<void> addBit(
    String placa,
    String evento,
    String fecha,
    String recursos,
    String verifico,
    String fechaverificacion,
    ) async {await db.collection("bitacora").add(
    {
      "placa": placa,
      "evento": evento,
      "fecha": DateTime.parse(fecha),
      "recursos": recursos,
      "verifico": verifico,
      "fechaverificacion": DateTime.parse(fechaverificacion),
    });
}

Future<List<String>> placas() async {
  List<String> placas = [];

  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('vehiculo').get();

  for (var doc in querySnapshot.docs) {
    if (doc.data().containsKey('placa')) {
      String valor = doc.data()['placa'] as String;
      placas.add(valor);
    }
  }

  return placas;
}


Future<void> updateAuto(
    String uid,
    String placa,
    String tipo,
    String numeroserie,
    String depto,
    String trabajador,
    String resguardadopor,
    String combustible,
    String tanque,
    ) async {await db.collection("vehiculo").doc(uid).set(
    {
      "placa": placa,
      "tipo": tipo,
      "numeroserie": numeroserie,
      "depto": depto,
      "trabajador": trabajador,
      "resguardadopor": resguardadopor,
      "combustible": combustible,
      "tanque": int.parse(tanque)
    });
}

Future<void> updateBit(
    String placa,
    String evento,
    DateTime fecha,
    String recursos,
    String uid,
    String verifico,
    DateTime fechaverificacion,
    ) async {
  Timestamp fechaTimestamp = Timestamp.fromDate(fecha);
  Timestamp fechaverificacionTimestamp = Timestamp.fromDate(fechaverificacion);

  await FirebaseFirestore.instance.collection("bitacora").doc(uid).set({
    "placa": placa,
    "evento": evento,
    "fecha": fechaTimestamp,
    "recursos": recursos,
    "verifico": verifico,
    "fechaverificacion": fechaverificacionTimestamp,
  });
}



Future<void> deleteAuto(String uid,) async {
  await db.collection("vehiculo").doc(uid).delete();
}