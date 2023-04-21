import 'package:flutter_application_1/controllers/task_controller.dart';
import 'package:flutter_application_1/controllers/textfield_controller.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController());
    Get.put(TextFieldController());
  }
}
