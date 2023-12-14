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
    debugPrint('Signing out user ${_firebaseAuth.currentUser?.uid}');
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
    debugPrint('Recording user action: $actionDetails');
    var action = {
      'actionDetails': actionDetails,
      'timestamp': Timestamp.now(),
    };

    var userDoc = _firebaseFirestore.collection('users').doc(userId);

    await userDoc.get().then((doc) async {
      if (!doc.exists) {
        debugPrint('Creating user document with initial action');
        await userDoc.set({
          'user_actions': [action],
        });
      } else {
        var actions = List.from(doc.data()?['user_actions'] ?? []);
        var actionExists =
            actions.any((a) => a['actionDetails'] == actionDetails);

        if (!actionExists) {
          debugPrint('Adding new action');
          await userDoc.update({
            'user_actions': FieldValue.arrayUnion([action]),
          });
        } else {
          debugPrint('Action already exists, not adding again');
        }
      }
    }).catchError((error) {
      debugPrint("Error updating/creating user action: $error");
    });
  }

  Future<void> recordOnboardingStatus(
      String userId, String moduleName, bool completed) async {
    debugPrint('Recording onboarding status for $moduleName: $completed');
    var action = {
      'actionDetails': '$moduleName onboarding',
      'completed': completed,
      'timestamp': Timestamp.now(),
    };

    var userDoc = _firebaseFirestore.collection('users').doc(userId);
    await userDoc.update({
      'user_actions': FieldValue.arrayUnion([action]),
    });
  }

  Future<bool> checkOnboardingCompleted(
      String userId, String moduleName) async {
    var userDoc =
        await _firebaseFirestore.collection('users').doc(userId).get();
    var userActions = List.from(userDoc.data()?['user_actions'] ?? []);
    return userActions.any((action) =>
        action['actionDetails'] == '$moduleName onboarding' &&
        action['completed'] == true);
  }
  // Getters for accessing the Firebase services

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;
  FirebaseStorage get firebaseStorage => _firebaseStorage;
  // ... [rest of the class] ...
}
