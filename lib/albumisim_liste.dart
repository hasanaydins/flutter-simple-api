import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'album_detay.dart';
import 'models/Album.dart';

class AlbumListe extends StatefulWidget {
  @override
  _AlbumListeState createState() => _AlbumListeState();
}

class _AlbumListeState extends State<AlbumListe> {
  Future<List<Album>> _postGetir() async {
    var response = await http.get(
      "https://jsonplaceholder.typicode.com/albums", /*headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"}*/
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((tekAlbumMap) => Album.fromJsonMap(tekAlbumMap))
          .toList();
    } else {
      throw Exception(
          "****BAGLANMADI**** HATA KODU :  " + response.statusCode.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JsonPlaceHolder Albums'),
      ),
      body: FutureBuilder(
        future: _postGetir(),
        builder: (BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AlbumDetay(albumId: snapshot.data[index].id)));
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      elevation: 4,
                      child: ListTile(
                        title: Text(snapshot.data[index].title),
                        subtitle: Text(
                            "Album id :" + snapshot.data[index].id.toString()),
                        leading: CircleAvatar(
                          child: Text(snapshot.data[index].userId.toString()),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ));
          }
        },
      ),
    );
  }
}
