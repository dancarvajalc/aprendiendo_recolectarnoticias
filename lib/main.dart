import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: CupertinoColors.lightBackgroundGray,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Bienvenida'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.conversation_bubble),
              title: Text('Noticias'),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              switch (index) {
                case 0:
                  return UInoticia2();
                  break;
                default:
                  return Container();
              }
            },
          );
        },
      ),
    );
  }
}

class UInoticia2 extends StatefulWidget {
  @override
  _UInoticia2State createState() => _UInoticia2State();
}

class _UInoticia2State extends State<UInoticia2> {
  String tema, idioma;
  final _formkey = GlobalKey<FormState>();
  bool bienvenida = true;

  @override
  Widget build(BuildContext context) {
    hola() {
      setState(() {
        tema = tema;
        idioma = idioma;
        bienvenida = !bienvenida;
      });
    }

    void validaryenviar() {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        print(tema);
        print(idioma);

        hola();
        //Navigator.push(context, MaterialPageRoute(builder: (context) => UInoticia2(tema: tema,idioma: idioma))

      }
    }

    return bienvenida
        ? CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              middle: Text("Súper increible app de noticias"),
            ),
            child: Container(
                padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Ingresa un valor válido";
                            }
                          },
                          onSaved: (value) {
                            tema = value;
                          },
                          decoration:
                              InputDecoration(labelText: "Ingrese un tema"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Ingresa un valor válido";
                            }
                          },
                          onSaved: (value) {
                            idioma = value;
                          },
                          decoration:
                              InputDecoration(labelText: "Ingrese el idioma"),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        CupertinoButton(
                          child: Text("Buscar noticias"),
                          onPressed: validaryenviar,
                          color: CupertinoColors.activeBlue,
                        )
                      ],
                    ))),
          )
        : Container(
            child: Column(
           
              children: <Widget>[
                Container(
                  height: 448,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: recuperarNoticias2(tema, idioma),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                            child: Center(child: CupertinoActivityIndicator()));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(

                                //trailing:   Text(snapshot.data[index].fecha),
                                subtitle: Text(
                                  snapshot.data[index].descripcion,
                                  textAlign: TextAlign.justify,
                                ),
                                leading: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViendoNoticia22(
                                                      url: snapshot.data[index]
                                                          .url
                                                          .toString(),
                                                      titulo: snapshot
                                                          .data[index].titulo),
                                              fullscreenDialog: true));
                                    },
                                    child: snapshot.data[index].imagen != null ?
                                    FadeInImage.memoryNetwork(
                                      height: 50,
                                      width: 50,
                                      placeholder: kTransparentImage,
                                      image: snapshot.data[index].imagen,
                                    ): Container(height: 50,width: 50,),
                                    ),
                                title: Text(
                                  snapshot.data[index].titulo +
                                      "\n" +
                                      (snapshot.data[index].fecha),
                                  textAlign: TextAlign.justify,
                                ));
                          },
                        );
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 200,
                  margin: EdgeInsets.all(5),
                  child: CupertinoButton(
                    child: Text("Volver"),
                    onPressed: hola,
                    color: CupertinoColors.activeBlue,
                  ),
                )
              ],
            ),
          );
  }
}

/*class Bienvenida extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  String tema, idioma;

  @override
  Widget build(BuildContext context) {
    List<String> validaryenviar() {
      List<String> lista = [];
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        if (tema.isNotEmpty) {
          lista.add(tema);
        }
        if (idioma.isNotEmpty) {
          lista.add(idioma);
        }

        //Navigator.push(context, MaterialPageRoute(builder: (context) => UInoticia2(tema: tema,idioma: idioma))

        print(idioma);

        print(lista);
      }
      return lista;
    }

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text("Súper increible app de noticias"),
      ),
      child: Container(
          padding: EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Ingresa un valor válido";
                      }
                    },
                    onSaved: (value) {
                      tema = value;
                    },
                    decoration: InputDecoration(labelText: "Ingrese un tema"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Ingresa un valor válido";
                      }
                    },
                    onSaved: (value) {
                      idioma = value;
                    },
                    decoration: InputDecoration(labelText: "Ingrese el idioma"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                    child: Text("Buscar noticias"),
                    onPressed: validaryenviar,
                    color: CupertinoColors.activeBlue,
                  )
                ],
              ))),
    );
  }
}*/
