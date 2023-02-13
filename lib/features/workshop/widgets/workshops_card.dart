// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:workshop_app/const/app_colors.dart';
import 'package:workshop_app/const/map_utils.dart';
import 'package:workshop_app/languagefolder/Localization/localization_constant.dart';

class WorkshopsCard extends StatelessWidget {
  String name, city, about;
  double lat, lng;
  WorkshopsCard(this.name, this.about, this.city, this.lat, this.lng);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MapUtils().openMapsSheet(context, name, lat, lng),
      child: Container(
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 214, 207, 207),
              blurRadius: 4,
              offset: Offset(0, 2), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          color: KcardRed,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.white60,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Image(image: AssetImage("assets/images/workshop.png")),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      // We will add this line to control the width of the text , in case it was Long Text.
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        about,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                        // We will add this line in case Text have over Flowing.
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  city,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    width: 70.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0)),
                    // This Line for controll the place of the child inside Container
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated(context, "location"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ))

                // or we can use also SizedBox.shrink()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
