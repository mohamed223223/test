import 'package:flutter/material.dart';
import 'package:workshop_app/features/followup/services/follow_up_services.dart';
import 'package:workshop_app/features/followup/widgets/details_card.dart';
import 'package:workshop_app/languagefolder/Localization/localization_constant.dart';
import 'package:workshop_app/models/details_model.dart';

class FollowupScreen extends StatefulWidget {
  String searchQuery;
  FollowupScreen({super.key, required this.searchQuery});

  @override
  State<FollowupScreen> createState() => _FollowupScreenState();
}

class _FollowupScreenState extends State<FollowupScreen> {
  late Future<DetailsModels> detailsModel;

  @override
  void initState() {
    super.initState();
    getAllWorkshops();
  }

  void getAllWorkshops() async {
    detailsModel =
        getDetails(context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            getTranslated(context, "fault"),
            style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 241, 239, 239),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: FutureBuilder<DetailsModels>(
                    future: detailsModel,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                        default:
                          if (snapshot.hasData) {
                            var data = snapshot.data!;
                            if (snapshot.data!.result.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.file_open_outlined,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    getTranslated(
                                      context,
                                      "no_data",
                                    ),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                itemCount: data.result.length,
                                itemBuilder: (context, index) {
                                  String arabicName;
                                  String labourName;
                                  int labourStatus;
                                  String labourNote;

                                  try {
                                    labourStatus =
                                        data.result[index].labors[index].status;
                                  } catch (e) {
                                    labourStatus = 0;
                                  }

                                  try {
                                    labourNote = data
                                        .result[index].labors[index].note!
                                        .toString();
                                  } catch (e) {
                                    labourNote = "";
                                  }

                                  try {
                                    arabicName = data
                                        .result[index].labors[index].arabicName
                                        .toString();
                                    labourName = data
                                        .result[index].labors[index].laborName
                                        .toString();
                                  } catch (e) {
                                    arabicName = "";
                                    labourName = "";
                                  }
                                  return DetailsCard(
                                      data.result[index].id,
                                      data.result[index].name,
                                      data.result[index].status,
                                      arabicName,
                                      labourName,
                                      data.result[index].labors.length,
                                      data.result[index].labors,
                                      labourStatus,
                                      labourNote);

                                  /*
                                  Container(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, bottom: 5.0, right: 20.0),
                                      child: ListTile(
                                        title: Text(
                                            "${getTranslated(context, "name")} ${data.result[index].name.toString()}"),
                                        subtitle: Text(
                                            "${getTranslated(context, "code")} ${data.result[index].status.toString()}"),
                                      ));

                                      */
                                },
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                              height: 12,
                                              width: 12,
                                              child:
                                                  CircularProgressIndicator()),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            getTranslated(
                                                context, "check_connection"),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(),
                                        onPressed: () {
                                          getAllWorkshops();
                                          setState(() {});
                                        },
                                        child: Text(
                                          getTranslated(context, "try_again"),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ))
                                  ]),
                            );
                          } else {
                            return Center(
                              child: Text(
                                getTranslated(context, "no_data"),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
