import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/Utilities/pref.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  RxString selectedRadio =
      radioButtonValue.isNotEmpty ? radioButtonValue.obs : "Recommended".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 10),
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset("${assetImagePath}backbt.svg")),
        ),
        centerTitle: true,
        title: Text(
          'Filters',
          style: GoogleFonts.nunito(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: unselectedCd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sort By',
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Divider(
                      color: blue,
                      height: 1,
                    ),
                  ),
                  ...['Recommended', 'Newest', 'Relevant', 'Popular']
                      .map((e) => Obx(() => RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              e,
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            value: e,
                            groupValue: selectedRadio.value,
                            onChanged: (e) {
                              selectedRadio.value = e!;
                            },
                            activeColor: blue,
                          )))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: unselectedCd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Divider(
                      color: blue,
                      height: 1,
                    ),
                  ),
                  ...Pref.categoryFilterList.keys.map((e) => Obx(
                        () => CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: blue,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(e),
                          value: Pref.categoryFilterList[e],
                          onChanged: (bool? value) {
                            Pref.categoryFilterList[e] = value!;
                          },
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 15),
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      selectedRadio.value = 'Recommended';
                      Pref.categoryFilterList["India"] = false;
                      Pref.categoryFilterList["Fashion"] = false;
                      Pref.categoryFilterList["Business"] = false;
                      Pref.categoryFilterList["Politics"] = false;
                      Pref.categoryFilterList["International"] = false;
                      Pref.categoryFilterList["Travel"] = false;
                      Pref.categoryFilterList["Education"] = false;
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: blue, width: 2.0))),
                    child: Text('Reset',
                        style: GoogleFonts.nunito(
                          color: blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      radioButtonValue = selectedRadio.value;
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: Text('Apply',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
