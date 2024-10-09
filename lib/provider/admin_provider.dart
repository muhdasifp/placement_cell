import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placement_hub/model/recruiter_model.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/utility/helper.dart';

class AdminProvider extends ChangeNotifier {
  ///
  final _jobCollection = FirebaseFirestore.instance.collection('jobs');
  final _recruiterCollection =
      FirebaseFirestore.instance.collection('recruiters');

  ///
  List<JobModel> allJobs = [];
  List<RecruiterModel> allRecruiter = [];

  /// for getting all jobs in firebase
  Future<void> getAllJobs() async {
    try {
      final snap = await _jobCollection.get();
      allJobs = snap.docs.map((doc) => JobModel.fromJson(doc)).toList();
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  /// get all recruiter details for admin
  Future<void> getAllRecruiter() async {
    try {
      var snap = await _recruiterCollection.get();
      allRecruiter =
          snap.docs.map((e) => RecruiterModel.fromJson(e.data())).toList();
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  /// admin wise delete jobs
  Future<void> deleteJob(String id) async {
    try {
      await _jobCollection.doc(id).delete();
      sendToastMessage(message: 'deleted');
      getAllJobs();
    } catch (e) {
      throw e.toString();
    }
  }

  /// admin can remove recruiter also
  Future<void> deleteRecruiter(String id) async {
    try {
      await _recruiterCollection.doc(id).delete();
      sendToastMessage(message: 'deleted');
      getAllRecruiter();
    } catch (e) {
      throw e.toString();
    }
  }
}
