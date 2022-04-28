import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants.dart';
import '../../controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({Key? key, required this.id}) : super(key: key);

  final TextEditingController _commentController = TextEditingController();

  CommentController commentController = Get.put(CommentController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height * 0.88,
                child: Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: commentController.comments.length,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              "${comment.username}   ",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              comment.comment,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.datePublished.toDate().toString(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${comment.likes.length} likes',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () =>
                              commentController.likeComment(comment.id),
                          child: Icon(
                            Icons.favorite,
                            size: 25,
                            color:
                                comment.likes.contains(authController.user.uid)
                                    ? Colors.red
                                    : Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.grey,
                  child: ListTile(
                    title: TextFormField(
                      controller: _commentController,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'comment',
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        commentController.postComment(_commentController.text);
                        _commentController.text = "";
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent + 50,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.decelerate);
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
