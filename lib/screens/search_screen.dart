import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/Utilities/pref.dart';
import 'package:news_feed/screens/filter_screen.dart';
import 'package:news_feed/screens/news_list_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          'Search',
          style: GoogleFonts.nunito(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 24),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: unselectedCd),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (!Pref.checkSearchesSaved(searchController.text.trim())) {
                  Pref.addToSearches(searchController.text.trim());
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsListScreen(
                            searchQuery: searchController.text,
                            sortBy: getSortByValue(),
                            isHome: false)));
              },
              controller: searchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    "${assetImagePath}search.svg",
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    Get.to(() => const FilterScreen(), fullscreenDialog: true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "${assetImagePath}filter.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              cursorColor: Colors.black,
            ),
          ),
          Obx(
            () => Visibility(
              visible: Pref.searchesList.isNotEmpty ? true : false,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Recent Searches",
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Pref.removeFromSearches(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Clear",
                            style: GoogleFonts.nunito(
                              color: blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: [
                      if (Pref.searchesList.isNotEmpty)
                        ...List.generate(
                            Pref.searchesList.length,
                            (index) => GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsListScreen(
                                              searchQuery:
                                                  Pref.searchesList[index],
                                              sortBy: getSortByValue(),
                                              isHome: false))),
                                  child: Container(
                                    margin: const EdgeInsets.all(7.5),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                        border: Border.all(
                                            color: Colors.black45, width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 5.0),
                                      child: Text(Pref.searchesList[index],
                                          style: GoogleFonts.nunito(
                                            color: Colors.black45,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ),
                                ))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

getSortByValue() {
  if (radioButtonValue == "Popular") {
    return "popularity";
  } else if (radioButtonValue == "Relevant") {
    return "relevancy";
  } else {
    return "";
  }
}
