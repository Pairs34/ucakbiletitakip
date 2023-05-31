import 'dart:io';

import 'package:ucakbiletitakip/Helpers/DatabaseManager.dart';
import 'package:ucakbiletitakip/Helpers/TelegramAPI.dart';
import 'package:ucakbiletitakip/Helpers/UcakbiletiAPI.dart';

Future<void> main(List<String> arguments) async {
  print(Directory.current);
  var ucakbiletiApi = UcakbiletiAPI();
  var dbManager = DatabaseManager();
  var telegramApi = TelegramAPI();

  final String baseProductLink =
      "https://bilet.ucuzaucak.net/f/";

  while(true){
    try{
      var remoteProducts = await ucakbiletiApi.loadRemoteCars();

      if (remoteProducts != null) {
        for (Map p in remoteProducts["items"]) {
          var existingCar = dbManager.getCarDetail(p["ID"]);

          var bilet = {
            "code": p["ID"],
            "price": p["Price"],
            "link": "$baseProductLink${p['Slug']}",
            "title": p["Title"]
          };

          if (existingCar.isEmpty) {
            telegramApi.sendMessage(bilet);
            dbManager.addCar(bilet);
          }
        }
      }
    }catch(e){
      print(e);
    }

    sleep(Duration(seconds: 5));
  }
}
