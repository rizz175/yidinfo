import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class homepostcontroller {

  Future<List> getallhomepost() async {

      var url = Uri.parse("https://yidinfo.net/wp-json/wp/v2/posts?_embed");
      var response = await http.get(url);

    return await jsonDecode(response.body);
  }
  Future<List> getallsearchpost() async {
    var url = Uri.parse("https://yidinfo.net/wp-json/wp/v2/posts/?categories=25&per_page=100");
    var response = await http.get(url);

    return await jsonDecode(response.body);
  }

}
