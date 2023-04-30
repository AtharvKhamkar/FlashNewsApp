// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class tiles extends StatelessWidget {
  final String choosed;
  tiles({
    Key? key,
    required this.choosed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(choosed),
    );
  }
}
