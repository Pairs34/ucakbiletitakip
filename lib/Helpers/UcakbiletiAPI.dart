import 'dart:convert';

import 'package:http/http.dart' as http;

class UcakbiletiAPI {
  late Uri queryAddress;

  UcakbiletiAPI() {
    queryAddress = Uri.https("api.ucuzaucak.net", "/api/getItems", {
      "before": "",
      "after": "",
      "newer": "1",
      "count": "15",
      "f": "",
      "m": "",
      "t": "",
      "p": "1"
    });
  }

  Future<Map?> loadRemoteCars() async {
    var result = await http.get(queryAddress);

    if (result.statusCode == 200) {
      var decodedResponse = jsonDecode(utf8.decode(result.bodyBytes)) as Map;
      return decodedResponse;
    } else {
      return null;
    }
  }
}
