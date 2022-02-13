library config;

import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

const primaryColor = Color(0xff851e3e);
const backgroundColor = Color(0xff0e0920);
const secondaryBackgroundColor = Color(0xff34092C);
const accentTextColor = Color(0xffC5C2D0);
const secondaryAccentTextColor = Color(0xff935689);
const successColor = Color(0xff42B883);
const errorColor = Color(0xffb84842);

final primaryButton = TextButton.styleFrom(
    backgroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(vertical: 14.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0))));
