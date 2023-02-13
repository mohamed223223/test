import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workshop_app/const/error_handling.dart';
import 'package:workshop_app/const/size_config.dart';
import 'package:workshop_app/const/utils.dart';
import 'package:workshop_app/languagefolder/Localization/localization_constant.dart';
import 'package:workshop_app/models/details_model.dart';

Future<DetailsModels> getDetails(
    {required BuildContext context, required String searchQuery}) async {
  http.Response response;

  DetailsModels? detailsModels;
  try {
    response = await http.get(Uri.parse(
        '$uri/api/services/app/MobileView/GetAllTroubles?Code=$searchQuery'));

    httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        detailsModels = DetailsModels.fromJson(jsonDecode(response.body));
      },
    );
  } catch (e) {
    showSnackBar(context, getTranslated(context, "check_connection"));
  }

  return detailsModels!;
}
