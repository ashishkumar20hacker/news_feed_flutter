import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';

class BottomNavItem extends StatelessWidget {
  final void Function(int index)? onTap;
  final int index;
  final String iconPath;
  final String label;
  final RxInt isSelected;

  const BottomNavItem({
    super.key,
    required this.index,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!(index);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(iconPath,
                    colorFilter: ColorFilter.mode(
                        isSelected.value == index ? blue : unselectedBtm,
                        BlendMode.srcIn)),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    label,
                    style: GoogleFonts.nunito(
                      color: isSelected.value == index ? blue : unselectedBtm,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
