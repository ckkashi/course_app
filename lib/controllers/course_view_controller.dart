import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CourseViewController extends GetxController {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  init(url) {
    controller = VideoPlayerController.networkUrl(Uri.parse(url));
    initializeVideoPlayerFuture = controller.initialize();
    return initializeVideoPlayerFuture;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
