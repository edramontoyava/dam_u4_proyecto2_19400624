import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';

class Home_Bit extends StatefulWidget {
  const Home_Bit({Key? key}) : super(key: key);

  @override
  State<Home_Bit> createState() => _Home_BitState();
}

class _Home_BitState extends State<Home_Bit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Row(
            children: [
              Text('BITACORAS'),
              SizedBox(width: 10,),
              Icon(Icons.library_books_rounded)
            ],
          ),
        ),
        body: FutureBuilder(
            future: getBit(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        child: ListTile(
                          leading: Text(snapshot.data?[index]['fecha'] +'\n'+ snapshot.data?[index]['evento']),
                          title: Text(snapshot.data?[index]['placa']),
                          subtitle: Text(snapshot.data?[index]['verifico']+'('+snapshot.data?[index]['recursos']+')'),
                          trailing: Text(snapshot.data?[index]['fechaverificacion']),
                          onTap: ()async{
                            await Navigator.pushNamed(context, '/Bit/edit',
                                arguments: {
                                  "uid":snapshot.data?[index]['uid'],
                                  "placa":snapshot.data?[index]['placa'],
                                  "evento":snapshot.data?[index]['evento'],
                                  "fecha":snapshot.data?[index]['fecha'],
                                  "recursos":snapshot.data?[index]['recursos'],
                                  "verifico":snapshot.data?[index]['verifico'],
                                  "fechaverificacion" :snapshot.data?[index]['fechaverificacion'],
                                });
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
                  await Navigator.pushNamed(context, '/Bit/add');
                  setState(() {});
                }, child: Icon(Icons.add),
              ),
              SizedBox(width:18),
              FloatingActionButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/C1');
                  setState(() {});
                }, child: Icon(Icons.question_mark),
              ),
              SizedBox(width:18),
              FloatingActionButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/C2');
                  setState(() {});
                }, child: Icon(Icons.question_mark),
              ),
            ]
        )
    );
  }
}
