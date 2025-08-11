import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transferme/core/util/app_assets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/features/home/presentation/drawer_page.dart';
import 'package:transferme/features/home/presentation/home_page.dart';
import 'package:transferme/features/profile/presentation/profile_page.dart';
import 'package:transferme/features/stats/presentation/stats_page.dart';
import 'package:transferme/features/wallet/presentation/wallets_page.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(bottomNavigationBar: CurvedBottomNavigationBar());
//   }
// }

// class CurvedBottomNavigationBar extends StatefulWidget {
//   const CurvedBottomNavigationBar({super.key});

//   @override
//   State<CurvedBottomNavigationBar> createState() =>
//       _CurvedBottomNavigationBarState();
// }

// class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar> {
//   // Track which navigation item is currently selected (0-3)
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     const HomePage(),
//     const WalletsPage(),
//     const StatsPage(),
//     const ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Simple placeholder content for demonstration
//       body: _pages[_selectedIndex],

//       backgroundColor: Colors.transparent,

//       // The custom bottom navigation bar with bottom padding
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.only(
//           left: 20,
//           right: 20,
//           bottom: 20, // This creates space from the screen bottom
//         ),
//         height: 70, // Slightly reduced height for better proportions
//         // Container decoration to create the curved, elevated look
//         decoration: const BoxDecoration(
//           color: Colors.white, // White background
//           // Full rounded corners since it's now floating
//           borderRadius: BorderRadius.all(Radius.circular(25)),

//           // More prominent shadow since it's floating
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.black26, // Slightly darker shadow
//           //     blurRadius: 15, // More blur for floating effect
//           //     offset: Offset(0, 5), // Shadow below the floating bar
//           //     spreadRadius: 1,
//           //   ),
//           // ],
//         ),

//         // Row to arrange navigation items horizontally
//         child: Row(
//           // No spacing needed since items will expand to fill space
//           children: [
//             // Navigation item 1: Home (initially active)
//             _buildNavItem(
//               activeIcon: SvgPicture.asset(AppSvgs.activeHomeIcon),
//               inactiveIcon: SvgPicture.asset(AppSvgs.inactiveHomeIcon),
//               index: 0,
//             ),

//             // Navigation item 2: Credit card/wallet
//             _buildNavItem(
//               activeIcon: SvgPicture.asset(AppSvgs.activeWalletIcon),
//               inactiveIcon: SvgPicture.asset(AppSvgs.inactiveWalletIcon),
//               index: 1,
//             ),

//             // Navigation item 3: Bar chart/analytics
//             _buildNavItem(
//               activeIcon: SvgPicture.asset(AppSvgs.activeStatsIcon),
//               inactiveIcon: SvgPicture.asset(AppSvgs.inactiveStatsIcon),
//               index: 2,
//             ),

//             // Navigation item 4: Profile/user
//             _buildNavItem(
//               activeIcon: null,
//               inactiveIcon: SvgPicture.asset(AppSvgs.activeProfileIcon),
//               index: 3,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Helper method to build individual navigation items
//   ///
//   /// Parameters:
//   /// - [icon]: The Flutter icon to display
//   /// - [index]: The position index (0-3) for this navigation item
//   Widget _buildNavItem({
//     required Widget? activeIcon,
//     required Widget? inactiveIcon,
//     required int index,
//   }) {
//     // Determine if this item should be highlighted (selected state)
//     final bool selected = _selectedIndex == index;

//     return Expanded(
//       // Each nav item takes equal space in the row
//       child: GestureDetector(
//         // Handle tap events to change the selected item
//         onTap: () {
//           if (index == 3) {
//             if (mounted) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfilePage()),
//               );
//             }
//           } else {
//             setState(() {
//               _selectedIndex = index; // Update the selected index
//             });
//           }
//         },
//         child: AnimatedContainer(
//           margin: const EdgeInsets.only(
//             left: 25,
//             right: 25,
//             top: 10,
//           ), // Spacing between items
//           duration: const Duration(milliseconds: 200), // Smooth animation
//           height: double.infinity, // Take full height of the navigation bar
//           // Container decoration for the highlight effect
//           decoration: BoxDecoration(
//             // Purple background ONLY when selected, completely transparent when not
//             color: selected ? const Color(0xFF5B67CA) : Colors.transparent,

//             // Rounded corners that match the navigation bar's corners
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//           ),

//           // Center the icon within the container
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 20.0),
//               child: selected
//                   ? activeIcon // Use the active icon when selected
//                   : inactiveIcon, // Use the inactive icon when not selected
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

/// MainPage serves as the root container for the app's main navigation
/// Features:
/// - Bottom navigation bar with 4 tabs
/// - Custom drawer overlay system
/// - Blur effect when drawer is open
/// - Drawer state management
/// - Bottom navigation bar hiding when drawer is open
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  // Track currently selected bottom navigation tab (0-3)
  int _selectedIndex = 0;

  // Track drawer state (open/closed)
  bool _isDrawerOpen = false;

  // List of pages corresponding to bottom navigation tabs
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize pages with menu callback for HomePage
    _pages = [
      HomePage(onMenuPressed: _toggleDrawer), // Pass drawer toggle to HomePage
      const WalletsPage(),
      const StatsPage(),
      const ProfilePage(),
    ];
  }

  /// Toggles the drawer state and triggers UI rebuild
  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColor.veryLightGreyColor, // Use a light background color
      body: Stack(
        children: [
          // MAIN CONTENT AREA with conditional blur effect
          AnimatedContainer(
            color: Colors.transparent,
            duration: const Duration(milliseconds: 300),
            child: _isDrawerOpen
                ? BackdropFilter(
                    // Apply blur effect when drawer is open
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      // Dark overlay to enhance blur effect
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: _pages[_selectedIndex],
                    ),
                  )
                : _pages[_selectedIndex], // Normal content when drawer is closed
          ),

          // INVISIBLE OVERLAY - Closes drawer when tapping outside
          if (_isDrawerOpen)
            GestureDetector(
              onTap: _toggleDrawer, // Close drawer on background tap
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent, // Invisible but captures taps
              ),
            ),

          // CUSTOM DRAWER - Positioned overlay
          if (_isDrawerOpen)
            Positioned(
              left: 0, // Align to left edge
              top: 0, // Full height from top
              bottom: 0, // Full height to bottom
              child: GestureDetector(
                onTap: () {}, // Prevent drawer from closing when tapped
                child: DrawerPage(
                  onClose: _toggleDrawer,
                ), // Custom drawer with close callback
              ),
            ),
        ],
      ),

      // BOTTOM NAVIGATION BAR with conditional visibility
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _isDrawerOpen
            ? 0
            : 80 +
                  MediaQuery.of(context)
                      .padding
                      .bottom, // Add padding.bottom for safe area (e.g., iPhone notch)
        child: OverflowBox(
          // Allows the child to overflow when sliding, preventing clipping
          alignment: Alignment.topCenter,
          child: AnimatedOpacity(
            // Hide navigation bar when drawer is open
            opacity: _isDrawerOpen ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: AnimatedSlide(
              // Slide navigation bar down when drawer is open
              offset: _isDrawerOpen ? const Offset(0, 1) : Offset.zero,
              duration: const Duration(milliseconds: 300),
              child: CurvedBottomNavigationBar(
                selectedIndex: _selectedIndex,
                // Handle navigation item selection
                onItemSelected: (index) {
                  if (index == 3) {
                    // Navigate to profile page instead of showing in bottom nav
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  } else {
                    // Update selected index for other tabs
                    setState(() {
                      _selectedIndex = index;
                    });
                  }
                },
                // Pass menu press callback to navigation bar
                onMenuPressed: _toggleDrawer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CurvedBottomNavigationBar extends StatelessWidget {
  final int selectedIndex; // Currently selected tab index
  final Function(int) onItemSelected; // Callback for tab selection
  final VoidCallback onMenuPressed; // Callback for menu button

  const CurvedBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Floating navigation bar styling
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20, // Creates floating effect
      ),
      // height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ), // Fully rounded corners
      ),
      // Navigation items arranged horizontally
      child: Row(
        children: [
          // Navigation Item 1: Home
          _buildNavItem(
            activeIcon: SvgPicture.asset(AppSvgs.activeHomeIcon),
            inactiveIcon: SvgPicture.asset(AppSvgs.inactiveHomeIcon),
            index: 0,
            selectedIndex: selectedIndex,
            onTap: onItemSelected,
          ),

          // Navigation Item 2: Wallet
          _buildNavItem(
            activeIcon: SvgPicture.asset(AppSvgs.activeWalletIcon),
            inactiveIcon: SvgPicture.asset(AppSvgs.inactiveWalletIcon),
            index: 1,
            selectedIndex: selectedIndex,
            onTap: onItemSelected,
          ),

          // Navigation Item 3: Statistics
          _buildNavItem(
            activeIcon: SvgPicture.asset(AppSvgs.activeStatsIcon),
            inactiveIcon: SvgPicture.asset(AppSvgs.inactiveStatsIcon),
            index: 2,
            selectedIndex: selectedIndex,
            onTap: onItemSelected,
          ),

          // Navigation Item 4: Profile
          _buildNavItem(
            activeIcon: null, // Profile doesn't have active state in bottom nav
            inactiveIcon: SvgPicture.asset(AppSvgs.activeProfileIcon),
            index: 3,
            selectedIndex: selectedIndex,
            onTap: onItemSelected,
          ),
        ],
      ),
    );
  }

  /// Helper method to build individual navigation items
  ///
  /// Parameters:
  /// - [activeIcon]: Widget to show when item is selected
  /// - [inactiveIcon]: Widget to show when item is not selected
  /// - [index]: Position index of this navigation item
  /// - [selectedIndex]: Currently selected item index
  /// - [onTap]: Callback function for handling taps
  Widget _buildNavItem({
    required Widget? activeIcon,
    required Widget? inactiveIcon,
    required int index,
    required int selectedIndex,
    required Function(int) onTap,
  }) {
    // Determine if this item is currently selected
    final bool selected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index), // Handle tap and pass index
        child: AnimatedContainer(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
          duration: const Duration(
            milliseconds: 200,
          ), // Smooth selection animation
          height: double.infinity,
          // Background styling - purple when selected, transparent when not
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF5B67CA) : Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          // Center the icon within the container
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              // Show appropriate icon based on selection state
              child: selected ? activeIcon : inactiveIcon,
            ),
          ),
        ),
      ),
    );
  }
}
