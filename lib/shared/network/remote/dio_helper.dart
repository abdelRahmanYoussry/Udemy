import 'package:dio/dio.dart';

class DioHelper{

 static late Dio dio;

 static init(){
   dio=Dio(
  BaseOptions(
    baseUrl: 'http://newsapi.org/',
    receiveDataWhenStatusError: true,
  )
   );
 }
 static Future<Response> getData({required String path,required Map<String,dynamic> query }
     ) async{
  return await dio.get(
        path,
       queryParameters:query, );

 }
}