import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/controllers/task_controller.dart';
import 'package:flutter_application_1/controllers/textfield_controller.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/task_model.dart';
import 'package:get/get.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyApp.changeColor(const Color(0xFFF5F5F5), Brightness.dark);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MyCustomAppBar(),
            TitleWidget(),
            TaskTextField(),
            NoteWidget(),
            MyButton(),
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: Get.width,
      height: 40,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: kLightBlueColor,
          elevation: 0,
        ),
        onPressed: () {
          if (Get.find<TaskController>().isEditing) {
            // editing
            var task = Get.find<TaskController>()
                .tasks[Get.find<TaskController>().index];

            task.taskTitle = Get.find<TextFieldController>().taskTitle!.text;

            task.taskSubtitle =
                Get.find<TextFieldController>().taskSubtitle!.text;

            Get.find<TaskController>().tasks[Get.find<TaskController>().index] =
                task;
            //
          } else {
            // Adding
            Get.find<TaskController>().tasks.add(
                  TaskModel(
                    taskTitle: Get.find<TextFieldController>().taskTitle!.text,
                    taskSubtitle:
                        Get.find<TextFieldController>().taskSubtitle!.text,
                    status: false,
                  ),
                );
          }
          Get.back();
        },
        child: Text(
          Get.find<TaskController>().isEditing ? 'Edit' : 'Add',
        ),
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextField(
        controller: Get.find<TextFieldController>().taskSubtitle,
        maxLength: 30,
        cursorColor: kLightBlueColor,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.bookmark_border,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          counter: Container(),
          hintText: "Add note",
        ),
      ),
    );
  }
}

class TaskTextField extends StatelessWidget {
  const TaskTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: Get.find<TextFieldController>().taskTitle,
        maxLines: 6,
        cursorColor: kLightBlueColor,
        cursorHeight: 40,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20),
      child: Text(
        "What are you planning",
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget {
  const MyCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 45),
            child: Text(
              Get.find<TaskController>().isEditing ? 'Edit Task' : 'New Task',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Hero(
          tag: 'hero',
          child: Material(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        )
      ],
    );
  }
}
