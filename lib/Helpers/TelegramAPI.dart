import 'package:http/http.dart' as http;

class TelegramAPI{

    final String token = "6179395570:AAFoSAIMtP7U3jWnJpBElhFvUZQgLZKHA3I";

    Future<void> sendMessage(Map bilet) async {
      String template = bilet["title"] + "\n";
      template += "Fiyat : ${bilet["price"]}" "\n";
      template += "${bilet["link"]}" "\n";

      var params = {
        "text": template,
        "chat_id": "-881766643",
        "disable_web_page_preview": "false"
      };

      Uri queryAddress = Uri.https("api.telegram.org",
          "/bot$token/sendMessage", params);

      var response = await http.get(queryAddress);

      if(response.statusCode == 200){
        print("Telegrama gönderildi");
      }else{
        print("Telegrama gönderilemedi");
      }
    }
}