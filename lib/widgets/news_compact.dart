import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/Utilities/pref.dart';
import 'package:news_feed/models/article.dart';
import 'package:news_feed/screens/webview_screen.dart';

class NewsCompact extends StatelessWidget {
  final Article article;

  const NewsCompact({
    super.key,
    required this.article,
  }); // Correct super constructor call

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url: article.url ?? ''),)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: unselectedCd,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(color: blue)),
                ),
                errorWidget: (context, url, error) =>
                    SvgPicture.asset("${assetImagePath}placeholder.svg"),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              // Wrap Text with Expanded
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  article.description ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                bool isAlreadySaved = Pref.checkArticleSaved(article.title ?? "");
                isAlreadySaved
                    ? Pref.removeFromSaved(article)
                    : Pref.addToSaved(article);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 30.0,
                ),
                child: Obx(
                  () => SvgPicture.asset(
                    Pref.checkArticleSaved(article.title ?? "")
                        ? '${assetImagePath}saved.svg'
                        : '${assetImagePath}unsaved.svg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
