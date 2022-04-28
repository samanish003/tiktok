import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUser => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retValue = [];
      for (var elem in query.docs) {
        retValue.add(User.fromSnap(elem));
      }
      return retValue;
    }));
  }
}
