import 'package:flutter/material.dart';

const kAppBarColor = Colors.white; 
var kBackgroundColor = Colors.grey[100]; 
const kPrimaryContainerColor = Color(0xff304FFE);
const kTextColor = Color(0xff474747); 
// const kBackgroundColor = Color(0xffF9F9FA); 

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 22,  color: kTextColor),
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kTextColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kTextColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);