import 'package:http/http.dart';
import 'dart:convert';

class ResultFetcher {
  String hallticket, dob, year;

  ResultFetcher({this.hallticket, this.dob, this.year});

  Future<List<dynamic>> fetchResult() async {
    var url = Uri.parse(
        "https://results-restapi.herokuapp.com/calculate/$hallticket/$dob/$year");
    Response response = await get(url);
    List result = jsonDecode(response.body);

    return result;
  }
}
