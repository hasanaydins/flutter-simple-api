import 'package:flutter/material.dart';

class PhotoAc extends StatefulWidget {
  var url;

  PhotoAc({this.url});

  @override
  _PhotoAcState createState() => _PhotoAcState();
}

class _PhotoAcState extends State<PhotoAc> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(image: NetworkImage(widget.url)),
    );
  }
}
