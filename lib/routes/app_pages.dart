import 'package:crypto_app/View/login/login_page.dart';
import 'package:get/get.dart';

import 'app_routes.dart';


class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    // GetPage(
    //   name: AppRoutes.signup,
    //   page: () => SignupPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.dashboard,
    //   page: () => DashboardPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.profile,
    //   page: () => ProfilePage(),
    // ),
    // GetPage(
    //   name: AppRoutes.createPost,
    //   page: () => CreatePostPage(),
    // ),
  ];
}