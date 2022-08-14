import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_wallet/view/core/colors.dart';

class NoDataImage extends StatelessWidget {
  const NoDataImage({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: SvgPicture.asset(image)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kRedColor,
            ),
          ),
        ),
      ],
    );
  }
}
