import 'package:dam_u4_proyecto1_19400624/auto_Add.dart';
import 'package:dam_u4_proyecto1_19400624/auto_update.dart';
import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              children: [
                Text('VEHICULOS'),
                SizedBox(width: 10,),
                Icon(Icons.car_rental_rounded)
              ]
          )
        ),
        body: FutureBuilder(
            future: getAuto(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        child: ListTile(
                          leading: Text(snapshot.data?[index]['combustible'] +
                              '\n' +
                              snapshot.data?[index]['tanque'] +
                              ' lt'),
                          title: Text(snapshot.data?[index]['tipo'] +
                              ' (' +
                              snapshot.data?[index]['placa'] +
                              '=>' +
                              snapshot.data?[index]['numeroserie'] +
                              ')'),
                          subtitle: Text(snapshot.data?[index]['trabajador'] +
                              ' (' +
                              snapshot.data?[index]['depto'] +
                              ')'),
                          trailing:
                              Text(snapshot.data?[index]['resguardadopor']),
                          onTap: ()async{
                            await Navigator.pushNamed(context, '/edit',
                                arguments: {
                              "uid":snapshot.data?[index]['uid'],
                                  "placa":snapshot.data?[index]['placa'],
                                  "tipo" :snapshot.data?[index]['tipo'],
                                  "numeroserie" :snapshot.data?[index]['numeroserie'],
                                  "depto" :snapshot.data?[index]['depto'],
                                  "trabajador" :snapshot.data?[index]['trabajador'],
                                  "resguardadopor" :snapshot.data?[index]['resguardadopor'],
                                  "combustible" :snapshot.data?[index]['combustible'],
                                  "tanque" :snapshot.data?[index]['tanque']
                                });
                            setState(() {});
                          },
                          onLongPress: ()async{
                            await deleteAuto(snapshot.data?[index]['uid']);
                            setState(() {});
                          },
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/add');
                  setState(() {});
                  }, child: Icon(Icons.add),
              ),
              SizedBox(width: 18),
              FloatingActionButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/Bit');
                  setState(() {});
                }, child: Icon(Icons.library_books),
              ),
              SizedBox(width: 18),
              FloatingActionButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/C4');
                  setState(() {});
                }, child: Icon(Icons.question_mark),
              ),
            ]
        )
    );
  }
}
