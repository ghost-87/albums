import 'package:flutter/material.dart';
import '../common/loader.dart';
import './add_album.dart';

class AlbumDetails extends StatefulWidget {
  final String title;
  final String thumbnailUrl;
  final int albumId;
  final int id;
  final String url;
  final int index;

  AlbumDetails(
      {Key key,
      this.index,
      this.title,
      this.thumbnailUrl,
      this.albumId,
      this.id,
      this.url})
      : super(key: key);

  @override
  _AlbumDetailsState createState() => _AlbumDetailsState();
}

class _AlbumDetailsState extends State<AlbumDetails> {
  List<dynamic> albumList;
  bool isLoading = false;

  void initState() {
    print('this is album details');
    print(widget.thumbnailUrl.runtimeType);
    print(widget.url.runtimeType);
    super.initState();
  }

  void editAlbum() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => AddAlbum(
          newAlbum: false,
          title: widget.title,
          thumbnailUrl: widget.thumbnailUrl,
          id: widget.id,
          url: widget.url,
          index: widget.index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Id: ${widget.id}'),
        centerTitle: true,
      ),
      body: isLoading == true
          ? SquareLoader()
          : Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 40, bottom: 20),
                              height: 200,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new NetworkImage(
                                    widget.url,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 40,
                                  ),
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BarlowSemiBold',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: editAlbum,
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ),
    );
  }
}
