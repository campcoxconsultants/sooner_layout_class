import 'package:flutter/material.dart';

class Foo {
  Foo({required this.x, this.y = 9});

  final int x;
  final int y;
}

class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
