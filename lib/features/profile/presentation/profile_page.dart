import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:transferme/core/custom/custom_app_bar.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile;
    return Scaffold(
      appBar: CustomAppBar(
        gap: Gap(isMobile ? 30 : 10),
        appBarTitle: 'Profile Settings',
      ),
      body: SafeArea(
        child: ResponsivePadding(
          horizontal: isMobile ? 16 : 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(isMobile ? 20 : 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  'Your Profile Information',
                  style: mediumText(14, AppColor.textLightGreyColor, null),
                ),
              ),
              Gap(isMobile ? 30 : 20),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: isMobile ? 50 : 30,
                  backgroundColor: AppColor.lightGreyColor,
                  child: Icon(
                    Icons.person,
                    size: isMobile ? 50 : 30,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
              Gap(isMobile ? 20 : 10),
              Text(
                'Personal Information',
                style: extraBoldText(
                  isMobile ? 16 : 8,
                  AppColor.lightPrimaryColor,
                  null,
                ),
              ),
              Gap(isMobile ? 15 : 10),
              profileInfoContainer(isMobile, title: 'Account Number'),
              profileInfoContainer(isMobile, title: 'Username'),
              profileInfoContainer(isMobile, title: 'Email'),
              profileInfoContainer(isMobile, title: 'Mobile Phone'),
              profileInfoContainer(isMobile, title: 'Address'),
              Gap(isMobile ? 20 : 10),
              Text(
                'Security',
                style: extraBoldText(
                  isMobile ? 16 : 8,
                  AppColor.lightPrimaryColor,
                  null,
                ),
              ),
              Gap(isMobile ? 15 : 10),
              profileInfoContainer(isMobile, title: 'Change Pin'),
              profileInfoContainer(isMobile, title: 'Change Password'),
              profileInfoContainer(isMobile, title: 'FingerPrint'),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileInfoContainer(bool isMobile, {required String title}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ResponsiveHelper.height(isMobile ? 10 : 10),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(isMobile ? 16 : 8),
        vertical: ResponsiveHelper.height(isMobile ? 10 : 5),
      ),
      width: ResponsiveHelper.width(
        isMobile ? ResponsiveHelper.screenWidth : 300,
      ),
      height: ResponsiveHelper.height(isMobile ? 45 : 45),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: headlineText(
              isMobile ? 12 : 5.5,
              AppColor.primaryColor,
              null,
            ),
          ),
          Text(
            '2093471587',
            style: mediumText(isMobile ? 13 : 8, AppColor.lightGreyColor, null),
          ),
        ],
      ),
    );
  }
}
