import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PricingController extends GetxController {
  RxString currentPlanv = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentPlan();
  }

  Future<void> fetchCurrentPlan() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      final data = docSnap.data();
      final plan = data?['currentPlan'];

      currentPlanv.value = plan ?? 'Free Plan';
    }
  }

  Future<void> upgradeToProTier() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.defaultDialog(
        title: "Not Logged In",
        middleText: "You need to be logged in to upgrade.",
        textConfirm: "OK",
        confirmTextColor: Get.theme.primaryColorLight,
        onConfirm: Get.back,
      );
      return;
    }

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      final data = docSnap.data();
      final currentPlan = data?['currentPlan'];

      if (currentPlan != null && currentPlan == 'Pro Tier') {
        // Show popup if user already has a plan
        Get.defaultDialog(
          title: "Already Pro",
          middleText: "You already have the Pro Tier active.",
          textConfirm: "OK",
          confirmTextColor: Get.theme.primaryColorLight,
          onConfirm: Get.back,
        );

        return;
      }
      currentPlanv.value = 'Pro Tier';

      // Proceed to upgrade
      await docRef.update({
        'currentPlan': 'Pro Tier',
        'finishDate': Timestamp.fromDate(
          DateTime.now().add(const Duration(days: 30)),
        ),
        'isFree': false,
      });

      Get.snackbar("Success", "Upgraded to Pro Tier");
    }
  }

  Future<void> upgradeToUltimateTier() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.defaultDialog(
        title: "Not Logged In",
        middleText: "You need to be logged in to upgrade.",
        textConfirm: "OK",
        confirmTextColor: Get.theme.primaryColorLight,
        onConfirm: Get.back,
      );
      return;
    }

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      final data = docSnap.data();
      final currentPlan = data?['currentPlan'];

      if (currentPlan != null && currentPlan == 'Ultimate Tier') {
        // Show popup if user already has a plan
        Get.defaultDialog(
          title: "Already Ultimate",
          middleText: "You already have the Ultimate Tier active.",
          textConfirm: "OK",
          confirmTextColor: Get.theme.primaryColorLight,
          onConfirm: Get.back,
        );

        return;
      }

      currentPlanv.value = 'Ultimate Tier';

      // Proceed to upgrade
      await docRef.update({
        'currentPlan': 'Ultimate Tier',
        'finishDate': Timestamp.fromDate(
          DateTime.now().add(const Duration(days: 30)),
        ),
        'isFree': false,
      });

      Get.snackbar("Success", "Upgraded to Ultimate Tier");
    }
  }
}
