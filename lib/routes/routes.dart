import 'package:flutter_application_1/pages/add_task_screen.dart';
import 'package:flutter_application_1/pages/home_screen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> get pages => [
        GetPage(
          name: '/homescreen',
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: '/addscreen',
          page: () => const AddTaskScreen(),
        )
      ];
}
