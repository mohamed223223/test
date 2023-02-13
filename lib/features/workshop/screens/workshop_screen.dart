// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unnecessary_this

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workshop_app/const/app_colors.dart';
import 'package:workshop_app/const/utils.dart';
import 'package:workshop_app/features/followup/screens/followup_screen.dart';
import 'package:workshop_app/features/workshop/services/workshop_services.dart';
import 'package:workshop_app/features/workshop/widgets/find_text_area.dart';
import 'package:workshop_app/features/workshop/widgets/workshops_card.dart';
import 'package:workshop_app/languagefolder/Localization/localization_constant.dart';
import 'package:workshop_app/languagefolder/classes/language.dart';
import 'package:workshop_app/main.dart';
import 'package:workshop_app/models/result_model.dart';

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  late Future<ResultModel> resultModel;
  TextEditingController _textFieldController = TextEditingController();
  bool searchEnable = false;

  @override
  void initState() {
    super.initState();
    getAllWorkshops();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void getAllWorkshops() async {
    resultModel = getAllWorkshop(context: context);
    setState(() {});
  }

  // This Method For change Language
  void _changeLanguage(Language? language) async {
    Locale _temp = await setLocal(language!.langaugeCode);
    MyApp.setLocal(context, _temp);
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(getTranslated(context, "enter_your_code")),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              inputFormatters: <TextInputFormatter>[
                // for below version 2 use this
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                FilteringTextInputFormatter.digitsOnly
              ],
              maxLength: 8,
              decoration:
                  InputDecoration(hintText: getTranslated(context, "code")),
              onChanged: (data) {
                this.setState(() {
                  if (_textFieldController.text.isEmpty ||
                      _textFieldController.text == "") {
                    searchEnable = false;
                    _textFieldController.text.isEmpty;
                  } else {
                    searchEnable = true;
                  }
                });
              },
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (searchEnable == true) {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FollowupScreen(
                                searchQuery: _textFieldController.text.trim()),
                          ));
                    } else {
                      showSnackBar(
                          context, getTranslated(context, "enter_your_code"));
                    }
                  },
                  child: Text(getTranslated(context, "search"))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kRedColor),
                onPressed: () {
                  Navigator.of(context).pop();
                  _textFieldController.text = "";
                },
                child: Text(getTranslated(context, "close")),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String lng, lat;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            getTranslated(context, "app_name"),
            style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                  onChanged: (language) {
                    _changeLanguage(language);
                  },
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 30,
                  ),
                  items: Language.langaugeList()
                      .map<DropdownMenuItem<Language>>(
                        (lang) => DropdownMenuItem(
                          value: lang,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(lang.flag),
                              Text(
                                lang.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList()),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _displayDialog(context);
            },
            label: Text(
              getTranslated(context, "car_status"),
              style: const TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.search,
              color: Colors.white60,
            ),
            backgroundColor: Theme.of(context).primaryColor),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FindTextArea(),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: FutureBuilder<ResultModel>(
                    future: resultModel,
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
                            return ListView.builder(
                              itemCount: data.result.length,
                              itemBuilder: (context, index) {
                                String about;

                                try {
                                  lat = data.result[index].lat!.toString();
                                  lng = data.result[index].lng!.toString();
                                } catch (e) {
                                  lat = "11";
                                  lng = "22";
                                }

                                if (data.result[index].aboute
                                        .toString()
                                        .isEmpty ||
                                    data.result[index].aboute
                                        .toString()
                                        .contains("null")) {
                                  about = "";
                                } else {
                                  about = data.result[index].aboute.toString();
                                }

                                return WorkshopsCard(
                                    data.result[index].name,
                                    about,
                                    data.result[index].city,
                                    double.parse(lat),
                                    double.parse(lng));
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Center(
                                      child: Text(
                                        getTranslated(
                                            context, "check_connection"),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(),
                                        onPressed: () {
                                          setState(() {
                                            getAllWorkshops();
                                          });
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
