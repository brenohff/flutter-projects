import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map _selectedGifData;

  GifPage(this._selectedGifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedGifData["title"]),
        backgroundColor: Colors.black,
        elevation: 5,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            onPressed: (){
              Share.share(_selectedGifData["images"]["fixed_height"]["url"]);
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_selectedGifData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
