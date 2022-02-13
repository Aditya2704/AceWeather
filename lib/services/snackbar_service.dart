import 'package:flutter/material.dart';
import 'package:ace_weather/config/config.dart' as config;

class SnackbarService {
  void showBottomFlash(message, success) {
    final scaffold = config.snackbarKey.currentState;
    scaffold?.showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        content: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 5),
                    blurRadius: 10.0)
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5.0),
                height: 50.0,
                width: 7.0,
                decoration: BoxDecoration(
                    color: success
                        ? const Color(0xff09B752)
                        : const Color(0xffCE3526),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(message,
                        style: const TextStyle(color: Colors.black87))),
              )
            ],
          ),
        )));
  }
}
