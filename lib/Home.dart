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
                Text('Asignacion'),
                SizedBox(width: 10,),
                Icon(Icons.school)
              ]
          )
        ),
        body: FutureBuilder(
            future: getasig(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        child: ListTile(
                          leading:Text(snapshot.data?[index]['edificio']+'\n'+'('+snapshot.data?[index]['salon']+')'),
                          title:Text(snapshot.data?[index]['docente']),
                          subtitle:Text(snapshot.data?[index]['materia']),
                          trailing:Text(snapshot.data?[index]['horario']),
                          onTap: ()async{
                            await Navigator.pushNamed(context, '/edit',
                                arguments: {
                                  "uid":snapshot.data?[index]['uid'],
                                  "docente":snapshot.data?[index]['docente'],
                                  "materia" :snapshot.data?[index]['materia'],
                                  "horario" :snapshot.data?[index]['horario'],
                                  "edificio" :snapshot.data?[index]['edificio'],
                                  "salon" :snapshot.data?[index]['salon'],
                                });
                            setState(() {});
                          },
                          onLongPress: ()async{
                            await deleteasig(snapshot.data?[index]['uid']);
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
                  await Navigator.pushNamed(context, '/asis');
                  setState(() {});
                }, child: Icon(Icons.library_books),
              ),
            ]
        )
    );
  }
}
