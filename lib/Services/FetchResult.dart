import 'package:http/http.dart';
import 'dart:convert';

class ResultFetcher {
  String hallticket, dob, year;

  ResultFetcher({this.hallticket, this.dob, this.year});

  Future<List<dynamic>> fetchResult() async {
    List result;
    var url = Uri.parse(
        "https://results-restapi.herokuapp.com/calculate/$hallticket/$dob/$year");
    Response response = await get(url);
    result = jsonDecode(response.body);
    return result;
  }

  Future<List<dynamic>> fetchAllSupplyResultsLinks() async {
    List supplyResults;
    var url = Uri.parse("https://results-restapi.herokuapp.com/new/all/supply");
    Response response = await get(url);
    supplyResults = jsonDecode(response.body);
    return supplyResults;
  }

  Future<List<dynamic>> fetchAllRegularResultsLinks() async {
    List supplyResults;
    var url =
        Uri.parse("https://results-restapi.herokuapp.com/new/all/regular");
    Response response = await get(url);
    supplyResults = jsonDecode(response.body);
    return supplyResults;
  }

  Future<List<dynamic>> fetchSupplyResult(
      {String hallticket,
      String dob,
      String degree,
      String examCode,
      String eType,
      String result,
      String type}) async {
    List resultResponseList;
    var url =
        'https://results-restapi.herokuapp.com/api?hallticket=$hallticket&dob=$dob&degree=$degree&examCode=$examCode';
    if (result != "") {
      url += '&result=$result';
    }
    if (eType != '') {
      url += '&etype=$eType';
    }
    if (type != '') {
      url += '&type=$type';
    }
    var newUrl = Uri.parse(url);
    Response response = await get(newUrl);
    resultResponseList = jsonDecode(response.body);
    return resultResponseList;
  }

  Future<List<dynamic>> fetchRegularResults(
      {String hallticket,
      String dob,
      String degree,
      String examCode,
      String eType,
      String result,
      String type}) async {
    List resultResponseList;
    var url =
        'https://results-restapi.herokuapp.com/api/calculate?hallticket=$hallticket&dob=$dob&degree=$degree&examCode=$examCode';
    if (result != "") {
      url += '&result=$result';
    }
    if (eType != '') {
      url += '&etype=$eType';
    }
    if (type != '') {
      url += '&type=$type';
    }
    var newUrl = Uri.parse(url);
    Response response = await get(newUrl);
    resultResponseList = jsonDecode(response.body);
    return resultResponseList;
  }
}
