import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submitAuthForm(
    String email,
    String password,
    String userName,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(userCredential.user.uid + '.jpg');

        await storageRef.putFile(image);

        final userImageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'username': userName,
          'email': email,
          'image_url': userImageUrl,
        });
      }
    } on PlatformException catch (error) {
      var message = 'An error occured, please check your credentials!';

      if (error.message != null) {
        message = error.message;
      }
      _showSnackBar(ctx, message);

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      _showSnackBar(ctx, err.message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
