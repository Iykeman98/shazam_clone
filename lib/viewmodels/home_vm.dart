import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shazam_clone/services/models/deezer_song_model.dart';
import 'package:shazam_clone/services/models/song_service.dart';

class HomeViewModel extends ChangeNotifier{

  HomeViewModel(){
    initAcr();
  }

  final AcrCloudSdk acr = AcrCloudSdk();
  final songService = SongServices();
  late DeezerSongModel currentSong;
  bool isRecognizing = false;
  bool success = false;

  Future<void> initAcr()async {
    try{
      acr
      ..init(
        host: 'identify-eu-west-1.acrcloud.com',
      accessKey: "63ecf0862e890a67187e898cdf2f69fb",
          accessSecret: 'y6GYJme4qsiJ0VeoNjJSK1Mg3313XP20EbcZLgOZ',
      setLog: true,
      )
          ..songModelStream.listen(searchSong);
    }catch (e){
      print('VVVVVV');
      print(e.toString());
    }
  }
 void searchSong(SongModel song) async{
    print(song);
    final metaData = song.metadata;
    if(metaData != null && metaData.music!.length > 0){
      final trackId = metaData.music?[0].externalMetadata?.deezer?.track?.id;
      try{
        final res = await songService.getTrack(trackId);
        print('*******');

        print(res.title ?? "" + "${res.artist }");
        currentSong = res;
        success = true;
        notifyListeners();
      }catch (e){
        print("xxxxx");
        isRecognizing = false;
        success = false;
        notifyListeners();
      }
    }
 }
 Future<void> startRecognizing() async {
    isRecognizing = true;
    success = false;
    notifyListeners();
    try{
      await acr.start();
    } catch (e){
      print(e.toString());
    }
 }Future<void> stopRecognizing() async {
    isRecognizing = false;
    success = false;
    notifyListeners();
    try{
      await acr.stop();
    } catch (e){
      print(e.toString());
    }
 }
}

final homeViewModel = ChangeNotifierProvider<HomeViewModel>((ref){
  print('>>> In homeViewModel');
  return HomeViewModel();


});