import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:placement_hub/model/job_model.dart';

///to format date to 11.02.2024
String formatDate(DateTime date) {
  String month = '';
  switch (date.month) {
    case 1:
      month = 'January';
    case 2:
      month = 'February';
    case 3:
      month = 'March';
    case 4:
      month = 'April';
    case 5:
      month = 'May';
    case 6:
      month = 'June';
    case 7:
      month = 'July';
    case 8:
      month = 'August';
    case 9:
      month = 'September';
    case 10:
      month = 'October';
    case 11:
      month = 'November';
    case 12:
      month = 'December';
    default:
      month = "${date.month}";
  }
  return "${date.day}.$month.${date.year}";
}

void sendToastMessage({required String message, Color color = Colors.red}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: color,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}

///to get random jobs in all jobs
List<JobModel> getRandomList(List<JobModel> list, int count) {
  if (list.length <= count) {
    return list;
  }

  List<JobModel> tempList = List.from(list);
  List<JobModel> selectedItems = [];

  Random random = Random();

  for (int i = 0; i < count; i++) {
    int randomIndex = random.nextInt(tempList.length);
    selectedItems.add(tempList[randomIndex]);
    tempList.removeAt(randomIndex);
  }

  return selectedItems;
}

///to get last added 6 jobs in all jobs
List<JobModel> getRecentJobs(List<JobModel> allJobs) {
  List<JobModel> myList =
      allJobs.length <= 6 ? allJobs : allJobs.sublist(allJobs.length - 6);
  return myList;
}

String? emailValidation(String? value) {
  if (value!.isEmpty) {
    return 'please enter a email';
  } else if (!value.isEmail) {
    return 'Enter a valid email';
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value!.isEmpty) {
    return 'enter password';
  } else if (value.length < 6) {
    return 'password must be 6 character';
  } else {
    return null;
  }
}

String? textFieldValidator(String? value) {
  if (value!.isEmpty) {
    return 'please fill the field';
  } else {
    return null;
  }
}

Color getRandomFluorescentColor() {
  Random random = Random();
  double hue = random.nextDouble() * 360;
  return HSVColor.fromAHSV(1.0, hue, 0.5, 1.0).toColor();
}
