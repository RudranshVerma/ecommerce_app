
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/widgtes/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgtes/auth_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_storage/firebase_storage.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  late String extra;
  late String profileImage;
  late String name;
  late String email;
  late String password;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;
  dynamic _pickedImageError;
  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customer');
  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          // firebase_storage.Reference ref = firebase_storage
          //     .FirebaseStorage.instance
          //     .ref('cust-images/$email.jpg');
          // await ref.putFile(File(_imageFile!.path));
          // _uid = FirebaseAuth.instance.currentUser!.uid;
          // profileImage = await ref.getDownloadURL();
          // await customers.doc(_uid).set({
          //   'name': name,
          //   'email': email,
          //   'profileimage': profileImage,
          //   'phone': '',
          //   'address': '',
          //   'cid': _uid,
          // });
          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });
          Navigator.pushReplacementNamed(context, '/customer_home');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            MyMessageHandler.showSnackBar(
              _scaffoldKey,
              'The password provided is too weak.',
            );
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            MyMessageHandler.showSnackBar(
              _scaffoldKey,
              'The account already exists for that email.',
            );

            print('The account already exists for that email.');
          }
        }
      } else {
        MyMessageHandler.showSnackBar(
          _scaffoldKey,
          'please pick image first',
        );
      }
    } else {
      MyMessageHandler.showSnackBar(
        _scaffoldKey,
        'please fill all fields',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // var imageFile = _imageFile;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const AuthHeaderLabel(
                        headerlabel: 'Sign Up',
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.purpleAccent,
                              backgroundImage: _imageFile == null
                                  ? null
                                  : FileImage(File(_imageFile!.path)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.photo,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your full name';
                              }
                              return null;
                            },
                            onChanged: ((value) {
                              name = value;
                            }),
                            // controller: _namecontroller,
                            decoration: textFormDecoration.copyWith(
                              labelText: 'Full Name',
                              hintText: 'Enter Your Full Name',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              MyMessageHandler.showSnackBar(
                                _scaffoldKey,
                                'Please enter your email',
                              );
                              return 'please enter your email';
                            } else if (value.isValidEmail() == false) {
                              MyMessageHandler.showSnackBar(
                                _scaffoldKey,
                                'Please enter valid email',
                              );
                              return 'invalid email';
                            } else if (value.isValidEmail() == true) {
                              //   MyMessageHandler.showSnackBar(
                              //     _scaffoldKey,
                              //     'your email is valid',
                              //   );
                              // }
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          //controller: _emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Email Address',
                            hintText: 'Enter Your email ',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              }
                              return null;
                            },
                            onChanged: ((value) {
                              password = value;
                            }),
                            //controller: _passwordcontroller,
                            obscureText: passwordVisible,
                            decoration: textFormDecoration.copyWith(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.purple,
                                  )),
                              labelText: 'Password',
                              hintText: 'Enter Your Password',
                            )),
                      ),
                      HaveAccount(
                        haveAccount: 'Already have an account',
                        actionLabel: 'Log In ',
                        onPressed: () {},
                      ),
                      AuthMainButton(
                        mainButtonLabel: 'Sign up',
                        onPressed: () {
                          signUp();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
