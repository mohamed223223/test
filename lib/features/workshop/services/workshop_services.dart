import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workshop_app/const/error_handling.dart';
import 'package:workshop_app/const/size_config.dart';
import 'package:workshop_app/const/utils.dart';
import 'package:workshop_app/languagefolder/Localization/localization_constant.dart';
import 'package:workshop_app/models/result_model.dart';

Future<ResultModel> getAllWorkshop({required BuildContext context}) async {
  http.Response response;

  ResultModel? resultModel;
  try {
    response = await http
        .get(Uri.parse('$uri/api/services/app/MobileView/GetAllWorkshop'));

    httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        resultModel = ResultModel.fromJson(jsonDecode(response.body));
      },
    );
  } catch (e) {
    showSnackBar(context, getTranslated(context, "check_connection"));
  }

  return resultModel!;
}
