import 'package:car_servicing/presentation/widgets/snackbarMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  //register with email & pass
  Future<User?> createUserWithEmailAndPassword(String email, String password, String name, String phone, String address, BuildContext context) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (cred.user != null) {
        await _firestore.collection('Users').doc(cred.user!.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'address': address,
        });
      }
      return cred.user;
    } on FirebaseAuthException catch (e) {
       if (e.code == 'email-already-in-use') {
          snackbarMessage(message: "The email already exists.", context: context,).show();
       }
       else if (e.code == 'network-request-failed') {
          snackbarMessage(message: "Network request failed. Please turn on the internet", context: context,).show();
        }
      return null;
    } catch (e) {
      // Handle any unexpected errors
    debugPrint("Error: $e");
    snackbarMessage(message: "Something went wrong. Please try again later.", context: context).show();
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserData(String uid,BuildContext context) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(uid).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      snackbarMessage(message: "Something went wrong. Please try again later.", context: context).show();
      return null;
    }
  }

  Future<String?> getUserName(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(uid).get();
      return doc['name'] as String?;
    } catch (e) {
      debugPrint("Error fetching user name: $e");
      return null;
    }
  }

  //login with email & pass
  Future<User?> loginUserWithEmailAndPassword(String email,String password,context) async{
    try {
      final cred= await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        snackbarMessage(message: "Invalid Email",context: context).show();
    }
     else if (e.code == 'user-not-found') {
      snackbarMessage(message: "User not found for this Email", context: context,).show();
    } else if (e.code == 'wrong-password') {
      snackbarMessage(message: "Wrong Password", context: context,).show();
    }
    else if (e.code == 'network-request-failed') {
      snackbarMessage(message: "Network request failed. Please turn on the internet", context: context,).show();
    }
      return null;
    } catch (e) {
      // Handle any unexpected errors
      debugPrint("Error: $e");
      snackbarMessage(message: "Something went wrong. Please try again later.",context: context,).show();
    }
    return null;
  }

  Future<void> signout(context) async{
    try {
      await _auth.signOut();
      snackbarMessage(message: "SignOut successful!", context: context,isError: false,).show();
    } catch (e) {
      debugPrint("Error: $e");
      snackbarMessage(message: "Something went wrong. Please try again later.",context: context,).show();
    }
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }
}