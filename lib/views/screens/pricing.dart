import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wird/controllers/pricing_controller.dart';

class Pricing extends GetView<PricingController> {
  const Pricing({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PricingController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/effects/geopattern.png"),
          fit: BoxFit.cover,
          opacity: 0.6,
        )),
        child: SafeArea(child: LayoutBuilder(builder: (context, size) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.maxHeight * 0.05),
                const Text(
                  "Pricing",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.maxHeight * 0.02),
                const Text(
                  "Mathani is free to use, but you can support us by purchasing a premium subscription.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: size.maxHeight * 0.03),
                Obx(
                  () => Text(
                      "Your current plan is : ${controller.currentPlanv.value}",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.green[700])),
                ),
                SizedBox(height: size.maxHeight * 0.05),
                // Add your pricing cards here
                CustomCard(
                  title: "Pro tier",
                  description:
                      "Unlock all Mathani ai features and support the development of Mathani with Pro tier\n Advantages : \n- No ads\n- Unlimited access to all features for 12 hours/day\n- high priority in ai requests\n- Access to premium content",
                  price: "2490 Da/month",
                  size: size,
                ),
                SizedBox(height: size.maxHeight * 0.02),
                CustomCard(
                  title: "Ultimate tier",
                  description:
                      "Unlock all Mathani ai features and support the development of Mathani with Ultimate tier\n Advantages : \n- No ads\n- Unlimited access to all features for 24 hours/day\n- high priority in ai requests\n- Access to premium content",
                  price: "4990 Da/month",
                  size: size,
                ),
              ],
            ),
          );
        })),
      ),
    );
  }
}

class CustomCard extends GetView<PricingController> {
  final String title;
  final String description;
  final String price;
  final BoxConstraints size;
  const CustomCard({
    super.key,
    required this.size,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.maxWidth,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0), side: BorderSide.none),
          color: const Color.fromARGB(255, 240, 240, 240),
          shadows: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color.fromARGB(255, 15, 122, 19)),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16.0),
          Text(
            price,
            style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color.fromARGB(255, 15, 122, 19)),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 15, 122, 19),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              if (title == "Pro tier") {
                controller.upgradeToProTier();
              } else if (title == "Ultimate tier") {
                controller.upgradeToUltimateTier();
              }
            },
            child: const Text("Subscribe Now"),
          ),
        ],
      ),
    );
  }
}
