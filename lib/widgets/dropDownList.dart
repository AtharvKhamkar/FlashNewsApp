import 'package:flashnewsapp/constants/colorConstants.dart';
import 'package:flutter/material.dart';

GestureDetector drawerDropDown({name, onCalled}) {
  return GestureDetector(
      child: ListTile(
        title: Text(name),
        textColor: AppColors.burgundy,
      ),
      onTap: () => onCalled());
}
