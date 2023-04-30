import 'package:flashnewsapp/views/homepage.dart';
import 'package:flashnewsapp/views/splashScreen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = '/splashScreen';
  static final routes = [
    GetPage(
        name: '/splashScreen',
        page: () => splashScreen(),
        transition: Transition.zoom),
    GetPage(
        name: '/homePage',
        page: () => homePage(),
        transition: Transition.fadeIn),
  ];
}
