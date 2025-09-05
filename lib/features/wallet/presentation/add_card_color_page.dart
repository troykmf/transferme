import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_app_bar.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

class AddCardColorScreen extends StatefulWidget {
  const AddCardColorScreen({super.key});

  @override
  State<AddCardColorScreen> createState() => _CardColorScreenState();
}

class _CardColorScreenState extends State<AddCardColorScreen> {
  Color selectedColor = const Color(
    0xFF7DD3E8,
  ); // Light blue (current card color)

  final List<Color> colorOptions = [
    const Color(0xFF7DD3E8), // Light blue
    const Color(0xFF4CAF50), // Green
    const Color(0xFF2196F3), // Blue
    const Color(0xFFFF9800), // Orange
    const Color(0xFFFF5722), // Red-orange
    const Color(0xFF00BCD4), // Cyan
    const Color(0xFFF44336), // Red
    const Color(0xFFFFEB3B), // Yellow
    const Color(0xFF9E9E9E), // Grey
    const Color(0xFF424242), // Dark grey
    const Color(0xFF000000), // Black
    const Color(0xFF1A237E), // Dark blue
    const Color(0xFF0D47A1), // Navy blue
    const Color(0xFF6A1B9A), // Purple
    const Color(0xFF7986CB), // Light purple
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(appBarTitle: 'Card Color'),
      body: SafeArea(
        child: ResponsivePadding(
          vertical: 16,
          horizontal: 30,
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Description
              Text(
                'Please, select a color to differentiat this card from other cards you have attached and organize your cards better.',
                style: mediumText(
                  isMobile ? 11.5 : 8,
                  AppColor.textLightGreyColor,
                  -.2,
                ).copyWith(),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 32),

              // Credit Card Preview
              Container(
                width: isMobile
                    ? double.infinity
                    : MediaQuery.of(context).size.width * 0.6,
                height: isMobile ? 171 : 220,
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Anderson',
                          style: headlineText(
                            isMobile ? 11 : 9,
                            AppColor.whiteColor,
                            null,
                          ),
                        ),
                        Text(
                          'A Debit Card',
                          style: headlineText(
                            isMobile ? 10 : 8,
                            AppColor.whiteColor,
                            null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2423   3581   9503   2412',
                          style: extraBoldText(
                            isMobile ? 14 : 11,
                            AppColor.whiteColor,
                            null,
                          ),
                        ),

                        Text(
                          '21 / 24',
                          style: extraBoldText(
                            isMobile ? 14 : 11,
                            AppColor.whiteColor,
                            null,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Balance',
                          style: mediumText(
                            isMobile ? 10 : 7.54,
                            AppColor.whiteColor,
                            null,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$3,100.30',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 24 : 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Visa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 16 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 10 : 40),

              // Color Grid
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(isMobile ? 30 : 130),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: colorOptions.length + 1, // +1 for the plus button
                  itemBuilder: (context, index) {
                    if (index == colorOptions.length) {
                      // Plus button
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF2196F3),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFF2196F3),
                          size: 24,
                        ),
                      );
                    }

                    final color = colorOptions[index];
                    final isSelected = color == selectedColor;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle confirm action
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Card color confirmed!'),
                        backgroundColor: selectedColor,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5C6BC0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
