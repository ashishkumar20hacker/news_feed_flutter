import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/Utilities/pref.dart';
import 'package:news_feed/screens/webview_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: white,
      body: Obx(
        () => Stack(
          children: [
            Visibility(
              visible: Pref.generalList.isEmpty ? false : true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                        Pref.generalList.length,
                        (index) => GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewScreen(
                                        url: Pref.generalList[index].url ?? ''),
                                  )),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 8.0,
                                    bottom: 2.0),
                                decoration: const BoxDecoration(
                                    color: unselectedCd,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: CachedNetworkImage(
                                        imageUrl: Pref.generalList[index]
                                                .urlToImage ??
                                            "",
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SizedBox(
                                              width: 70,
                                              height: 70,
                                              child: CircularProgressIndicator(
                                                  color: blue)),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            SvgPicture.asset(
                                                "${assetImagePath}placeholder.svg"),
                                        width: mq.width,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text(
                                              Pref.generalList[index].title ??
                                                  "",
                                              style: GoogleFonts.nunito(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            bool isAlreadySaved =
                                                Pref.checkArticleSaved(Pref
                                                        .generalList[index]
                                                        .title ??
                                                    "");
                                            isAlreadySaved
                                                ? Pref.removeFromSaved(
                                                    Pref.generalList[index])
                                                : Pref.addToSaved(
                                                    Pref.generalList[index]);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: SvgPicture.asset(
                                              Pref.checkArticleSaved(Pref
                                                          .generalList[index]
                                                          .title ??
                                                      "")
                                                  ? '${assetImagePath}saved.svg'
                                                  : '${assetImagePath}unsaved.svg',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 8.0),
                                      child: SizedBox(
                                        width: mq.width,
                                        child: Text(
                                          replaceTextFromPosition(
                                              Pref.generalList[index].content ??
                                                  ""),
                                          style: GoogleFonts.nunito(
                                              color: Color(0x99000000),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: SizedBox(
                                        width: mq.width,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('Read More ->',
                                              style: GoogleFonts.nunito(
                                                color: blue,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                decoration:
                                                    TextDecoration.underline,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: Pref.generalList.isEmpty ? true : false,
              child: Center(
                child: Text(
                  'Something went wrong!',
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
