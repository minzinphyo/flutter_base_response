import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget listItemSalonWidget(
    {bool showFavourite = false, context,}) {
  return InkWell(
    onTap: () {
    },
    child: Container(
        margin: EdgeInsets.only(top: 4),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(
              Radius.circular(8.0),
            )),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //     height: MediaQuery.of(context).size.width * 0.2,
                //     width: double.infinity,
                //     child: ClipRRect(
                //         borderRadius: BorderRadius.only(
                //           topLeft: const Radius.circular(8.0),
                //           topRight: const Radius.circular(8.0),
                //         ),
                //         child: showImage(salonOb.image))),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Text(
                    "Hello",
                    style: GoogleFonts.openSans(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
                  child: Text(
                    "Address",
                    //salonOb.address,
                    style: GoogleFonts.openSans(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0),
                  ),
                )
              ],
            ),
            showFavourite
                ? Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      )),
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                  )),
            )
                : Container()
          ],
        )),
  );
}
