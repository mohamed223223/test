// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:workshop_app/languagefolder/Localization/localization_constant.dart';
import 'package:workshop_app/models/details_model.dart';

class DetailsCard extends StatelessWidget {
  int id, status, labourStatus, indexLength;
  String name, arabicName, labourName, labourNote;
  List<Labors> laboursList;
  DetailsCard(this.id, this.name, this.status, this.arabicName, this.labourName,
      this.indexLength, this.laboursList, this.labourStatus, this.labourNote,
      {super.key});

  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String statusString = "";
    String labourStatusString = "";
    String labourNoteString = "";
    Color? statusColor;

    if (labourNote.isEmpty) {
      labourNoteString = "";
    } else {
      labourNoteString = "s";
    }
    if (status == 0) {
      statusString = getTranslated(context, "status_new");
    } else if (status == 1) {
      statusString = getTranslated(context, "status_fixed");
    } else if (status == 2) {
      statusString = getTranslated(context, "status_unfixed");
    }

    if (labourStatus == 0) {
      labourStatusString = getTranslated(context, "labour_new");
      statusColor = Color.fromARGB(255, 9, 110, 13);
    } else if (labourStatus == 1) {
      labourStatusString = getTranslated(context, "labour_pending");
      statusColor = Color.fromARGB(255, 204, 156, 13);
    } else if (labourStatus == 2) {
      labourStatusString = getTranslated(context, "labour_process");
      statusColor = Color.fromARGB(255, 13, 56, 56);
    } else if (labourStatus == 3) {
      labourStatusString = getTranslated(context, "labour_waitReview");
      statusColor = Color.fromARGB(255, 13, 92, 15);
    } else if (labourStatus == 7) {
      labourStatusString = getTranslated(context, "labour_waitPaid");
      statusColor = Color.fromARGB(255, 158, 5, 43);
    } else if (labourStatus == 4) {
      labourStatusString = getTranslated(context, "labour_refused");
      statusColor = Color.fromARGB(255, 151, 6, 6);
    } else if (labourStatus == 5) {
      labourStatusString = getTranslated(context, "labour_done");
      statusColor = Colors.green;
    } else if (labourStatus == 5) {
      labourStatusString = getTranslated(context, "labour_cancel");
      statusColor = const Color.fromARGB(255, 255, 0, 0);
    }

    return Container(
      margin:
          const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 8.0, right: 8.0),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 209, 206, 206),
            blurRadius: 4,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: ExpansionTileCard(
        baseColor: Colors.white,
        elevation: 2,
        expandedColor: Colors.white,
        key: cardA,
        leading: CircleAvatar(child: Text(id.toString())),
        title: Text(
          "${getTranslated(context, "status")} : $statusString",
          style: const TextStyle(
              color: Color.fromARGB(255, 88, 88, 88),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        subtitle: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        children: [
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.error,
                  color: Colors.amber,
                  size: 25,
                ),
                title: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 16),
                ),
              ),
            ),
          ),
          laboursList.isEmpty
              ? const Text("")
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13.0,
                        vertical: 5.0,
                      ),
                      child: Text(
                        getTranslated(context, "labour") + ":",
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 5.0,
                          ),
                          child: ListView.builder(
                            itemCount: indexLength,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), //<-- SEE HERE
                                ),
                                color: Colors.white,
                                elevation: 3,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            color: statusColor!, width: 3),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundColor: Colors.blueGrey,
                                          radius: 13,
                                          child: Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                      title: Text(arabicName),
                                      subtitle: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                            TextSpan(text: labourName),
                                            labourNote.isEmpty
                                                ? const TextSpan(text: "")
                                                : TextSpan(
                                                    text: "\t" +
                                                        getTranslated(
                                                            context,
                                                            "labour_note" +
                                                                labourNote))
                                          ])),
                                      trailing: Text(
                                          "${getTranslated(context, "status")} : \n $labourStatusString",
                                          style: TextStyle(
                                              color: statusColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    )
                  ],
                ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                onPressed: () {
                  cardA.currentState?.collapse();
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.close),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 2.0),
                      ),
                      Text(getTranslated(context, "close")),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
