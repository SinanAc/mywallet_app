import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final double heightSize;
  const ImageWidget({
    Key? key,
    required this.imagePath,
    required this.heightSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightSize,
      child: SvgPicture.asset(imagePath),
    );
  }
}
