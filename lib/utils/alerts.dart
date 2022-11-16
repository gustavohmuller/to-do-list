import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:to_do_list/utils/strings.dart';


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
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
    style: AlertStyle(
        titleStyle: const TextStyle(
          color: Color(0XFF2E3440),
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        descStyle: const TextStyle(
          color: Color(0XFF2E3440),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
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
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
    style: AlertStyle(
        titleStyle: const TextStyle(
          color: Color(0XFF2E3440),
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        descStyle: const TextStyle(
          color: Color(0XFF2E3440),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
  ).show();
}