import 'package:dam_u4_proyecto1_19400624/firestore.dart';
import 'package:flutter/material.dart';

class Home_Asis extends StatefulWidget {
  const Home_Asis({Key? key}) : super(key: key);

  @override
  State<Home_Asis> createState() => _Home_AsisState();
}

class _Home_AsisState extends State<Home_Asis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Row(
            children: [
              Text('ASISTENCIA'),
              SizedBox(width: 10,),
              Icon(Icons.library_books_rounded)
            ],
          ),
        ),
        body: FutureBuilder(
            future: getasis(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        child: ListTile(
                          title: Text(snapshot.data?[index]['docente']),
                          subtitle: Text(snapshot.data?[index]['fecha/hora']),
                          trailing: Text(snapshot.data?[index]['revisor']),
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
                  await Navigator.pushNamed(context, '/asis/add');
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
