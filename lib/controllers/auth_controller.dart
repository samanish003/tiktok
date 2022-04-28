import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/user.dart' as model;
import 'package:tiktok/views/screens/auth/login_screen.dart';
import 'package:tiktok/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage = File("").obs;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialscreen);
  }

  _setInitialscreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Get.snackbar(
          'profile Picture', 'you have successfully selected your picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }
  //upload to firebase storage

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
  //registering the user

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && password.isNotEmpty && image != null) {
        //save out user to our auth firebase firestore

        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        String downloadUrl = await _uploadToStorage(image);

        print("downloadUrl: $downloadUrl");
        print("credential.user!.uid: ${credential.user!.uid}");
        print("username: $username");
        print("email: $email");

        model.User user = model.User(
          name: username,
          email: email,
          uid: credential.user!.uid,
          profilePhoto: downloadUrl,
        );
        var data = await firestore.collection('data').get();
        print("getData: 123456 $data");
        await firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar('error creating account', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('logging success');
      } else {
        Get.snackbar('error logging in ', 'please enter all the details');
      }
    } catch (e) {
      Get.snackbar('error logging in ', e.toString());
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
