import 'package:flutter/material.dart';
import 'package:flutter_rxdart_bloc/models/SearchItem.dart';

class DetailsWidget extends StatefulWidget {
  final SearchItem searchItem;

  DetailsWidget(this.searchItem);

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Hero(
                tag: widget.searchItem.url,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.searchItem?.avatarUrl ??
                      "https://www.pngarts.com/files/3/Avatar-PNG-Download-Image.png"),
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.searchItem.fullName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.searchItem.url,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
