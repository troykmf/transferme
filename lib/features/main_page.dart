// Example usage in a main screen
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transferme/core/util/app_assets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/features/home/presentation/home_page.dart';
import 'package:transferme/features/profile/presentation/profile_page.dart';
import 'package:transferme/features/stats/presentation/stats_page.dart';
import 'package:transferme/features/wallet/presentation/wallets_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const WalletsPage(),
    const StatsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedBottomNavigationBar(
        // currentIndex: _currentIndex,
        // onTap: (index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        // },
      ),
    );
  }
}

// class CustomBottomNavBar extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const CustomBottomNavBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       bottom: true,
//       child: Container(
//         margin: EdgeInsets.only(
//           left: 16,
//           right: 16,
//           bottom: MediaQuery.of(context).padding.bottom + 8,
//         ),
//         height: 70,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -5),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // Active tab curved background
//             AnimatedPositioned(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               left:
//                   widget.currentIndex * (MediaQuery.of(context).size.width / 4),
//               child: Container(
//                 width: MediaQuery.of(context).size.width / 4,
//                 height: 80,
//                 child: CustomPaint(painter: CurvedBackgroundPainter()),
//               ),
//             ),
//             // Navigation items
//             Row(
//               children: [
//                 _buildNavItem(
//                   SvgPicture.asset(AppSvgs.inactiveHomeIcon),
//                   SvgPicture.asset(AppSvgs.activeHomeIcon),
//                   0,
//                 ),
//                 _buildNavItem(
//                   SvgPicture.asset(AppSvgs.inactiveWalletIcon),
//                   SvgPicture.asset(AppSvgs.activeWalletIcon),
//                   1,
//                 ),
//                 _buildNavItem(
//                   SvgPicture.asset(AppSvgs.inactiveStatsIcon),
//                   SvgPicture.asset(AppSvgs.activeStatsIcon),
//                   2,
//                 ),
//                 _buildNavItem(
//                   SvgPicture.asset(AppSvgs.activeProfileIcon),
//                   null,
//                   3,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(Widget? outlinedIcon, Widget? filledIcon, int index) {
//     final isActive = widget.currentIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () => widget.onTap(index),
//         child: Container(
//           height: 80,
//           child: Center(
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: isActive ? Colors.white : Colors.transparent,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: isActive ? filledIcon : outlinedIcon,
//               // color: isActive ? AppColor.primaryColor : const Color(0xFFB8E6E1),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CurvedBackgroundPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = AppColor.primaryColor
//       ..style = PaintingStyle.fill;

//     final path = Path();

//     // Start from bottom left
//     path.moveTo(0, size.height);

//     // Curve up to create the rounded top
//     path.quadraticBezierTo(
//       size.width * 0.25,
//       0, // Control point
//       size.width * 0.5,
//       0, // End point of first curve
//     );

//     path.quadraticBezierTo(
//       size.width * 0.75,
//       0, // Control point
//       size.width,
//       size.height * 0.3, // End point
//     );

//     // Continue to bottom right
//     path.lineTo(size.width, size.height);

//     // Close the path
//     path.close();

//     canvas.drawPath(path, paint);

//     // Add subtle shadow effect
//     final shadowPaint = Paint()
//       ..color = Colors.black.withOpacity(0.1)
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

//     canvas.drawPath(path, shadowPaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

class CurvedBottomNavigationBar extends StatefulWidget {
  const CurvedBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CurvedBottomNavigationBar> createState() =>
      _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar> {
  // Track which navigation item is currently selected (0-3)
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light gray background for the main content area
      backgroundColor: Colors.grey[100],

      // Simple placeholder content for demonstration
      body: const Center(
        child: Text('Content goes here', style: TextStyle(fontSize: 24)),
      ),

      // The custom bottom navigation bar with bottom padding
      bottomNavigationBar: Container(
        // Add padding to lift the navigation bar from the bottom edge
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
          boxShadow: [
            BoxShadow(
              color: Colors.black26, // Slightly darker shadow
              blurRadius: 15, // More blur for floating effect
              offset: Offset(0, 5), // Shadow below the floating bar
              spreadRadius: 1,
            ),
          ],
        ),

        // Row to arrange navigation items horizontally
        child: Row(
          // No spacing needed since items will expand to fill space
          children: [
            // Navigation item 1: Home (initially active)
            _buildNavItem(icon: Icons.home, index: 0),

            // Navigation item 2: Credit card/wallet
            _buildNavItem(icon: Icons.credit_card, index: 1),

            // Navigation item 3: Bar chart/analytics
            _buildNavItem(icon: Icons.bar_chart, index: 2),

            // Navigation item 4: Profile/user
            _buildNavItem(icon: Icons.person_outline, index: 3),
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
  Widget _buildNavItem({required IconData icon, required int index}) {
    // Determine if this item should be highlighted (selected state)
    final bool selected = _selectedIndex == index;

    return Expanded(
      // Each nav item takes equal space in the row
      child: GestureDetector(
        // Handle tap events to change the selected item
        onTap: () {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
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
              child: Icon(
                icon,
                // White icon when selected, dark gray when not selected
                color: selected ? Colors.white : Colors.grey[600],
                size: 24, // Icon size for good visibility
              ),
            ),
          ),
        ),
      ),
    );
  }
}
