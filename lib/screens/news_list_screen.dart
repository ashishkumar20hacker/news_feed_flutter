import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/Utilities/pref.dart';
import 'package:news_feed/models/article.dart';
import 'package:news_feed/models/news_api_model.dart';
import 'package:news_feed/screens/webview_screen.dart';

class NewsListScreen extends StatefulWidget {
  final String searchQuery;
  final String sortBy;
  final bool isHome;

  const NewsListScreen({
    super.key,
    required this.searchQuery,
    required this.sortBy,
    required this.isHome,
  });

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late RxList<Article> list = <Article>[].obs;

  void fillList() async {
    list.value = await fetchData(widget.searchQuery, widget.sortBy);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    if (widget.searchQuery == "Trending") {
      list = Pref.trendingList;
    } else {
      if (widget.isHome) {
        list = Pref.categoryWiseList;
      } else {
        fillList();
      }
    }

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset("${assetImagePath}backbt.svg")),
        ),
        centerTitle: true,
        title: Text(
          widget.searchQuery,
          style: GoogleFonts.nunito(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Visibility(
              visible: list.isEmpty ? false : true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                        list.length,
                        (index) => GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewScreen(
                                        url: list[index ].url ?? ''),
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
                                        imageUrl: list[index].urlToImage ?? "",
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
                                              list[index].title ?? "",
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
                                                    list[index])
                                                : Pref.addToSaved(list[index]);
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
                                              list[index].content ?? ""),
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
              visible: list.isEmpty ? true : false,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  padding: const EdgeInsets.all(70),
                  child: const CircularProgressIndicator(
                    color: blue,
                  ),
                ),
                // child: Text(
                //   'Something went wrong!',
                //   style: GoogleFonts.nunito(
                //       color: Colors.black,
                //       fontSize: 20,
                //       fontWeight: FontWeight.w700),
                //   textAlign: TextAlign.start,
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
