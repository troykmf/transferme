import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_bar.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';

class AddCardColorPage extends StatefulWidget {
  const AddCardColorPage({super.key});

  @override
  State<AddCardColorPage> createState() => _AddCardColorPageState();
}

class _AddCardColorPageState extends State<AddCardColorPage> {
  @override
  Widget build(BuildContext context) {
    int selectedColorIndex = 0; // Default to light blue (first color)
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Card Color'),
      body: SafeArea(
        child: ResponsivePadding(
          horizontal: 16,
          vertical: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please select a color to differentiate this card \nfrom the other cards you have attached and \norganize your cards better.',
                style: smallText(11.5, AppColor.textLightGreyColor, -.2),
                textAlign: TextAlign.start,
              ),
              Gap(35),
              // Add your color selection widgets here
              // For example, you can use a GridView to display color options
              cardDesignWidget(selectedColorIndex),
              Gap(30),
              colorSelectionGrid(selectedColorIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesignWidget(int selectedColorIndex) {
    return // Card preview
    Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: cardColors[selectedColorIndex],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Anderson',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'A Debit Card',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Text(
              '2423 3581 9503 2412',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
              ),
            ),

            SizedBox(height: 8),

            Text(
              '21 / 24',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),

            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Balance',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$3,100.30',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Visa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget colorSelectionGrid(int selectedColorIndex) {
    return // Color selection grid
    GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemCount: cardColors.length + 1, // +1 for the add button
      itemBuilder: (context, index) {
        if (index == cardColors.length) {
          // Add button
          return GestureDetector(
            onTap: () {
              // Handle add new color
            },
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF3B82F6), width: 2),
              ),
              child: Icon(Icons.add, color: Color(0xFF3B82F6), size: 24),
            ),
          );
        }

        return GestureDetector(
          // onTap: onTap,
          onTap: () {
            setState(() {
              selectedColorIndex = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: cardColors[index],
              shape: BoxShape.circle,
              border: selectedColorIndex == index
                  ? Border.all(color: Colors.white, width: 3)
                  : null,
            ),
          ),
        );
      },
    );
  }
}

// class CardColorScreen extends StatefulWidget {
//   @override
//   _CardColorScreenState createState() => _CardColorScreenState();
// }

// class _CardColorScreenState extends State<CardColorScreen> {
//   int selectedColorIndex = 0; // Default to light blue (first color)

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF2D2D2D),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Color(0xFF5B6BCF),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Text(
//                     'Card Color',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),

//             // Description text
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               child: Text(
//                 'Please, select a color to differentiat this card from other cards you have attached and organize your cards better.',
//                 style: TextStyle(
//                   color: Color(0xFF9CA3AF),
//                   fontSize: 16,
//                   height: 1.4,
//                 ),
//               ),
//             ),

//             SizedBox(height: 40),

//             SizedBox(height: 50),

//             // Color selection grid
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 20,
//                 ),
//                 itemCount: cardColors.length + 1, // +1 for the add button
//                 itemBuilder: (context, index) {
//                   if (index == cardColors.length) {
//                     // Add button
//                     return GestureDetector(
//                       onTap: () {
//                         // Handle add new color
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: Color(0xFF3B82F6),
//                             width: 2,
//                           ),
//                         ),
//                         child: Icon(
//                           Icons.add,
//                           color: Color(0xFF3B82F6),
//                           size: 24,
//                         ),
//                       ),
//                     );
//                   }

//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedColorIndex = index;
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: cardColors[index],
//                         shape: BoxShape.circle,
//                         border: selectedColorIndex == index
//                             ? Border.all(
//                                 color: Colors.white,
//                                 width: 3,
//                               )
//                             : null,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             Spacer(),

//             // Confirm button
//             Padding(
//               padding: EdgeInsets.all(24),
//               child: Container(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle confirm
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Color confirmed!'),
//                         backgroundColor: cardColors[selectedColorIndex],
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF5B6BCF),
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(28),
//                     ),
//                   ),
//                   child: Text(
//                     'Confirm',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Main app wrapper
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Card Color Selection',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: CardColorScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

final List<Color> cardColors = [
  Color(0xFF7DD3FC), // Light blue (default)
  Color(0xFF22C55E), // Green
  Color(0xFF3B82F6), // Blue
  Color(0xFFF97316), // Orange
  Color(0xFFEF4444), // Red-orange
  Color(0xFF0EA5E9), // Sky blue
  Color(0xFFDC2626), // Red
  Color(0xFFFBBF24), // Yellow
  Color(0xFF6B7280), // Gray
  Color(0xFF374151), // Dark gray
  Color(0xFF000000), // Black
  Color(0xFF1E3A8A), // Navy blue
  Color(0xFF1E40AF), // Dark blue
  Color(0xFF7C3AED), // Purple
  Color(0xFF8B5CF6), // Light purple
];
