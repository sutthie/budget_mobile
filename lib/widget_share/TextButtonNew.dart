import 'package:flutter/material.dart';

class TextButtonNew extends StatelessWidget {
  const TextButtonNew({
    Key? key,
    required this.text,
    required this.press,
    required this.bgcolor,
    required this.bordercolor,
    required this.bordersize,
    required this.txtcolor,
    required this.width,
    required this.height,
    required this.radius,
  }) : super(key: key);

  final String? text;
  final Function? press;
  final Color bgcolor;
  final Color bordercolor;
  final double bordersize;
  final Color txtcolor;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width == 1) ? double.maxFinite : width,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(Size(width, height)),
          backgroundColor: WidgetStateProperty.all(bgcolor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(
                color: bordercolor, // Change this color
                width: bordersize, // Adjust the border width
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 25,
            color: txtcolor,
          ),
        ),
      ),
    );
  }
}
