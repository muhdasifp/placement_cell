import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:placement_hub/view/home/home_screen.dart';

class UserProvider extends ChangeNotifier {
  bool isAccept = false;

  int stepperIndex = 0;
  String? selectedCourse;

  List<String> skillsList = [];

  //add skills
  addSkills(String skill) {
    skillsList.add(skill);
    notifyListeners();
  }

  //select course
  selectCourse(String course) {
    selectedCourse = course;
    notifyListeners();
  }

//for terms and conditions
  acceptContinue(bool status) {
    isAccept = status;
    notifyListeners();
  }

//to update index by clicking
  updateIndex() {
    stepperIndex += 1;
    notifyListeners();
  }

  //finally for all terms and conditions and field are filled user can enter to the home page
  enterHome() {
    if (isAccept) {
      Get.offAll(() => const HomeScreen());
    } else {
      sendToastMessage(
          message: 'Please Accept privacy and Conditions to continue');
    }
  }
}
