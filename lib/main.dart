import 'package:dam_u4_proyecto1_19400624/Home.dart';
import 'package:dam_u4_proyecto1_19400624/Home_asis.dart';
import 'package:dam_u4_proyecto1_19400624/asignacion_Add.dart';
import 'package:dam_u4_proyecto1_19400624/asignacion_update.dart';
import 'package:dam_u4_proyecto1_19400624/asistencia_add.dart';

import 'package:dam_u4_proyecto1_19400624/c1.dart';
import 'package:dam_u4_proyecto1_19400624/c2.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => const Home(),
        '/add':(context) => const AddAsignadoPage(),
        '/edit':(context) => const UpdateAsignadoPage(),
        '/asis':(context) => const Home_Asis(),
        '/asis/add':(context) => const AddAsistenciaPage(),
        '/C1':(context) => C1(),
        '/C2':(context) => C2(),
      },
    );
  }
}
