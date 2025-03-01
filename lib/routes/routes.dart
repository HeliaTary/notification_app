import 'package:get/get.dart';
import 'package:notification/pages/page_a.dart';
import 'package:notification/pages/page_b.dart';

final List<GetPage> appRoutes = [
  GetPage(name: '/', page: () => const ScreenA()),
  GetPage(name: '/details', page: () => const ScreenB()),
];
