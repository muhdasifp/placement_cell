import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placement_hub/model/application_model.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/model/user_model.dart';
import 'package:placement_hub/utility/helper.dart';

class UserJobProvider extends ChangeNotifier {
  final _applicationCollection =
      FirebaseFirestore.instance.collection('applications');
  final _jobCollection = FirebaseFirestore.instance.collection("jobs");
  final _userCollection = FirebaseFirestore.instance.collection("users");
  final _currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  late UserModel currentUser;

  String searchTextValue = '';

  int applicationNumber = 0;

  List<ApplicationModel> myApplications = [];
  List<JobModel> allJobs = [];
  List<JobModel> searchJobs = [];
  List<JobModel> filterJobs = [];

  List<String> temp = [];

  Future<void> getCurrentUserProfile() async {
    try {
      var snap = await _userCollection.doc(_currentUserUid).get();
      currentUser = UserModel.fromJson(snap);
      notifyListeners();
    } catch (e) {
      sendToastMessage(message: e.toString());
    } finally {
      getMyApplications();
    }
  }

  Future<void> applyNewJobs(JobModel job) async {
    try {
      final status = await _checkApplicationExists(job.id!);
      if (!status) {
        final doc = _applicationCollection.doc();
        final docId = doc.id;
        await doc.set(
          ApplicationModel(
            id: docId,
            job: job,
            seeker: currentUser,
            date: formatDate(DateTime.now()),
          ).toJson(),
        );
        await _jobCollection.doc(job.id).update(
          {
            "applicants": FieldValue.increment(1),
          },
        );
        sendToastMessage(
          message: 'Application has been sent to Recruiter',
          color: Colors.green,
        );
      } else {
        sendToastMessage(
          message: 'Application already send to recruiter please check status',
          color: Colors.orangeAccent,
        );
      }
    } catch (e) {
      sendToastMessage(message: e.toString());
      throw e.toString();
    }
  }

  Future<bool> _checkApplicationExists(String jobId) async {
    try {
      return await _applicationCollection
          .where('seeker.uid', isEqualTo: currentUser.uid)
          .where('job.id', isEqualTo: jobId)
          .get()
          .then((value) => value.size > 0 ? true : false);
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  Future<void> getMyApplications() async {
    try {
      var snap = await _applicationCollection
          .where('seeker.uid', isEqualTo: currentUser.uid)
          .get();
      myApplications =
          snap.docs.map((e) => ApplicationModel.fromJson(e)).toList();
      applicationNumber = myApplications.length;
      notifyListeners();
    } catch (e) {
      sendToastMessage(message: e.toString());
      throw e.toString();
    }
  }

  Future<void> deleteApplication(String id) async {
    try {
      await _applicationCollection.doc(id).delete();
      getMyApplications();
    } catch (e) {
      sendToastMessage(message: e.toString());
      throw e.toString();
    }
  }

  Color getApplicationStatusColor(String status) {
    switch (status) {
      case "applied":
        return Colors.blue;

      case "pending":
        return Colors.amber;

      case "rejected":
        return Colors.red;

      case "interview":
        return Colors.green;

      default:
        return Colors.blue.shade50;
    }
  }

  Future<void> getAllJobs() async {
    try {
      var snap = await _jobCollection.get();
      allJobs = snap.docs.map((e) => JobModel.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  void searchForJobs(String text) {
    searchTextValue = text;
    searchJobs = allJobs
        .where((element) => element.title!
            .toLowerCase()
            .contains(searchTextValue.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void _filterMyJobs() {
    if (temp.isNotEmpty) {
      filterJobs =
          allJobs.where((element) => temp.contains(element.category)).toList();
    }
    notifyListeners();
  }

  void addToFilter(String text) {
    temp.add(text);
    _filterMyJobs();
    notifyListeners();
  }

  void removeFromFilter(String text) {
    temp.remove(text);
    _filterMyJobs();
    notifyListeners();
  }

  UserJobProvider() {
    getAllJobs();
    getMyApplications();
  }
}
