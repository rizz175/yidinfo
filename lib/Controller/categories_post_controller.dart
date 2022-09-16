import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class catgorypostcontroller {

  Future<List> getallpost(String id,int i) async {

    var url = Uri.parse("https://yidinfo.net/wp-json/wp/v2/posts/?categories=$id&per_page=10&page=$i");
    var response = await http.get(url);
    log(response.body);
    return await jsonDecode(response.body);
  }

  Future<Map<String,dynamic>> getalliintapost() async {

    var url = Uri.parse("https://yidinfo.net/wp-json/wp/v2/posts/28184");
    var response = await http.get(url);
    log(response.body);
    return await jsonDecode(response.body);
  }
}
