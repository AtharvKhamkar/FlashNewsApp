import 'package:flashnewsapp/views/homepage.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = '/homePage';
  static final routes = [
    
    GetPage(
        name: '/homePage',
        page: () => homePage(),
        transition: Transition.fadeIn),
  ];
}