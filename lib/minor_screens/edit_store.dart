import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/main_screens/upload_product.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';
import 'package:ecommerce_app/widgtes/snackbar.dart';
import 'package:ecommerce_app/widgtes/yellow_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditStore extends StatefulWidget {
  final dynamic data;
  const EditStore({Key? key, required this.data}) : super(key: key);

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  XFile? imageFileLogo, imageFileCover;
  dynamic _pickedImageError;
  final ImagePicker _picker = ImagePicker();
  late String storeName;
  late String phone;
  late String storeLogo;
  late String coverImage;
  bool processing = false;

  pickStoreLogo() async {
    try {
      final pickedStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileLogo = pickedStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  pickCoverImage() async {
    try {
      final pickedCoverImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileCover = pickedCoverImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Future uploadStoreLogo() async {
    if (imageFileLogo != null) {
      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('supp-images/${widget.data['email']}.jpg');

        await ref.putFile(File(imageFileLogo!.path));
        storeLogo = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      storeLogo = widget.data['storelogo'];
    }
  }

  Future uploadCoverImage() async {
    if (imageFileCover != null) {
      try {
        firebase_storage.Reference ref2 = firebase_storage
            .FirebaseStorage.instance
            .ref('supp-images/${widget.data['email']}.jpg-cover');

        await ref2.putFile(File(imageFileCover!.path));
        coverImage = await ref2.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      coverImage = widget.data['coverimage'];
    }
  }

  editStoreData() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('suppliers')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'storename': storeName,
        'phone': phone,
        'storelogo': storeLogo,
        'coverimage': coverImage
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  saveChanges() async {
    if (formKey.currentState!.validate()) {
      // continue
      formKey.currentState!.save();
      setState(() {
        processing = true;
      });
      await uploadStoreLogo().whenComplete(() async =>
          await uploadCoverImage().whenComplete(() => editStoreData()));
    } else {
      MyMessageHandler.showSnackBar(scaffoldKey, 'please fill all field');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
            leading: const AppBarBackButton(),
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppbarTitle(
              title: 'edit store',
            )),
        body: Form(
          key: formKey,
          child: Column(children: [
            Column(
              children: [
                const Text(
                  'Store logo',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(widget.data['storelogo']),
                    ),
                    Column(
                      children: [
                        YellowButton(
                            label: 'Change',
                            onPressed: () {
                              pickStoreLogo();
                            },
                            width: 0.25),
                        const SizedBox(
                          height: 10,
                        ),
                        imageFileLogo == null
                            ? const SizedBox()
                            : YellowButton(
                                label: 'Reset',
                                onPressed: () {
                                  setState(() {
                                    imageFileLogo = null;
                                  });
                                },
                                width: 0.25),
                      ],
                    ),
                    imageFileLogo == null
                        ? const SizedBox()
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                FileImage(File(imageFileLogo!.path)),
                          ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Divider(
                    color: Colors.yellow,
                    thickness: 2.5,
                  ),
                )
              ],
            ),
            Column(
              children: [
                const Text(
                  'Cover Image',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(widget.data['coverimage']),
                    ),
                    Column(
                      children: [
                        YellowButton(
                            label: 'Change',
                            onPressed: () {
                              pickCoverImage();
                            },
                            width: 0.25),
                        const SizedBox(
                          height: 10,
                        ),
                        imageFileCover == null
                            ? const SizedBox()
                            : YellowButton(
                                label: 'Reset',
                                onPressed: () {
                                  setState(() {
                                    imageFileCover = null;
                                  });
                                },
                                width: 0.25),
                      ],
                    ),
                    imageFileCover == null
                        ? const SizedBox()
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                FileImage(File(imageFileCover!.path)),
                          ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Divider(
                    color: Colors.yellow,
                    thickness: 2.5,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Store Name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  storeName = value!;
                },
                initialValue: widget.data['storename'],
                decoration: textFormDecoration.copyWith(
                    labelText: 'store name', hintText: 'Enter Store name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Phone No';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  phone = value!;
                },
                initialValue: widget.data['phone'],
                decoration: textFormDecoration.copyWith(
                    labelText: 'phone', hintText: 'Enter Phone no'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  YellowButton(
                      label: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 0.25),
                  processing == true
                      ? YellowButton(
                          label: 'Please Wait',
                          onPressed: () {
                            null;
                          },
                          width: 0.5)
                      : YellowButton(
                          label: 'Save Changes',
                          onPressed: () {
                            saveChanges();
                          },
                          width: 0.5),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: 'price .. \$',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.yellow, width: 1),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      borderRadius: BorderRadius.circular(10)),
);
