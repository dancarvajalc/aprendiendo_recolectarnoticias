
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ViendoNoticia22 extends StatelessWidget {
  final String url, titulo;
  ViendoNoticia22({this.url, this.titulo});

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
         initialChild: Center(child: CircularProgressIndicator()),
      appBar: AppBar(title: Text(titulo)),
      hidden: true,
      withZoom: true,
      scrollBar: true,

   
    );

    /*Image.network(
          'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
        height: 50,width: 50,),*/
  }
}

