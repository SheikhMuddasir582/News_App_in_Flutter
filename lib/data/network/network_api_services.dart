import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:world_news/data/exceptions/exceptions.dart';
import 'package:world_news/data/network/base_api_services.dart';


class NetworkApiServices extends BaseApiServices{


  @override
  Future getApi(String url) async{
    dynamic responseJson ;
    try{
      final response= await http.get(Uri.parse(url)).timeout( const Duration(seconds: 10));
      responseJson= returnResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApi(String url, dynamic data) async{
    dynamic responseJson ;
    try{
      Response response= await post(
        Uri.parse(url),
        body: data,
      ).timeout(Duration(seconds: 10));
      responseJson= returnResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse (http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic responseJson= jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
        default:
          throw FetchDataException('Error accured while communicating with server'+ 'with status code' + response.statusCode.toString());


    }

  }

}