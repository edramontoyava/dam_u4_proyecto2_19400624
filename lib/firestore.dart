import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getasig() async {
  List asignados = [];
  QuerySnapshot querySnapshot = await db.collection('asignacion').get();

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map asignado = {
      "uid": doc.id,
      "docente": data["docente"],
      "materia": data["materia"],
      "horario": data["horario"],
      "edificio": data["edificio"],
      "salon": data["salon"],
    };
    asignados.add(asignado);
  }
  return asignados;
}

Future<List> getasis() async {
  List asistencias = [];
  QuerySnapshot querySnapshot = await db.collection('asistencia').get();

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map asistencia = {
      "uid": doc.id,
      "docente": data["docente"],
      "fecha/hora": DateFormat('yyyy-MM-dd HH:mm:ss').format(data["fecha/hora"].toDate()).toString(),
      "revisor": data["revisor"],
    };
    asistencias.add(asistencia);
  }
  return asistencias;
}

Future<void> addasig(
    String docente,
    String materia,
    String horario,
    String edificio,
    String salon,
    ) async {await db.collection("asignacion").add(
    {
      "docente": docente,
      "materia": materia,
      "horario": horario,
      "edificio": edificio,
      "salon": salon,
    });
}

Future<void> addasis(
    String docente,
    String fecha_hora,
    String revisor,
    ) async {await db.collection("asistencia").add(
    {
      "docente": docente,
      "fecha/hora": DateTime.parse(fecha_hora),
      "revisor":revisor,
    });
}


Future<void> updateasig(
    String uid,
    String docente,
    String materia,
    String horario,
    String edificio,
    String salon,
    ) async {await db.collection("asignacion").doc(uid).set(
    {
      "docente": docente,
      "materia": materia,
      "horario": horario,
      "edificio": edificio,
      "salon": salon,
    });
}

Future<void> deleteasig(String uid,) async {
  await db.collection("asignacion").doc(uid).delete();
}

Future<List<String>> docentes() async {
  List<String> docentes = [];

  QuerySnapshot<Map<String, dynamic>> querySnapshot =
  await FirebaseFirestore.instance.collection('asignacion').get();

  for (var doc in querySnapshot.docs) {
    if (doc.data().containsKey('docente') && doc.data().containsKey('materia') && doc.data().containsKey('horario')) {
      String docente = doc.data()['docente'] as String;
      String materia = doc.data()['materia'] as String;
      String horario = doc.data()['horario'] as String;
      String docenteMateria = '$docente : $materia ($horario)';
      docentes.add(docenteMateria);
    }
  }

  return docentes;
}

Future<DocumentSnapshot> getAsistenciaDocente(String docente) async {
  QuerySnapshot querySnapshot = await db
      .collection('asistencia')
      .where('docente', isEqualTo: docente)
      .get();

  if (querySnapshot.docs.length > 0) {
    // Se asume que solo hay un documento para el docente especificado
    return querySnapshot.docs[0];
  } else {
    // No se encontró ningún documento para el docente especificado
    throw Exception('No se encontró asistencia para el docente especificado');
  }
}
