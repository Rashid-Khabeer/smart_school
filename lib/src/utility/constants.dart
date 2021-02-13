import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kDomainUrl = 'https://lezanprivate.com';
const kApiUrl = kDomainUrl + '/api';
const kPrivacyPolicy = '/page/privacy-policy';

const kMainColor = Color(0xff424242);

const kSimpleStyle = TextStyle(
  color: kMainColor,
);

const kBlueStyle = TextStyle(
  color: Colors.blue,
);

const k16BoldStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);
const k14Style = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);
const k14SimpleStyle = TextStyle(
  fontSize: 14.0,
);

const kInputDecoration = InputDecoration(
  labelText: '',
  labelStyle: TextStyle(fontSize: 14.0),
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
  ),
);
