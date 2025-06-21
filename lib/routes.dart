import 'package:get/get.dart';
import 'package:wird/views/screens/duaa_screen.dart';
import 'package:wird/views/screens/homepage.dart';
import 'package:wird/views/screens/learn_screen.dart';
import 'package:wird/views/screens/memorize_screen.dart';
import 'package:wird/views/screens/play_screen.dart';
import 'package:wird/views/screens/prayertimes_screen.dart';
import 'package:wird/views/screens/pricing.dart';
import 'package:wird/views/screens/qibla_screen.dart';
import 'package:wird/views/screens/quran_screen.dart';
import 'package:wird/views/screens/surah_screen.dart';
import 'package:wird/views/screens/tafssir_screen.dart';

List<GetPage> pages = [
  GetPage(name: "/", page: () => const Homepage()),
  GetPage(name: "/quran", page: () => const QuranScreen()),
  GetPage(name: "/memorize", page: () => const MemorizeScreen()),
  GetPage(name: "/prayertimes", page: () =>  PrayerTimesScreen()),
  GetPage(name: "/qibla", page: () => const QiblaScreen()),
  GetPage(name: "/duaa", page: () => const DuaaScreen()),
  GetPage(name: "/surah", page: () => const SurahScreen()),
  GetPage(name: "/tafssir", page: () => const TafssirScreen()),
  GetPage(name: "/play", page: () => const PlayScreen()),
  GetPage(name: "/learn", page: () => const SurahHomePage()),
  GetPage(name: "/pricing", page: () => const Pricing()),
];
