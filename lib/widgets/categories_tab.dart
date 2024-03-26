import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';

class CategoriesTab extends StatelessWidget {
  final void Function(int index)? onTap;
  final int index;
  final String imagePath;
  final double width;
  final String label;
  final RxInt isSelected;

  const CategoriesTab({
    super.key,
    required this.index,
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!(index);
      },
      child: Obx(
        () => SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected.value == index ? blue : white,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(200)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(200)),
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8.0, bottom: 2.0),
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.nunito(
                    color: isSelected.value == index ? blue : unselectedBtm,
                    fontSize: isSelected.value == index ? 14 : 12,
                    fontWeight: isSelected.value == index
                        ? FontWeight.bold
                        : FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Divider(
                  thickness: 2,
                  color: isSelected.value == index ? blue : white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
