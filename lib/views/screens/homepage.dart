import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wird/data/static/homepage_tiles.dart';
import 'package:wird/views/widgets/homepage/lastread_card.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
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
      drawer: const Drawer(),
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
