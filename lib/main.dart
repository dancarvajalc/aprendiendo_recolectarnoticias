import 'package:flutter/cupertino.dart';

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
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.conversation_bubble),
              title: Text('Chat'),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              switch (index) {
                case 0:
                  return Bienvenida();
                  break;
                case 1:
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
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
          child: FutureBuilder(
        future: recuperarNoticias2(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: Center(child: CupertinoActivityIndicator()));
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
                                builder: (context) => ViendoNoticia22(
                                    url: snapshot.data[index].url.toString(),
                                    titulo: snapshot.data[index].titulo),
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
      ),
    );
  }
}


class Bienvenida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("Bienvenido"),),
      
    );
  }
}