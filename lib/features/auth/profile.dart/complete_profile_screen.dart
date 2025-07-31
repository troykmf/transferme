import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/custom/custom_textfield.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transferme/features/auth/profile.dart/add_phone_number_screen.dart';
import 'package:transferme/features/auth/data/provider/auth_provider.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  XFile? _profilePicture;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    super.initState();
  }

  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  ref
                      .read(authProvider.notifier)
                      .selectAndCropProfilePicture(
                        context: context,
                        source: ImageSource.gallery,
                      );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  ref
                      .read(authProvider.notifier)
                      .selectAndCropProfilePicture(
                        context: context,
                        source: ImageSource.camera,
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> _pickAndCropProfilePicture() async {
  //   // Change: Enhanced permission handling with detailed status checks
  //   var status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     final picker = ImagePicker();
  //     try {
  //       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //       if (pickedFile != null) {
  //         final croppedFile = await ImageCropper().cropImage(
  //           sourcePath: pickedFile.path,
  //           maxWidth: 1000,
  //           maxHeight: 1000,
  //           compressQuality: 80,
  //           aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  //           uiSettings: [
  //             AndroidUiSettings(
  //               toolbarTitle: 'Crop Profile Picture',
  //               initAspectRatio: CropAspectRatioPreset.square,
  //               lockAspectRatio: true,
  //             ),
  //             IOSUiSettings(title: 'Crop Profile Picture'),
  //           ],
  //         );
  //         if (croppedFile != null) {
  //           setState(() {
  //             _profilePicture = XFile(croppedFile.path);
  //           });
  //         } else {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Cropping cancelled or failed')),
  //           );
  //         }
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
  //       print('Image picking error: $e');
  //     }
  //   } else if (status.isDenied) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Storage permission denied. Please allow access.'),
  //       ),
  //     );
  //   } else if (status.isPermanentlyDenied) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: const Text(
  //           'Permission permanently denied. Go to settings to enable.',
  //         ),
  //         action: SnackBarAction(
  //           label: 'Settings',
  //           onPressed: () {
  //             openAppSettings();
  //           },
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future<void> _pickAndCropProfilePicture() async {
    // Change: Removed permission_handler logic, relying on static permissions in manifest/plist
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          maxWidth: 1000,
          maxHeight: 1000,
          compressQuality: 80,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Profile Picture',
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
            IOSUiSettings(title: 'Crop Profile Picture'),
          ],
        );
        if (croppedFile != null) {
          setState(() {
            _profilePicture = XFile(croppedFile.path);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cropping cancelled or failed')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      print('Image picking error: $e'); // Log for debugging
    }
  }

  void _proceedToPhoneNumber() {
    if (_firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddPhoneNumberScreen(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            profilePicture: _profilePicture,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('First name and last name are required'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            children: [
              ResponsiveContainer(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 50,
                height: 25,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColor.whiteColor,
                  size: 15,
                ),
              ),
              Gap(65),
              Text(
                'Profile',
                style: headlineText(16, AppColor.blackColor, null),
              ),
            ],
          ),
        ),
      ),
      body: ResponsivePadding(
        horizontal: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(40),
            Text(
              'Please set up your profile',
              style: mediumText(12, AppColor.lightGreyColor, null),
            ),
            Gap(30),
            GestureDetector(
              onTap: _showImageSourceBottomSheet,
              child: Stack(
                children: [
                  ResponsiveContainer(
                    width: 134,
                    height: 134,
                    decoration: BoxDecoration(
                      color: authState.profileImagePath == null
                          ? AppColor.primaryColor
                          : null,
                      shape: BoxShape.circle,
                      image: authState.profileImagePath != null
                          ? DecorationImage(
                              image: FileImage(
                                File(authState.profileImagePath!),
                              ),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: authState.profileImagePath == null
                        ? Icon(
                            CupertinoIcons.share,
                            color: AppColor.whiteColor,
                            size: 17,
                          )
                        : null,
                  ),
                  if (authState.profileImagePath != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColor.whiteColor,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Gap(10),
            if (authState.profileImagePath != null)
              TextButton(
                onPressed: () =>
                    ref.read(authProvider.notifier).clearSelectedImage(),
                child: Text(
                  'Remove Image',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            // GestureDetector(
            //   onTap: _pickAndCropProfilePicture,
            //   child: ResponsiveContainer(
            //     width: 134,
            //     height: 134,
            //     decoration: BoxDecoration(
            //       color: _profilePicture == null ? AppColor.primaryColor : null,
            //       shape: BoxShape.circle,
            //       image: _profilePicture != null
            //           ? DecorationImage(
            //               image: FileImage(File(_profilePicture!.path)),
            //               fit: BoxFit.cover,
            //             )
            //           : null,
            //     ),
            //     child: _profilePicture == null
            //         ? Icon(
            //             CupertinoIcons.share,
            //             color: AppColor.whiteColor,
            //             size: 17,
            //           )
            //         : null,
            //   ),
            // ),
            Gap(30),
            CustomTextfield(
              text: 'First Name',
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              obscureText: false,
              autocorrect: false,
              hintText: 'e.g John',
            ),
            Gap(20),
            CustomTextfield(
              text: 'Last Name',
              controller: _lastNameController,
              keyboardType: TextInputType.text,
              obscureText: false,
              autocorrect: false,
              hintText: 'e.g Doe',
            ),
            Gap(50),
            CustomButton(
              onTap: () {
                _proceedToPhoneNumber();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AddPhoneNumberScreen(
                //       firstName: _firstNameController.text,
                //       lastName: _lastNameController.text,
                //       profilePicture: '',
                //     ),
                //   ),
                // );
              },
              width: 133,
              buttonTitle: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
