import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wird/controllers/homepage_controller.dart';
import 'package:wird/data/static/homepage_tiles.dart';
import 'package:wird/views/widgets/homepage/lastread_card.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    final appheight = Get.context!.height;
    final appwidth = Get.context!.width;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        flexibleSpace: Opacity(
          opacity: .6,
          child:
              Image.asset("assets/effects/geopattern.png", fit: BoxFit.cover),
        ),
        title: const Text(
          "Mathani",
          style: TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.w600, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/effects/geopattern.png"),
            fit: BoxFit.cover,
            opacity: 0.6,
          )),
          child: Obx(
            () {
              final user = authController.user.value;
              var initial = "?"; // Default initial if user is null
              var name = "User"; // Default name if user is null
              if (user != null) {
                name = user.displayName ?? "User";
                initial = name.isNotEmpty ? name[0].toUpperCase() : "?";
              }

              return Column(
                children: [
                  const DrawerHeader(
                    child: Center(
                      child: Text(
                        "Mathani",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                    ),
                  ),
                  user == null
                      ? ListTile(
                          onTap: () => authController.signInWithGoogle(),
                          leading: const Icon(FontAwesomeIcons.google),
                          title: const Text("Sign in with Google"),
                        )
                      : CircleAvatar(
                          radius: 40,
                          child: Text(
                            initial,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                  user != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          child: Text(
                            name,
                            style: const TextStyle(fontSize: 20),
                          ),
                        )
                      : const SizedBox.shrink(),
                  user != null
                      ? ListTile(
                          onTap: () => authController.signOut(),
                          leading: const Icon(Icons.logout),
                          title: const Text("Sign out"),
                        )
                      : const SizedBox.shrink(),
                  const Divider(),
                  ListTile(
                    onTap: () => Get.toNamed('/pricing'),
                    leading: const Icon(Icons.monetization_on),
                    title: const Text("Pricing"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings_outlined),
                    title: Text("Settings"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text("About"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => Scaffold(
                            backgroundColor: Colors.black,
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              iconTheme:
                                  const IconThemeData(color: Colors.white),
                            ),
                            body: Center(
                              child: InteractiveViewer(
                                panEnabled: false,
                                scaleEnabled: true,
                                minScale: 1,
                                maxScale: 4,
                                child: Image.asset("assets/icons/jpg/fadl.jpg"),
                              ),
                            ),
                          ));
                    },
                    leading: const Icon(FontAwesomeIcons.bookQuran),
                    title: const Text("فضل قراءة القرءان الكريم"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: .6,
                  image: AssetImage("assets/effects/geopattern.png"))),
          height: appheight,
          width: appwidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Section : Last read card
              const Center(child: LastReadCard()),
              // Section : Get started title
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: appwidth * .05, vertical: appheight * .03),
                child: const Text(
                  'Get started',
                  style: TextStyle(
                    color: Color(0xFF004B40),
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              //Section : Tiles
              Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: homepageTiles.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => homepageTiles[index]),
              )
            ],
          )),
    );
  }
}
