import 'dart:convert';

import 'package:http/http.dart' as http;

class Noticia2 {
  final String titulo;
  final String autor;
  final String descripcion;
  final String imagen;
  final String url;
  final String fecha;

  Noticia2(this.titulo, this.autor, this.descripcion, this.imagen,this.url,this.fecha);
}




Future<List<Noticia2>> recuperarNoticias2(String tema, String idioma) async {

  var datos = await http.get(
      "https://newsapi.org/v2/everything?q="+tema+"&language="+idioma+"&sortBy=publishedAt&apiKey=c4b8c021b0514ae695c6c1591058bbfd");


List<Noticia2> listadenoticias = [];
  if (datos.statusCode == 200) {
      
    final jsonData = json.decode(datos.body);

    for (var item in jsonData['articles']) {
      Noticia2 noticia = Noticia2(item["title"], item["author"],
          item["description"], item["urlToImage"],item["url"],item["publishedAt"]);

      listadenoticias.add(noticia);
    }
   
  }
  print(listadenoticias);
 return listadenoticias;
  //print(noticia.noticias[2].titulo);
  //print(noticia.autor);
}

