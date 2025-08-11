// Example usage in a main screen
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transferme/core/util/app_assets.dart';
import 'package:transferme/features/home/presentation/home_page.dart';
import 'package:transferme/features/profile/presentation/profile_page.dart';
import 'package:transferme/features/stats/presentation/stats_page.dart';
import 'package:transferme/features/wallet/presentation/wallets_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: CurvedBottomNavigationBar());
  }
}

class CurvedBottomNavigationBar extends StatefulWidget {
  const CurvedBottomNavigationBar({super.key});

  @override
  State<CurvedBottomNavigationBar> createState() =>
      _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar> {
  // Track which navigation item is currently selected (0-3)
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const WalletsPage(),
    const StatsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Simple placeholder content for demonstration
      body: _pages[_selectedIndex],

      backgroundColor: Colors.transparent,

      // The custom bottom navigation bar with bottom padding
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20, // This creates space from the screen bottom
        ),
        height: 70, // Slightly reduced height for better proportions
        // Container decoration to create the curved, elevated look
        decoration: const BoxDecoration(
          color: Colors.white, // White background
          // Full rounded corners since it's now floating
          borderRadius: BorderRadius.all(Radius.circular(25)),

          // More prominent shadow since it's floating
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black26, // Slightly darker shadow
          //     blurRadius: 15, // More blur for floating effect
          //     offset: Offset(0, 5), // Shadow below the floating bar
          //     spreadRadius: 1,
          //   ),
          // ],
        ),

        // Row to arrange navigation items horizontally
        child: Row(
          // No spacing needed since items will expand to fill space
          children: [
            // Navigation item 1: Home (initially active)
            _buildNavItem(
              activeIcon: SvgPicture.asset(AppSvgs.activeHomeIcon),
              inactiveIcon: SvgPicture.asset(AppSvgs.inactiveHomeIcon),
              index: 0,
            ),

            // Navigation item 2: Credit card/wallet
            _buildNavItem(
              activeIcon: SvgPicture.asset(AppSvgs.activeWalletIcon),
              inactiveIcon: SvgPicture.asset(AppSvgs.inactiveWalletIcon),
              index: 1,
            ),

            // Navigation item 3: Bar chart/analytics
            _buildNavItem(
              activeIcon: SvgPicture.asset(AppSvgs.activeStatsIcon),
              inactiveIcon: SvgPicture.asset(AppSvgs.inactiveStatsIcon),
              index: 2,
            ),

            // Navigation item 4: Profile/user
            _buildNavItem(
              activeIcon: null,
              inactiveIcon: SvgPicture.asset(AppSvgs.activeProfileIcon),
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build individual navigation items
  ///
  /// Parameters:
  /// - [icon]: The Flutter icon to display
  /// - [index]: The position index (0-3) for this navigation item
  Widget _buildNavItem({
    required Widget? activeIcon,
    required Widget? inactiveIcon,
    required int index,
  }) {
    // Determine if this item should be highlighted (selected state)
    final bool selected = _selectedIndex == index;

    return Expanded(
      // Each nav item takes equal space in the row
      child: GestureDetector(
        // Handle tap events to change the selected item
        onTap: () {
          if (index == 3) {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
          } else {
            setState(() {
              _selectedIndex = index; // Update the selected index
            });
          }
        },
        child: AnimatedContainer(
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 10,
          ), // Spacing between items
          duration: const Duration(milliseconds: 200), // Smooth animation
          height: double.infinity, // Take full height of the navigation bar
          // Container decoration for the highlight effect
          decoration: BoxDecoration(
            // Purple background ONLY when selected, completely transparent when not
            color: selected ? const Color(0xFF5B67CA) : Colors.transparent,

            // Rounded corners that match the navigation bar's corners
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),

          // Center the icon within the container
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: selected
                  ? activeIcon // Use the active icon when selected
                  : inactiveIcon, // Use the inactive icon when not selected
            ),
          ),
        ),
      ),
    );
  }
}
