import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transferme/core/util/app_assets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/features/auth/data/provider/auth_provider.dart';
import 'package:transferme/features/test/image_test.dart';

class DrawerPage extends ConsumerWidget {
  // Callback function to close the drawer
  final VoidCallback? onClose;

  const DrawerPage({super.key, this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // Set drawer width to 80% of screen width
      width: MediaQuery.of(context).size.width * 0.75,

      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER SECTION - Profile information
          Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture with border and shadow
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: .5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        // Replace with actual profile image asset
                        backgroundImage: AssetImage(
                          'assets/images/profile_placeholder.jpg',
                        ),
                        backgroundColor: Colors.grey[300],
                        // Fallback icon if image fails to load
                        child: Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // User's full name
                    Text(
                      'William Smith',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // User's email address
                    Text(
                      'william.smith@gmail.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: -0.3), // Header animation

          const SizedBox(height: 30),

          // MENU ITEMS SECTION
          Expanded(
            child: Column(
              children: [
                // Menu Item 1: My Wallet
                _buildDrawerItem(
                  context,
                  icon: AppSvgs.inactiveWalletIcon,
                  title: 'My Wallet',
                  onTap: () {
                    onClose?.call(); // Close drawer
                    // TODO: Navigate to wallet page
                  },
                  delay: 200, // Animation delay
                ),

                // Menu Item 2: Profile
                _buildDrawerItem(
                  context,
                  icon: AppSvgs.activeProfileIcon,
                  title: 'Profile',
                  onTap: () {
                    onClose?.call(); // Close drawer
                    // TODO: Navigate to profile page
                  },
                  delay: 300,
                ),

                // Menu Item 3: Statistics
                _buildDrawerItem(
                  context,
                  icon: AppSvgs.inactiveStatsIcon,
                  title: 'Statistics',
                  onTap: () {
                    onClose?.call(); // Close drawer
                    // TODO: Navigate to statistics page
                  },
                  delay: 400,
                ),

                // Menu Item 4: Transfer
                _buildDrawerItem(
                  context,
                  icon: AppSvgs.transferIcon,
                  title: 'Transfer',
                  onTap: () {
                    onClose?.call(); // Close drawer
                    // TODO: Navigate to transfer page
                  },
                  delay: 500,
                ),

                // Menu Item 5: Settings
                _buildDrawerItem(
                  context,
                  icon: AppSvgs.settingsIcon,
                  title: 'Settings',
                  onTap: () {
                    onClose?.call(); // Close drawer
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  delay: 600,
                ),

                const Spacer(),

                // LOGOUT BUTTON - Fixed at bottom
                Container(
                      margin: const EdgeInsets.fromLTRB(50, 0, 50, 30),
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // onClose?.call(); // Close drawer first
                          // Navigator.of
                          _showLogoutDialog(
                            context,
                            ref,
                          ); // Show confirmation dialog
                        },
                        icon: SvgPicture.asset(
                          AppSvgs.logoutIcon,
                          width: 20,
                          height: 20,
                        ),
                        label: const Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF5B67CA,
                          ), // Primary color
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 5,
                          shadowColor: const Color(0xFF5B67CA).withOpacity(0.3),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(begin: -0.5), // Logout button animation
              ],
            ),
          ),
        ],
      ),
    ).animate().slideX(
      begin: -1.0,
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    ); // Entire drawer slide animation
  }

  /// Builds a single drawer item with icon, title, and tap handler
  Widget _buildDrawerItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
    required int delay,
  }) {
    return Container(
          height: 47,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            // Leading icon with styled container
            leading: SvgPicture.asset(icon),
            // Menu item title
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            onTap: onTap, // Handle tap events
            // Styling for the ListTile
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            hoverColor: const Color(
              0xFF5B67CA,
            ).withOpacity(0.05), // Hover effect
            splashColor: const Color(
              0xFF5B67CA,
            ).withOpacity(0.1), // Tap splash effect
          ),
        )
        .animate()
        // Fade in animation with delay
        .fadeIn(
          duration: 500.ms,
          delay: Duration(milliseconds: delay),
        )
        // Slide in from left animation with delay
        .slideX(
          begin: -0.3,
          duration: 600.ms,
          delay: Duration(milliseconds: delay),
        );
  }

  /// Shows a confirmation dialog when user tries to logout
  /// Includes Cancel and Logout options for user safety
  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            // Cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            // Confirm logout button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                ref.read(authProvider.notifier).logout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B67CA),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
