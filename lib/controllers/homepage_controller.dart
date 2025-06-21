import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  Rxn<User> user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(FirebaseAuth.instance.authStateChanges());
    super.onInit();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // Cancelled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      await storeUserInfo(); // ← Call to store info after successful login
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> storeUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    await docRef.set({
      'name': user.displayName,
      'email': user.email,
      'currentPlan': null,
      'finishDate': null, // <-- Add this line

      'isFree': null,
    }, SetOptions(merge: true)); // merge to avoid overwriting future data
  }
}
