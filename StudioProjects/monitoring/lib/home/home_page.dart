import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monitoring/home/components/map/map.dart';
import 'package:video_js/video_js.dart';
import '../global/global.dart';
import 'components/SideBar/side_bar.dart';
import 'components/SideBar/side_bar_function.dart';
import 'components/header/header.dart';
import 'components/map/DispensingContainer/dispensing_container.dart';
import 'components/map/map_global.dart';
import 'components/right_side_menu/right_side_menu.dart';

///Домашняя


///для теста
bool errorWindowPath = false;


/// Переменая для видео плеера
bool buttonVideo = false;

StreamController homeController = StreamController.broadcast();

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.stream}) : super(key: key);

  final Stream stream;

  @override
  State<HomePage> createState() => _HomePageState();
}
///Таймер списка авто =========================================
Timer? timer;


timerForCars() {
  timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
    await getListAuto();
  });
}
///=============================================================

class _HomePageState extends State<HomePage> {
  ///Функция расширения карты ===================================
  mapExtension() {
    if (addEndHeader == menuTest && addEndHeader == animationTrue) {
      addEndHeader = !addEndHeader;
      menuTest = !menuTest;
      animationTrue = !animationTrue;
    } else {
      addEndHeader = !addEndHeader;
      menuTest = addEndHeader;
    }
  }
  ///============================================================

  @override
  void initState() {
    super.initState();
    timerForCars();
    widget.stream.listen((event) {
      if (event == 'header') {
        mapExtension();
        setState(() {});
      } else if (event == 'stateCars') {
        setState(() {});
      } else {
        testVideo(event);
      }
    });
  }

  @override
  void dispose() {

    _videoJsController!.dispose();

    super.dispose();
  }

  ///Видео Плеер ===========================================================
  testVideo(String name_video){
    if(_videoJsController == null) {
      _videoJsController = VideoJsController("videoId",
          videoJsOptions: VideoJsOptions(
              controls: true,
              loop: false,
              muted: false,
              aspectRatio: '16:9',
              fluid: false,
              language: 'ru',
              liveui: false,
              notSupportedMessage: 'this movie type not supported',
              playbackRates: [1, 2, 4, 8, 16],
              preferFullWindow: false,
              responsive: false,
              sources: [
                Source('http://$myId:$myPort/' + name_video, "video/webm")
              ],
              suppressNotSupportedError: false));
      _videoJsController!.onPlayerReady((p0) {
        if(p0 == 'true') _videoJsController!.play();
      });
    } else {
      _videoJsController!.setSRC('http://$myId:$myPort/' + name_video, type: "video/webm");
      _videoJsController!.play();
    }
    setState(() {});
  }
  ///========================

  VideoJsController? _videoJsController;
  ///=======================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Visibility(visible: addEndHeader, child: Header()),

              ///Боковое меню с лева ====
              Expanded(
                child: Row(
                  children: [
                    if (menuTest)
                      SideBar(
                        stream: controllerSideBar.stream,
                      ),

                    ///Карта
                    Expanded(
                        child: MyMap(
                      steam: controllerMap.stream,
                    )),
                  ],
                ),
              ),
              ///========================
            ],
          ),

          ///Боковое меню с права =======
          Positioned(
            right: 20,
            top: 80,
            child: RightSideMenu(),
          ),
          ///============================

          ///Видеоплеер =================
          if (buttonVideo)
            Center(
              child: Stack(
                children: [
                  Positioned(
                    left: position.dx,
                    top: position.dy,
                    child: Draggable(
                      feedback: Container(
                        width: 650,
                        height: 350,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      onDragEnd: (details) => setState(() {
                        position = details.offset;
                      }),
                      child: Stack(
                        children: [
                          Center(
                            child: _videoJsController != null
                                ? VideoJsWidget(
                                    videoJsController: _videoJsController!,
                                    height: 350,
                                    width: 650,
                                  )

                                ///Загрузка
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 20),
                                      Text('Loading'),
                                    ],
                                  ),
                          ),

                          ///иконка закрыть
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                buttonVideo = false;
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.highlight_remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ///============================
        ],
      ),
    );
  }
  Offset position = Offset(200, 200);
}
