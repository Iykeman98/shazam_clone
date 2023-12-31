import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shazam_clone/viewmodels/home_vm.dart';


import '../song_screen.dart';

class Homepage extends HookConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(homeViewModel);

    ref.listen(homeViewModel, (previousState, newState) {
      if (newState.success) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SongScreen(
                  song: ref.read(homeViewModel).currentSong,
                )));
      }

    });


    return Scaffold(
        backgroundColor: Color(0xFF042442),
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Tap To SHAZAM',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              AvatarGlow(
                endRadius: 200,
                animate: ref.read(homeViewModel).isRecognizing,
                child: GestureDetector(
                  onTap: () {
                    viewmodel.startRecognizing();

                    // ref.read(homeViewModel).isRecognizing ? ref.read(homeViewModel).stopRecognizing() : ref.read(homeViewModel).startRecognizing() ;

                  },
                  child: Material(
                      shape: CircleBorder(),
                      elevation: 8,
                      child: Container(
                        padding: EdgeInsets.all(40),
                        height: 200,
                        width: 2000,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF089af8),
                        ),
                        child: Image.asset('assets/images/shazamLogo.png'),
                      )

                  ),
                ),
              )
            ],
          ),
        ),


    );
  }
}

