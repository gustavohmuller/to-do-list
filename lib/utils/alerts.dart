import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:to_do_list/utils/strings.dart';

import 'theme.dart';

emptyFieldsAlert(context) {
  Alert(
    context: context,
    image: Image.asset(
      "assets/images/warning.png",
      width: 100,
      color: const Color(0XFF2E3440),
    ),
    title: warningEmptyFieldsAlertTitle,
    desc: warningEmptyFieldsAlertDesc,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        width: 100,
        color: const Color(0XFF2E3440),
        radius: BorderRadius.circular(16.0),
        child: const Text(
          warningOkButton,
          style: Style.textStyle12,
        ),
      )
    ],
    style: AlertStyle(
        titleStyle: Style.textStyle7,
        descStyle: Style.textStyle10,
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
  ).show();
}

sameTitleAlert(context) {
  Alert(
    context: context,
    image: Image.asset(
      "assets/images/warning.png",
      width: 100,
      color: const Color(0XFF2E3440),
    ),
    title: warningSameTitleAlertTitle,
    desc: warningSameTitleAlertDesc,
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        width: 100,
        color: const Color(0XFF2E3440),
        radius: BorderRadius.circular(16.0),
        child: const Text(
          warningOkButton,
          style: Style.textStyle12,
        ),
      )
    ],
    style: AlertStyle(
        titleStyle: Style.textStyle7,
        descStyle: Style.textStyle10,
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
  ).show();
}
