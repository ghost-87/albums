import 'package:http/http.dart' show Client;
import './api.dart';

class FetchAlbumService {
  static final Client client = Client();

  static Future<dynamic> fetchAlbum() async {
    final response = await client.get(Constants.API_ALBUMS_PHOTOS, headers: {
      'Content-Type': 'application/json',
    });

    return response;
  }
}
