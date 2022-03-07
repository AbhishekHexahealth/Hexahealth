import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../utils/Utils.dart';
import '../AppException.dart';
import 'BaseApiService.dart';


class NetworkApiService extends BaseApiService {

  @override
  Future getResponse(String url,int cusMsg,String msg) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response,cusMsg,msg);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, Map<String, String> JsonBody) async{
    dynamic responseJson;
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    try {
      final response = await http.post( Uri.https(baseUrl, API_PATH + url),
        body: JsonBody,
        headers: headers,
      );
      responseJson = returnResponse(response,0,"show msg");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
  dynamic returnResponse(http.Response response, int cusMsg,String msg ) {
    switch (response.statusCode) {
        case 200:
          dynamic responseJson = jsonDecode(response.body);
          if(cusMsg==0) {
          Utils.showToastMessage("message");
          }
          else{
            Utils.showToastMessage(msg);
          }
          return responseJson;
        case 400:
          Utils.showToastMessage(response.toString());
          throw BadRequestException(response.toString());
        case 401:
        case 403:
          Utils.showToastMessage(response.toString());
          throw UnauthorisedException(response.body.toString());
        case 404:
          Utils.showToastMessage(response.toString());
          throw UnauthorisedException(response.body.toString());
        case 500:
        default:
          throw FetchDataException(
              'Error occured while communication with server' +
                  ' with status code : ${response.statusCode}');
      }

  }
}