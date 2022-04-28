import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/controllers/video_controller.dart';
import 'package:tiktok/views/widgets/circle_animation.dart';

import '../widgets/video_player_item.dart';
import 'comment_screen.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: data.videoUrl),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            data.username,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data.caption,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.music_note,
                                size: 15,
                                color: Colors.white,
                              ),
                              Text(
                                data.songName,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ).marginOnly(left: 10),
                      SizedBox(
                        width: 100,
                        height: Get.height * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildProfile(data.profilePhoto),
                            InkWell(
                              onTap: () => videoController.likeVideo(data.id),
                              child: Icon(
                                Icons.favorite,
                                size: 40,
                                color:
                                    data.likes.contains(authController.user.uid)
                                        ? Colors.red
                                        : Colors.white,
                              ),
                            ),
                            Text(
                              data.likes.length.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CommentScreen(id: data.id),
                                ),
                              ),
                              child: const Icon(
                                Icons.comment_sharp,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              data.commentCount.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.reply,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              data.shareCount.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            CircleAnimation(
                              child: buildMusicAlbum('profilePhoto'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }
}
