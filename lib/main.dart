import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail_news_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageHomeSportNews(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageHomeSportNews extends StatefulWidget {
  @override
  _PageHomeSportNewsState createState() => _PageHomeSportNewsState();
}

class _PageHomeSportNewsState extends State<PageHomeSportNews> {
  Future<List> getData() async {
    final responseData =
        await http.get("http://192.168.43.32/berita/get_berita.php");
    return json.decode(responseData.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Sport News'),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemListNewsSport(list: snapshot.data)
              : new Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemListNewsSport extends StatelessWidget {
  final List list;

  const ItemListNewsSport({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 0),
          child: new GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => PageDetailNews(
                        list: list,
                        index: i,
                      )));
            },
            child: new Card(
              child: new ListTile(
                title: Text(
                  list[i]['judul_berita'],
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.black),
                ),
                subtitle: new Text(
                  list[i]['tgl_berita'],
                  style: TextStyle(fontSize: 10.0),
                ),
                trailing: Container(
                  decoration: BoxDecoration(),
                  child: new Image.network(
                    'http://192.168.43.32/berita/gambar/' +
                        list[i]['gbr_berita'],
                    fit: BoxFit.cover,
                    height: 80.0,
                    width: 80.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
