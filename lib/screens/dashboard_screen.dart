import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/dialog_boxes/exit_dialog.dart';
import 'package:news_feed/screens/discover_screen.dart';
import 'package:news_feed/screens/home_screen.dart';
import 'package:news_feed/screens/saved_screen.dart';
import 'package:news_feed/screens/search_screen.dart';
import 'package:news_feed/widgets/bottom_nav_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  RxInt currentPage = 0.obs;
  RxString currentPageTitle = 'News Feed'.obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (_scaffoldKey.currentState?.isDrawerOpen == true) {
          _scaffoldKey.currentState?.closeDrawer();
          return;
        } else if (currentPage.value == 1 || currentPage.value == 2) {
          currentPage.value = 0;
          currentPageTitle.value = 'News Feed';
        } else {
          Get.dialog(const ExitDialog());
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(
                '${assetImagePath}menu.svg',
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset('${assetImagePath}search.svg'),
              ),
            )
          ],
          centerTitle: true,
          title: Obx(
            () => Text(
              currentPageTitle.value,
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        drawer: Drawer(
          width: mq.width,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Menu',
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => _scaffoldKey.currentState?.closeDrawer(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 5.0),
                          child:
                              SvgPicture.asset('${assetImagePath}backbt.svg'),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 20,
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 20),
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: Offset(0, 4)),
                            ]),
                            child: Image.asset(
                              '${assetImagePath}logo.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        Text(
                          'News Feed',
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
                GestureDetector(
                  onTap: () async {
                    await Share.share(
                        'Check out this Amazing App 😃\n$appName: https://play.google.com/store/apps/details?id=$packageName');
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, top: 20, left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          '${assetImagePath}share_nav.svg',
                          width: 25,
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Share',
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          '${assetImagePath}arrow_nav.svg',
                          width: 25,
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Platform.isAndroid) {
                      launchUrl(
                        Uri.parse(
                          'https://play.google.com/store/apps/details?id=$packageName',
                        ),
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          '${assetImagePath}rate_nav.svg',
                          width: 25,
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Rate Us',
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          '${assetImagePath}arrow_nav.svg',
                          width: 25,
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Obx(
          () => IndexedStack(
            index: currentPage.value,
            children: [
              HomeScreen(),
              DiscoverScreen(),
              SavedScreen(),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          elevation: 7,
          animationDuration: Duration.zero,
          indicatorColor: Colors.transparent,
          destinations: [
            BottomNavItem(
              index: 0,
              iconPath: '${assetImagePath}home.svg',
              label: 'Home',
              isSelected: currentPage,
              onTap: (index) {
                currentPage.value = index;
                currentPageTitle.value = 'News Feed';
              },
            ),
            BottomNavItem(
              index: 1,
              iconPath: '${assetImagePath}discover.svg',
              label: 'Discover',
              isSelected: currentPage,
              onTap: (index) {
                currentPage.value = index;
                currentPageTitle.value = 'Discover';
              },
            ),
            BottomNavItem(
              index: 2,
              iconPath: '${assetImagePath}savedb.svg',
              label: 'Saved',
              isSelected: currentPage,
              onTap: (index) {
                currentPage.value = index;
                currentPageTitle.value = 'Saved';
              },
            ),
          ],
          selectedIndex: currentPage.value,
        ),
      ),
    );
  }
}
