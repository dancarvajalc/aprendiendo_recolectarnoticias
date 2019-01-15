import 'listadeNoticias.dart';
import 'package:flutter/material.dart';
import 'viendoNoticia.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noticias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;

  validar() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: EdgeInsets.all(10),
        child: Scaffold(
      bottomNavigationBar:
          RaisedButton(child: Text("Obtener noticias"), onPressed: validar),
      appBar: AppBar(
        title: Text("Noticias"),
      ),
      body: isLoading
          ? Center(child: Text("Bienvenido"))
          : Container(
              child: FutureBuilder(
              future: recuperarNoticias2(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          subtitle: Text(
                            snapshot.data[index].descripcion,
                            textAlign: TextAlign.justify,
                          ),
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViendoNoticia(url: snapshot.data[index].url.toString(),titulo: snapshot.data[index].titulo),
                                      fullscreenDialog: true));
                            },
                            child: Image.network(
                              snapshot.data[index].imagen,
                              height: 50,
                              width: 50,
                            ),
                          ),
                          title: Text(
                            snapshot.data[index].titulo,
                            maxLines: 2,
                          ));
                    },
                  );
                }
              },
            )),
    ));
  }
}
