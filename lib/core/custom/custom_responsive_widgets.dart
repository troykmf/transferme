import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

// responsive container widget
class ResponsiveContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;

  const ResponsiveContainer({
    super.key,
    required this.width,
    required this.height,
    this.child,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.width(width),
      height: ResponsiveHelper.height(height),
      padding: padding != null
          ? EdgeInsets.all(ResponsiveHelper.width(16))
          : null,
      margin: margin != null ? EdgeInsets.all(ResponsiveHelper.width(8)) : null,
      decoration: decoration,
      alignment: alignment,
      child: child,
    );
  }
}

// responsive text widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  const ResponsiveText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: ResponsiveHelper.sp(fontSize),
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }
}

// responsive padding
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final double? all;
  final double? horizontal;
  final double? vertical;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.all,
    this.horizontal,
    this.vertical,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding;

    if (all != null) {
      padding = EdgeInsets.all(ResponsiveHelper.width(all!));
    } else if (horizontal != null || vertical != null) {
      padding = EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(horizontal ?? 0),
        vertical: ResponsiveHelper.height(vertical ?? 0),
      );
    } else {
      padding = EdgeInsets.only(
        left: ResponsiveHelper.width(left ?? 0),
        right: ResponsiveHelper.width(right ?? 0),
        top: ResponsiveHelper.height(top ?? 0),
        bottom: ResponsiveHelper.height(bottom ?? 0),
      );
    }

    return Padding(padding: padding, child: child);
  }
}

// responsive button
class ResponsiveButton extends StatelessWidget {
  const ResponsiveButton({
    required this.text,
    super.key,
    required this.width,
    required this.onPressed,
  });
  final String text;
  final double width;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            ResponsiveHelper.width(width),
            ResponsiveHelper.height(45),
          ),
          // minimumSize: Size(
          //   ResponsiveHelper.width(width),
          //   ResponsiveHelper.height(72),
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.width(16)),
          ),
        ),
        child: Text(text, style: headlineText(16, AppColor.whiteColor, null)),
      ),
    );
  }
}
