import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<UserCredential> siginInwithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signUpwithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> recordUserAction(String userId, String actionDetails) async {
    var action = {
      'actionDetails': actionDetails,
      'timestamp': Timestamp.now(),
    };

    var userDoc = _firebaseFirestore.collection('users').doc(userId);

    await userDoc.get().then((doc) async {
      if (!doc.exists) {
        await userDoc.set({
          'user_actions': [action],
        });
      } else {
        var actions = List.from(doc.data()?['user_actions'] ?? []);
        var actionExists =
            actions.any((a) => a['actionDetails'] == actionDetails);

        if (!actionExists) {
          await userDoc.update({
            'user_actions': FieldValue.arrayUnion([action]),
          });
        } else {}
      }
    }).catchError((error) {
      debugPrint("Error updating/creating user action: $error");
    });
  }

  Future<void> recordOnboardingStatus(
      String userId, String moduleName, bool completed) async {
    var userDoc = _firebaseFirestore.collection('users').doc(userId);

    // Check if the document for this user already exists
    var doc = await userDoc.get();
    if (!doc.exists) {
      await userDoc.set({
        'user_actions': [
          {
            'actionDetails': '$moduleName onboarding',
            'completed': completed,
            'timestamp': Timestamp.now(),
          }
        ]
      });
    } else {
      // If the document exists, update it with the new onboarding status
      var action = {
        'actionDetails': '$moduleName onboarding',
        'completed': completed,
        'timestamp': Timestamp.now(),
      };
      await userDoc.update({
        'user_actions': FieldValue.arrayUnion([action]),
      });
    }
  }

  Future<bool> checkOnboardingCompleted(
      String userId, String moduleName) async {
    var userDoc =
        await _firebaseFirestore.collection('users').doc(userId).get();
    // Check if the document for the user exists
    if (!userDoc.exists) {
      // If not, this means the user is new and hasn't completed any onboarding
      return false;
    }
    var userActions = List.from(userDoc.data()?['user_actions'] ?? []);
    bool onboardingCompleted = userActions.any((action) =>
        action['actionDetails'] == '$moduleName onboarding' &&
        action['completed'] == true);

    return onboardingCompleted;
  }

  //saving results from the coghealth test and brain score test
  Future<void> saveCogHealthResults(String userId, int cogHealthScore) async {
    var userDoc = _firebaseFirestore.collection('users').doc(userId);
    var result = {
      'coghealthscore': cogHealthScore,
      'date': Timestamp.now(),
    };

    await userDoc.update({
      'user_results': FieldValue.arrayUnion([result]),
    }).catchError((error) {
      debugPrint("Error saving CogHealth results: $error");
    });
  }

  Future<void> saveBrainHealthResults(
      String userId, int brainHealthScore) async {
    var userDoc = _firebaseFirestore.collection('users').doc(userId);
    var result = {
      'brainhealthscore': brainHealthScore,
      'date': Timestamp.now(),
    };

    await userDoc.update({
      'user_results': FieldValue.arrayUnion([result]),
    }).catchError((error) {
      debugPrint("Error saving BrainHealth results: $error");
    });
  }

  Future<Map<String, List<Map<String, dynamic>>>> getUserResults(
      String userId) async {
    var userDoc = _firebaseFirestore.collection('users').doc(userId);
    var doc = await userDoc.get();
    if (doc.exists) {
      Map<String, List<Map<String, dynamic>>> results = {};
      var userResults =
          List<Map<String, dynamic>>.from(doc.data()?['user_results'] ?? []);
      results['coghealth'] = userResults
          .where((result) => result.containsKey('coghealthscore'))
          .toList();
      results['brainhealth'] = userResults
          .where((result) => result.containsKey('brainhealthscore'))
          .toList();
      return results;
    } else {
      return {
        'coghealth': [],
        'brainhealth': []
      }; // Return empty lists if no results
    }
  }
  // Getters for accessing the Firebase services

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;
  FirebaseStorage get firebaseStorage => _firebaseStorage;
  // ... [rest of the class] ...
}
