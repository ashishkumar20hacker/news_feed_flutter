import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          AlertDialog(
            backgroundColor: unselectedCd,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),

            contentPadding: const EdgeInsets.only(top: 20),

            //content
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset('${assetImagePath}exit_img.png',
                  height: 105, width: 105),
              //title
              Padding(
                padding: EdgeInsets.only(top: mq.height * .01),
                child: Text('Rate Us!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ),

              //for adding some space
              SizedBox(height: mq.height * .03),

              //rate us
              Semantics(
                button: true,
                child: InkWell(
                    onTap: () {
                      launchUrl(
                          Uri.parse(
                              'https://play.google.com/store/apps/details?id=$packageName'),
                          mode: LaunchMode.externalApplication);
                    },
                    child: SvgPicture.asset(
                      '${assetImagePath}stars.svg',
                      height: 40,
                      width: mq.width * .5,
                    )),
              ),
              SizedBox(height: mq.height * .03),
              Text(
                'Do you want to exit the app?',
                style: GoogleFonts.nunito(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ]),

            actionsAlignment: MainAxisAlignment.spaceEvenly,

            actionsPadding:
                EdgeInsets.only(bottom: mq.height * .04, top: mq.height * .03),

            actions: [
              //exit
              SizedBox(
                width: mq.width * .50,
                child: Semantics(
                  button: true,
                  child: ElevatedButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: Text('Exit',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: mq.height * .15,
              right: 0,
              left: 0,
              child: GestureDetector(
                  onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                  child: SvgPicture.asset('${assetImagePath}close.svg',
                      height: mq.height * .04)))
        ],
      ),
    );
  }
}
