import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  Comment(
      {required this.likes,
      required this.uid,
      required this.id,
      required this.profilePhoto,
      required this.username,
      required this.comment,
      required this.datePublished});

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshhot = snap.data() as Map<String, dynamic>;
    return Comment(
      username: snapshhot['username'],
      comment: snapshhot['comment'],
      datePublished: snapshhot['datePublished'],
      likes: snapshhot['likes'],
      profilePhoto: snapshhot['profilePhoto'],
      uid: snapshhot['uid'],
      id: snapshhot['id'],
    );
  }
}
