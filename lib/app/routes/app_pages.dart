import 'package:get/get.dart';
import 'package:module5/app/modules/gps/bindings/gps_binding.dart';
import 'package:module5/app/modules/gps/views/gps_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => GpsView(),
      binding: GpsBinding(),
    ),
  ];
}
