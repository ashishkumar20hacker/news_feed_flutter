import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/Utilities/pref.dart';
import 'package:news_feed/models/article.dart';
import 'package:news_feed/screens/webview_screen.dart';

class TopStories extends StatelessWidget {
  final Article article;

  const TopStories({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url: article.url ?? ''),)),
      child: Container(
        margin:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 2.0),
        decoration: const BoxDecoration(
            color: unselectedCd,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? "",
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(color: blue)),
                    ),
                    errorWidget: (context, url, error) =>
                        SvgPicture.asset("${assetImagePath}placeholder.svg"),
                    width: 200,
                    height: 134,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    onTap: () {
                      bool isAlreadySaved =
                          Pref.checkArticleSaved(article.title ?? "");
                      isAlreadySaved
                          ? Pref.removeFromSaved(article)
                          : Pref.addToSaved(article);
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      margin: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0, bottom: 2.0),
                      decoration: const BoxDecoration(
                          color: unselectedCd,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      padding: const EdgeInsets.all(5.0),
                      child: Obx(
                        () => SvgPicture.asset(
                          Pref.checkArticleSaved(article.title ?? "")
                              ? '${assetImagePath}saved.svg'
                              : '${assetImagePath}unsaved.svg',
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: 190,
                child: Text(
                  article.title ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                width: 190,
                child: Text(
                  article.description ?? "",
                  style: const TextStyle(
                    color: Color(0x99000000),
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                width: 190,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('Read More ->',
                      style: GoogleFonts.nunito(
                          color: blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
