import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:deep_ar_flutter_example/keys.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CameraDeepAr(
              onCameraReady: (isReady) {
                print("Camera status $isReady");
              },
              onImageCaptured: (path) {
                print("Image Taken $path");
              },
              onVideoRecorded: (path) {
                print("Video Recorded @ $path");
              },
              //Enter the App key generate from Deep AR
              androidLicenceKey: androidLicenceKey,
              iosLicenceKey: iosLicenceKey,
              cameraDeepArCallback: (c) async {
                cameraDeepArController = c;
                setState(() {});
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                //height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          Masks.values.length,
                          (p) {
                            bool active = currentPage == p;
                            return GestureDetector(
                              onTap: () {
                                currentPage = p;
                                cameraDeepArController.changeMask(p);
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: active ? 40 : 30,
                                height: active ? 50 : 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: active ? Colors.green : Colors.white,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "$p",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: active ? 16 : 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            );
                          },
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
    );
  }
}
