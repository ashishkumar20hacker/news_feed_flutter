import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/models/categories_model.dart';
import 'package:news_feed/screens/news_list_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoriesModel> categoriesList = [
    CategoriesModel(title: "India", imagePath: '${assetImagePath}india.png'),
    CategoriesModel(
        title: "Fashion", imagePath: '${assetImagePath}fashion.png'),
    CategoriesModel(
        title: "Business", imagePath: '${assetImagePath}business.png'),
    CategoriesModel(
        title: "International",
        imagePath: '${assetImagePath}international.png'),
    CategoriesModel(title: "Sports", imagePath: '${assetImagePath}sports.png'),
    CategoriesModel(
        title: "Technology", imagePath: '${assetImagePath}technology.png'),
    CategoriesModel(
        title: "Entertainment",
        imagePath: '${assetImagePath}entertainment.png'),
    CategoriesModel(
        title: "Automobile", imagePath: '${assetImagePath}automobile.png'),
    CategoriesModel(
        title: "Education", imagePath: '${assetImagePath}education.png'),
  ];
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
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
          'Categories',
          style: GoogleFonts.nunito(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
                categoriesList.length,
                (index) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsListScreen(
                              searchQuery: categoriesList[index].title,
                              sortBy: "",
                              isHome: false,
                            ),
                          )),
                      child: Container(
                        width: mq.width,
                        height: 106,
                        // padding: const EdgeInsets.symmetric(
                        //     vertical: 10, horizontal: 50),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Stack(
                          children: [
                            Image.asset(
                              categoriesList[index].imagePath,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 25,
                              bottom: 5,
                              child: Text(
                                categoriesList[index].title,
                                style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
