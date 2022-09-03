// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Raw data for the animation demo.

import 'package:flutter/material.dart';
import 'package:you/commons/colors.dart';

class SectionDetail {
  const SectionDetail(
      {this.title, this.subtitle, required this.imageAsset, this.url});
  final String? title;
  final String? url;
  final String? subtitle;
  final String imageAsset;
}

class Section {
  const Section({
    required this.title,
    required this.backgroundAsset,
    required this.leftColor,
    required this.rightColor,
    required this.details,
  });
  final String title;
  final String backgroundAsset;
  final Color leftColor;
  final Color rightColor;
  final List<SectionDetail> details;

  @override
  bool operator ==(Object other) {
    if (other is! Section) return false;
    final Section otherSection = other;
    return title == otherSection.title;
  }

  @override
  int get hashCode => title.hashCode;
}

SectionDetail _googleDetail(String url, String text, String sub) {
  return SectionDetail(
    imageAsset: 'assets/image/google.jpg',
    title: text,
    subtitle: sub,
    url: url,
  );
}

SectionDetail _facebookDetail(String url, String text, String sub) {
  return SectionDetail(
      imageAsset: 'assets/image/facebook.png',
      title: text,
      subtitle: sub,
      url: url);
}

SectionDetail _facebookImageDetail = SectionDetail(
  imageAsset: 'assets/image/fwatch.jpg',
);

const SectionDetail _instagramDetail = const SectionDetail(
    imageAsset: 'assets/image/instagram.jpeg',
    title: 'Personal data on instagram',
    subtitle: 'click  here  ',
    url: 'https://www.instagram.com/download/request/');

SectionDetail _instagramImageDetail = SectionDetail(
  imageAsset: 'assets/image/iwatch.jpg',
);

const SectionDetail _twitterDetail = const SectionDetail(
    imageAsset: 'assets/image/twitter.jpg',
    title: 'See the data twitter keeps',
    subtitle: 'click  here',
    url: 'https://twitter.com/settings/your_twitter_data');

const SectionDetail _twitterImageDetail = const SectionDetail(
  imageAsset: 'assets/image/twatch.jpg',
);

final List<Section> allSections = <Section>[
  Section(
    title: 'GOOGLE',
    leftColor: mediumPurple,
    rightColor: mariner,
    backgroundAsset: 'assets/image/google.jpg',
    details: <SectionDetail>[
      _googleDetail("https://adssettings.google.com/authenticated",
          "What google knows about you?", "who you are according to google"),
      _googleDetail(
          'https://accounts.google.com/signin/v2/sl/pwd?passive=1209600&osid=1&continue=https%3A%2F%2Fpasswords.google.com%2F&followup=https%3A%2F%2Fpasswords.google.com%2F&rart=ANgoxcelNBvce7ZncVKLmXw_Cu7CeJym7IOL2-YNuSHHNG02UmGEkygyw_95MWCFPzUIrtl9db9iIOhQ2iOQbiwME46B-qEJpg&authuser=0&flowName=GlifWebSignIn&flowEntry=ServiceLogin',
          "Passwords that google knows ",
          "your saved passwords"),
      _googleDetail('https://www.google.com/maps/timeline?pb',
          'Google knows your location details', ' your location history'),
      _googleDetail('https://myactivity.google.com/myactivity',
          "Google  records, what you are searching", "see your search history"),
      _googleDetail('https://myactivity.google.com/myactivity?restrict=vaa',
          "Your voice search history", "voice history"),
      _googleDetail('https://www.youtube.com/feed/history',
          "Your youtube search history", "videos you have seen"),
      _googleDetail("https://myaccount.google.com/device-activity",
          'See who are using your account', "your account login devices"),
      _googleDetail(
          'https://takeout.google.com/settings/takeout',
          "You can download your data, that google keeps",
          'Its  from every google product')
    ],
  ),
  Section(
    title: 'FACEBOOK',
    leftColor: tomato,
    rightColor: mediumPurple,
    backgroundAsset: 'assets/image/facebook.png',
    details: <SectionDetail>[
      _facebookImageDetail,
      _facebookDetail('https://www.facebook.com/your_information/',
          'Facebook knows what are you doing', 'Check  your activity'),
      _facebookDetail(
          'https://www.facebook.com/dyi/?x=AdkU_sowbKQxwuhG&referrer=yfi_settings',
          'Download  your private data ',
          'your  post, like, comment till now'),
      _facebookDetail(
          'https://www.facebook.com/settings?tab=your_facebook_information',
          'What have you done so far in facebook?',
          'check it out'),
    ],
  ),
  Section(
    title: 'INSTAGRAM',
    leftColor: mySin,
    rightColor: tomato,
    backgroundAsset: 'assets/image/instagram.jpeg',
    details: <SectionDetail>[
      _instagramImageDetail,
      _instagramDetail,
    ],
  ),
  const Section(
    title: 'TWITTER',
    leftColor: mariner,
    rightColor: tomato,
    backgroundAsset: 'assets/image/twitter.jpg',
    details: const <SectionDetail>[
      _twitterImageDetail,
      _twitterDetail,
    ],
  ),
];
