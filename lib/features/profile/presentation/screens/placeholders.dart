import 'package:flutter/material.dart';





Widget _placeholder(String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text('$title Screen (Placeholder)')),
  );
}
