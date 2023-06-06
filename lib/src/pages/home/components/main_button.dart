import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../detail_screen.dart';
import '../../../theme/home_text_theme.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required String svg,
    required Map<String, String> type,
    required Color backgroundColor,
  })  : svgIcon = svg,
        name = type,
        bgColor = backgroundColor;

  final String svgIcon;
  final Map<String, String> name;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = (MediaQuery.of(context).size.width - 72) / 2;
    final double buttonHeight =
        (MediaQuery.of(context).size.width - 48) / 2 * 1.05;

    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(-2, -2),
          ),
          BoxShadow(
            color: Colors.black87,
            offset: Offset(2, -2),
          ),
          BoxShadow(
            color: Colors.black87,
            offset: Offset(-2, 2),
          ),
          BoxShadow(
            color: Colors.black87,
            offset: Offset(2, 2),
          ),
          BoxShadow(
            color: Colors.black87,
            offset: Offset(4, 4),
          ),
          BoxShadow(
            color: Colors.black87,
            offset: Offset(6, 6),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            buttonWidth,
            buttonHeight,
          ),
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 80,
                child: SvgPicture.asset(
                  svgIcon,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name["korean"]!,
                    style: homeTheme.textTheme.labelLarge,
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Text(
                    name["english"]!.toUpperCase(),
                    style: homeTheme.textTheme.labelMedium,
                  ),
                ],
              )
            ],
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                drugName: name["english"]!,
                color: bgColor,
                svg: svgIcon,
              ),
            ),
          );
        },
      ),
    );
  }
}
