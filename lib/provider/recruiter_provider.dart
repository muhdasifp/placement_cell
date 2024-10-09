import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/model/application_model.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/model/recruiter_model.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:placement_hub/view/landing/landing_screen.dart';
import 'package:placement_hub/view/recruiter/recruiter_home.dart';

class RecruiterProvider extends ChangeNotifier {
  ///-----------------INSTANCE OF FIREBASE AUTH-----------------///
  final _auth = FirebaseAuth.instance;

  ///-----------------INSTANCE OF FIRE-STORE COLLECTIONS-----------------///
  final _jobCollection = FirebaseFirestore.instance.collection('jobs');
  final _applicationCollection =
      FirebaseFirestore.instance.collection('applications');
  final _recruiterCollection =
      FirebaseFirestore.instance.collection('recruiters');

  ///-----------------POST JOB HELPERS-----------------///
  List<String> skillsList = [];
  String jobType = '';
  String jobCategory = '';

  ///-----------------TO STORE TEMPORARY APPLICATIONS AND JOBS-----------------///
  List<ApplicationModel> allApplications = [];

  ///-----------------LOGGED RECRUITER-----------------///
  late RecruiterModel recruiter;

  ///-----------------HELPER-----------------///

  //get job type from dropdown
  void getJobType(String type) {
    jobType = type;
    notifyListeners();
  }

  //get job category from dropdown
  void getJobCategory(String category) {
    jobCategory = category;
    notifyListeners();
  }

  //add skills
  void addSkills(String skill) {
    skillsList.add(skill);
    notifyListeners();
  }

  ///-----------------AUTHENTICATION-----------------///

  //login recruiter and save recruiter
  Future<void> loginRecruiter(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      getRecruiterProfile(credential.user!.uid);
      Get.off(() => const RecruiterHome());
    } on FirebaseAuthException catch (e) {
      sendToastMessage(message: e.code);
    } catch (E) {
      sendToastMessage(message: E.toString());
    }
  }

  // if new recruiter register and save
  Future<void> registerRecruiter(
      String email, String password, String company, String number) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        saveRecruiter(
          RecruiterModel(
            id: credential.user!.uid,
            email: email,
            password: password,
            company: company,
            number: number,
          ),
        );

        getRecruiterProfile(credential.user!.uid);
        Get.off(() => const RecruiterHome());
      } else {
        throw 'something went wrong please try after some times';
      }
    } on FirebaseAuthException catch (e) {
      sendToastMessage(message: e.code);
    } catch (E) {
      sendToastMessage(message: E.toString());
    }
  }

  //logout recruiter
  Future<void> logoutRecruiter() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LandingScreen());
    } on FirebaseAuthException catch (e) {
      sendToastMessage(message: e.code);
    } catch (E) {
      sendToastMessage(message: E.toString());
    }
  }

  ///-----------------SAVE USER PROFILE-----------------///

  //save recruiter profile
  Future<void> saveRecruiter(RecruiterModel recruiter) async {
    try {
      await _recruiterCollection.doc(recruiter.id).set(recruiter.toJson());
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///-----------------GET RECRUITER PROFILE-----------------///

  //get current recruiter profile
  Future<void> getRecruiterProfile(String uid) async {
    try {
      final snap = await _recruiterCollection.doc(uid).get();
      recruiter = RecruiterModel.fromJson(snap.data()!);
      notifyListeners();
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///-----------------JOBS RELATED THINGS-----------------///

  //to post new job
  Future<void> postJob(JobModel job) async {
    try {
      final doc = _jobCollection.doc();
      final docId = doc.id;
      await doc.set(JobModel(
        id: docId,
        recruiter: recruiter,
        title: job.title,
        description: job.description,
        salary: job.salary,
        location: job.salary,
        jobType: jobType,
        category: jobCategory,
        applicants: 0,
        skillRequired: skillsList,
        postDate: formatDate(DateTime.now()),
      ).toJson());
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  //to delete posted job
  Future<void> deleteJob(String jobId) async {
    try {
      await _jobCollection.doc(jobId).delete();
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///-----------------APPLICATION RELATED THINGS-----------------///

  //get applications according to their company's
  Future<void> getApplications() async {
    try {
      var snap = await _applicationCollection
          .where('job.company', isEqualTo: recruiter.company)
          .get();

      allApplications =
          snap.docs.map((doc) => ApplicationModel.fromJson(doc)).toList();

      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  //to edit the response of the posted jobs according to seeker profile
  Future<void> respondApplication(String response, String id) async {
    try {
      if (response.isNotEmpty) {
        await _applicationCollection.doc(id).update({
          "status": response,
        });
      }
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  //to schedule an interview
  Future<void> scheduleInterView({
    required String applicationId,
    required String date,
    required String place,
    required String time,
  }) async {
    try {
      await _applicationCollection.doc(applicationId).update({
        "status": "interview",
        "interview": date,
        "interview_location": place,
        "interview_time": time,
      });
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }
}
