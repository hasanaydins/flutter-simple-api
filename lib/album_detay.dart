import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'models/Photo.dart';
import 'models/Album.dart';
import 'photo_ac.dart';

class AlbumDetay extends StatefulWidget {
  var albumId;

  AlbumDetay({this.albumId});

  @override
  _AlbumDetayState createState() => _AlbumDetayState();
}

class _AlbumDetayState extends State<AlbumDetay> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Photo>> _postGetir() async {
    var response = await http.get(
      "https://jsonplaceholder.typicode.com/photos?albumId=" +
          widget.albumId
              .toString(), /*headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"}*/
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((tekPhotoMap) => Photo.fromJsonMap(tekPhotoMap))
          .toList();
    } else {
      throw Exception(
          "****BAGLANMADI**** HATA KODU :  " + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),
      body: FutureBuilder(
        future: _postGetir(),
        builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    width: double.infinity,
                    height: 150,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                                width: 150,
                                child:
                                    Text(snapshot.data[widget.albumId].title)),
                            SizedBox(
                              width: 90,
                              child: Text("Album id: " +
                                  snapshot.data[widget.albumId].albumId
                                      .toString()),
                            ),
                            SizedBox(
                              width: 70,
                              child: Text("Photo id: " +
                                  snapshot.data[widget.albumId].id.toString()),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            return Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    PhotoAc(url: snapshot.data[index].url)));
                          },
                          child: Image(
                            image:
                                NetworkImage(snapshot.data[index].thumbnailUrl),
                            width: 40,
                          ),
                        )
                      ],
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
