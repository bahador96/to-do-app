import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/controllers/task_controller.dart';
import 'package:flutter_application_1/controllers/textfield_controller.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyApp.changeColor(kLightBlueColor, Brightness.light);
    return Scaffold(
      floatingActionButton: const MyFloatingActionButton(),
      body: SafeArea(
          child: Stack(
        alignment: Alignment.bottomCenter,
        children: const [TopSectionWidget(), BottomSectionWidget()],
      )),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'hero',
      onPressed: () {
        Get.find<TaskController>().isEditing = false;
        Get.find<TextFieldController>().taskTitle!.text = '';
        Get.find<TextFieldController>().taskSubtitle!.text = '';

        Get.toNamed('/addscreen')!.then((value) {
          MyApp.changeColor(kLightBlueColor, Brightness.light);
        });
      },
      backgroundColor: kLightBlueColor,
      child: const Icon(Icons.add),
    );
  }
}

class BottomSectionWidget extends StatelessWidget {
  const BottomSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 50, top: 20, right: 10),
        child: Obx(
          () => ListView.separated(
            itemBuilder: (context, index) {
              var task = Get.find<TaskController>().tasks[index];
              return ListTile(
                onLongPress: () {
                  // Get.find<TaskController>().tasks.removeAt(index);
                  Get.defaultDialog(
                    title: 'delete message',
                    titleStyle: const TextStyle(fontSize: 18),
                    middleText: 'Should this task be deleted?',
                    middleTextStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.blueGrey[100],
                    radius: 40,
                    textCancel: 'No',
                    cancelTextColor: Colors.black,
                    onCancel: () {
                      Get.back();
                    },
                    textConfirm: 'Yes',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.find<TaskController>().tasks.removeAt(index);
                      Get.back();
                    },
                    barrierDismissible: false,
                  );
                },
                title: Text(task.taskTitle ?? ''),
                subtitle: Text(task.taskSubtitle ?? ''),
                onTap: () {
                  Get.find<TaskController>().isEditing = true;

                  Get.find<TaskController>().index = index;

                  Get.find<TextFieldController>().taskTitle!.text =
                      task.taskTitle!;

                  Get.find<TextFieldController>().taskSubtitle!.text =
                      task.taskSubtitle!;

                  Get.toNamed('/addscreen');
                },
                trailing: Checkbox(
                  value: task.status,
                  onChanged: (value) {
                    task.status = !task.status!;

                    Get.find<TaskController>().tasks[index] = task;
                  },
                  activeColor: kLightBlueColor,
                  side: const BorderSide(
                    color: Colors.black45,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black87,
                height: 1,
              );
            },

            // number
            itemCount: Get.find<TaskController>().tasks.length,
          ),
        ),
      ),
    );
  }
}

class TopSectionWidget extends StatelessWidget {
  const TopSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
        color: kLightBlueColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 40, top: 20),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Center(
                child: Icon(
                  Icons.bookmark,
                  color: kLightBlueColor,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50, top: 20),
            child: const Text(
              "All",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50, top: 5),
            child: Obx(
              () => Text(
                "${Get.find<TaskController>().tasks.length} Tasks",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
