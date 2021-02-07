import 'package:flutter/material.dart';
import '../services/album_fetch.dart';
import 'dart:convert';
import '../common/loader.dart';
import './album_details.dart';
import '../common/common.dart';
import './add_album.dart';

// TODO:
// 1. Create a list view to display the album data from the fetching function in `api.dart`
// 2. The item of the list should contain the album's thumbnail and title

class AlbumList extends StatefulWidget {
  final bool alterAlbum;
  AlbumList({
    Key key,
    this.alterAlbum,
  }) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  // const AlbumList();
  List<dynamic> albumList;
  bool isLoading = false;
  bool isFetching = false;

  void initState() {
    widget.alterAlbum == null
        ? fetchAlbum()
        : widget.alterAlbum
            ? getAlbumList()
            : fetchAlbum();
    super.initState();
  }

  fetchAlbum() async {
    setState(() {
      isLoading = true;
    });

    await FetchAlbumService.fetchAlbum().then((onValue) async {
      try {
        if (onValue.statusCode == 200) {
          if (mounted) {
            setState(() async {
              await Common.setAllData(json.decode(onValue.body));
              isLoading = false;
            });
          }
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
    getAlbumList();
  }

  getAlbumList() async {
    setState(() {
      isFetching = true;
    });
    await Common.getAllData().then((onValue) async {
      try {
        if (mounted) {
          setState(() async {
            albumList = onValue;
            isFetching = false;
          });
        }
      } catch (error) {
        if (mounted) {
          setState(() {
            isFetching = false;
          });
        }
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          isFetching = false;
        });
      }
    });
    print('This is album list,$albumList ');
  }

  void addAlbum() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => AddAlbum(newAlbum: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album List'),
        centerTitle: true,
      ),
      body: isLoading
          ? SquareLoader()
          : isFetching
              ? SquareLoader()
              : Container(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => AlbumDetails(
                                  title: albumList[index]['title'],
                                  thumbnailUrl: albumList[index]
                                      ['thumbnailUrl'],
                                  albumId: albumList[index]['albumId'],
                                  id: albumList[index]['id'],
                                  url: albumList[index]['url'],
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                AspectRatio(
                                  aspectRatio: 1.2,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Image.network(
                                          albumList[index]['thumbnailUrl'],
                                          scale: 1),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(albumList[index]['title']),
                                        ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: albumList == null ? 0 : albumList.length,
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: addAlbum,
        tooltip: 'Add Album',
        child: Icon(Icons.add),
      ),
    );
  }
}
