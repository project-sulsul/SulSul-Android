import 'package:flutter/material.dart';

Future<T?> openBottomSheet<T>(BuildContext context, Widget bottomSheet) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => bottomSheet,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
