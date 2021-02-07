import 'package:flutter/material.dart';
import '../common/loader.dart';
import '../common/common.dart';
import './album_list.dart';

class AddAlbum extends StatefulWidget {
  final bool newAlbum;
  final String title;
  final String thumbnailUrl;
  final int albumId;
  final int id;
  final String url;
  final int index;

  AddAlbum(
      {Key key,
      this.newAlbum,
      this.index,
      this.title,
      this.thumbnailUrl,
      this.albumId,
      this.id,
      this.url})
      : super(key: key);

  @override
  _AddAlbumState createState() => _AddAlbumState();
}

class _AddAlbumState extends State<AddAlbum> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> newAlbumList;
  bool isLoading = false;
  bool isSetting = false;
  String albumCoverUrl;
  String albumTitle;

  void initState() {
    super.initState();
  }

  Future<void> submitNewAlbum() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('I am clicked');
      print(albumCoverUrl);
      print(albumTitle);
    }

    setState(() {
      isLoading = true;
    });
    await Common.getAllData().then((onValue) async {
      try {
        if (mounted) {
          setState(() async {
            newAlbumList = onValue;
            isLoading = false;
          });
        }
      } catch (error) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });

    setState(() {
      isSetting = true;
    });
    if (mounted) {
      widget.newAlbum
          ? setState(() {
              newAlbumList.insert(
                0,
                {
                  "albumId": 1,
                  "id": newAlbumList.length + 1,
                  "title": albumTitle.toString(),
                  "url": albumCoverUrl.toString(),
                  "thumbnailUrl": albumCoverUrl.toString(),
                },
              );
              Common.setAllData(newAlbumList);
              isSetting = false;
            })
          : setState(() {
              newAlbumList[widget.index] = {
                "albumId": 1,
                "id": widget.id,
                "title": albumTitle.toString(),
                "url": albumCoverUrl.toString(),
                "thumbnailUrl": albumCoverUrl.toString(),
              };
              // );
              Common.setAllData(newAlbumList);
              isSetting = false;
            });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => AlbumList(
          alterAlbum: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.newAlbum ? Text('New Album') : Text('Edit Album'),
        centerTitle: true,
      ),
      body: isLoading
          ? SquareLoader()
          : Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        margin: const EdgeInsets.only(top: 30.0),
                        child: TextFormField(
                          initialValue: widget.newAlbum ? "" : widget.url,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Album Cover Url',
                            errorStyle: TextStyle(color: Color(0xFFF44242)),
                            fillColor: Colors.black,
                            focusColor: Colors.black,
                            contentPadding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                              bottom: 10.0,
                            ),
                          ),
                          onSaved: (String value) {
                            albumCoverUrl = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter A Valid Value';
                            } else
                              return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        margin: const EdgeInsets.only(top: 30.0),
                        child: TextFormField(
                          initialValue: widget.newAlbum ? "" : widget.title,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Album Title',
                            errorStyle: TextStyle(color: Color(0xFFF44242)),
                            fillColor: Colors.black,
                            focusColor: Colors.black,
                            contentPadding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                              bottom: 10.0,
                            ),
                          ),
                          onSaved: (String value) {
                            albumTitle = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter A Valid Value';
                            } else
                              return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: submitNewAlbum,
        tooltip: 'Submit',
        child: Icon(Icons.check),
      ),
    );
  }
}
