
import 'package:dio/dio.dart';
import 'package:shazam_clone/services/models/deezer_song_model.dart';

class SongServices{
  late Dio _dio;

 SongServices(){
   BaseOptions options = BaseOptions(
       receiveTimeout: Duration(milliseconds: 100000),
       connectTimeout: Duration(milliseconds: 100000),
     baseUrl: 'https://api.deezer.com/track/'
   );

   _dio = Dio(options);
 }

 Future<DeezerSongModel> getTrack(id) async{
   try{
     final response = await _dio.get('$id',
         options: Options(headers: {
           'Content-type': 'application/json;charset=UTF-8',
           'Accept': 'application/json;charset=UTF-8',
         }));
    print(response.data) ;
     DeezerSongModel result = DeezerSongModel.fromJson(response.data);
     return result;
   } on DioException catch (e) {
     print(e.error);
     throw Exception(e.error);
   }
 }
}