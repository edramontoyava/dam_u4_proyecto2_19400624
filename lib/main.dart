import 'package:dam_u4_proyecto1_19400624/Home.dart';
import 'package:dam_u4_proyecto1_19400624/Home_Bit.dart';
import 'package:dam_u4_proyecto1_19400624/auto_Add.dart';
import 'package:dam_u4_proyecto1_19400624/auto_update.dart';
import 'package:dam_u4_proyecto1_19400624/bit_add.dart';
import 'package:dam_u4_proyecto1_19400624/bit_update.dart';
import 'package:dam_u4_proyecto1_19400624/c1.dart';
import 'package:dam_u4_proyecto1_19400624/c2.dart';
import 'package:dam_u4_proyecto1_19400624/c4.dart';
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
        '/add':(context) => const AddAutoPage(),
        '/edit':(context) => const UpdateAutoPage(),
        '/Bit':(context) => const Home_Bit(),
        '/Bit/add':(context) => const AddBitPage(),
        '/Bit/edit':(context) => const UpdateBitPage(),
        '/C1':(context) => C1(),
        '/C2':(context) => C2(),
        '/C4':(context) => C4(),
      },
    );
  }
}
