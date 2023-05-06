
import 'package:bookreaderapp/Screens/FavoriteBooks.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

const mainColor = Color(0xCFF1D8D8);
const backgroundColor = Color(0xFFFAFAFA);
const blackColor = Color(0xFF121212);
const greyColor = Color(0xFF8F8E8E);
const lightGreyColor = Color(0xFFF4F4F4);
const whiteColor = Color(0xFFFFFFFF);


PreferredSizeWidget appBar(
    {
      Widget? titleWidget,
      Widget? buttonCallBack,
      Widget? favoriteButton,
      required BuildContext context}) {
  return AppBar(
    elevation: 0,
    backgroundColor: whiteColor,
    centerTitle: true,
    leading: buttonCallBack,
    title: titleWidget,
    actions: [
      favoriteButton??const SizedBox()
    ],
  );
}