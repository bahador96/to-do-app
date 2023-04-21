import 'package:flutter_application_1/models/task_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TaskController extends GetxController {
  bool isEditing = false;
  int index = 0;
  RxList<TaskModel> tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    var box = GetStorage();
    if (box.read('tasks') != null) {
      var list = box.read('tasks');
      for (var item in list) {
        tasks.add(TaskModel.fromJson(item));
      }
    }
    ever(tasks, (value) {
      box.write('tasks', tasks.toJson());
    });

    super.onInit();
  }
}
