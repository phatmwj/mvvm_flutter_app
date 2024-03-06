import 'package:flutter/material.dart';

class Skelton extends StatefulWidget {
  const Skelton({
    Key? key,
    this.height,
    this.width,
  }) : super(key:key);

  final double? height, width;

  @override
  State<Skelton> createState() => _SkeltonState();
}

class _SkeltonState extends State<Skelton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
    );
  }
}
