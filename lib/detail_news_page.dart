import 'package:flutter/material.dart';

class PageDetailNews extends StatefulWidget {
  List list;
  int index;

  PageDetailNews({
    this.list,
    this.index,
  });

  @override
  _PageDetailNewsState createState() => _PageDetailNewsState();
}

class _PageDetailNewsState extends State<PageDetailNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.list[widget.index]['judul_berita']}'),
        backgroundColor: Colors.red,
      ),
      body: new ListView(
        children: [
          new Image.network(
            'http://192.168.43.32/berita/gambar/' +
                widget.list[widget.index]['gbr_berita'],
          ),
          new Container(
            padding: EdgeInsets.all(5.0),
            child: new Row(
              children: [
                new Expanded(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: new Text(
                        widget.list[widget.index]['judul_berita'],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    new Text(
                      widget.list[widget.index]['tgl_berita'],
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.all(10.0),
            child: new Text(widget.list[widget.index]['isi_berita']),
          )
        ],
      ),
    );
  }
}
