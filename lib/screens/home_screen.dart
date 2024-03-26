import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/Utilities/pref.dart';
import 'package:news_feed/models/article.dart';
import 'package:news_feed/models/categories_model.dart';
import 'package:news_feed/models/news_api_model.dart';
import 'package:news_feed/screens/categories_screen.dart';
import 'package:news_feed/screens/news_list_screen.dart';
import 'package:news_feed/screens/webview_screen.dart';
import 'package:news_feed/widgets/categories_tab.dart';
import 'package:news_feed/widgets/news_compact.dart';
import 'package:news_feed/widgets/top_stories.dart';

import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    runViewPager();
  }

  List<CategoriesModel> categoriesList = [
    CategoriesModel(title: "India", imagePath: '${assetImagePath}india.png'),
    CategoriesModel(
        title: "Fashion", imagePath: '${assetImagePath}fashion.png'),
    CategoriesModel(
        title: "Business", imagePath: '${assetImagePath}business.png'),
    CategoriesModel(
        title: "Politics", imagePath: '${assetImagePath}international.png'),
  ];

  PageController pageController = PageController();
  RxInt currentPage = 0.obs;
  RxInt selectedIndex = 0.obs;

  Future<void> runViewPager() async {
    Timer.periodic(const Duration(seconds: 3), (t) {
      if (pageController.page?.toInt() == 2) {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      }
    });
  }

  void fillList(RxList<Article> list, String query) async {
    list.value = await fetchData(query, "");
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    if (Pref.generalList.isEmpty) {
      fillList(Pref.generalList, "General");
    }
    if (Pref.topStoriesList.isEmpty) {
      fillList(Pref.topStoriesList, "Top Stories");
    }
    if (Pref.trendingList.isEmpty) {
      fillList(Pref.trendingList, "Trending");
    }
    if (Pref.categoryWiseList.isEmpty) {
      fillList(Pref.categoryWiseList, "India");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Pref.generalList.isNotEmpty)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 190,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: math.min(Pref.generalList.length, 3),
                        onPageChanged: (index) {
                          currentPage.value = index;
                        },
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url: Pref.generalList[index].url ?? ''),)),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          Pref.generalList[index].urlToImage ??
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
                                        '${assetImagePath}placeholder.svg',
                                      ),
                                      width: mq.width,
                                      height: 190,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  bottom: 16,
                                  child: Text(
                                    Pref.generalList[index].title ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        math.min(Pref.generalList.length, 3),
                        (index) => buildDot(index: index),
                      ),
                    ),
                  ),
                ],
              )
            else
              Container(
                height: 70,
                width: 70,
                padding: const EdgeInsets.all(70),
                child: const CircularProgressIndicator(
                  color: blue,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14, left: 15, right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriesScreen())),
                    child: SvgPicture.asset(
                      '${assetImagePath}arrow.svg',
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                ...List.generate(
                    4,
                    (index) => CategoriesTab(
                        index: index,
                        imagePath: categoriesList[index].imagePath,
                        label: categoriesList[index].title,
                        isSelected: selectedIndex,
                        width: mq.width * 0.25,
                        onTap: (i) {
                          selectedIndex.value = i;
                          Pref.categoryWiseList.clear();
                          fillList(Pref.categoryWiseList,
                              categoriesList[selectedIndex.value].title);
                        })),
              ],
            ),
            if (Pref.categoryWiseList.isNotEmpty)
              Column(children: [
                ...List.generate(
                  math.min(Pref.categoryWiseList.length, 3),
                  (index) {
                    return NewsCompact(
                      article: Pref.categoryWiseList[index],
                    );
                  },
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsListScreen(
                          searchQuery:
                              categoriesList[selectedIndex.value].title,
                          sortBy: "",
                          isHome: true,
                        ),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'View More',
                      style: GoogleFonts.nunito(
                        color: blue,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ])
            else
              Container(
                height: 200,
                width: 200,
                padding: const EdgeInsets.all(70),
                child: const CircularProgressIndicator(
                  color: blue,
                ),
              ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 14, left: 15, right: 15),
                  child: Text(
                    'Top Stories',
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                ),
                const Spacer()
              ],
            ),
            if (Pref.topStoriesList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                          math.min(Pref.generalList.length, 20),
                          (index) =>
                              TopStories(article: Pref.topStoriesList[index])),
                    ],
                  ),
                ),
              )
            else
              Container(
                height: 70,
                width: 70,
                padding: const EdgeInsets.all(70),
                child: const CircularProgressIndicator(
                  color: blue,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14, left: 15, right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Trending',
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    '${assetImagePath}arrow.svg',
                    width: 25,
                    height: 25,
                  )
                ],
              ),
            ),
            if (Pref.trendingList.isNotEmpty)
              Column(
                children: [
                  ...List.generate(
                      math.min(Pref.generalList.length, 3),
                      (index) => NewsCompact(
                            article: Pref.trendingList[index],
                          )),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewsListScreen(
                            searchQuery: "Trending",
                            sortBy: "",
                            isHome: false,
                          ),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: Text(
                        'View More',
                        style: GoogleFonts.nunito(
                          color: blue,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            else
              Container(
                height: 70,
                width: 70,
                padding: const EdgeInsets.all(70),
                child: const CircularProgressIndicator(
                  color: blue,
                ),
              ),
          ],
        ),
      )),
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: currentPage.value == index ? 20 : 8,
      decoration: BoxDecoration(
        color: currentPage.value == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
