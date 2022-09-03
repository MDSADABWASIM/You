// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Based on https://material.uplabs.com/posts/google-sstand-navigation-pattern
// See also: https://material-motion.github.io/material-motion/documentation/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:you/commons/colors.dart';
import 'package:you/commons/constants.dart';
import 'package:you/ui/detail.dart';
import 'package:you/widgets/all_sections_layout.dart';
import 'package:you/widgets/app_bar_delegate.dart';
import 'package:you/widgets/section_card.dart';
import 'package:you/widgets/snapping_scroll_physics.dart';
import 'package:you/widgets/statusbar_padding_sliver.dart';
import '../widgets/sections.dart';
import '../widgets/section_detail.dart';

class AnimationDemoHome extends StatefulWidget {
  const AnimationDemoHome({Key? key}) : super(key: key);

  static const String routeName = '/animation';

  @override
  _AnimationDemoHomeState createState() => _AnimationDemoHomeState();
}

class _AnimationDemoHomeState extends State<AnimationDemoHome> {
  final _divider = Divider(height: 3.0);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final PageController _headingPageController = PageController();
  final PageController _detailsPageController = PageController();
  ScrollPhysics _headingScrollPhysics = const NeverScrollableScrollPhysics();
  ValueNotifier<double> selectedIndex = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: kAppBackgroundColor,
        drawer: _drawer(),
        body: Builder(
          // Insert an element so that _buildBody can find the PrimaryScrollController.
          builder: _buildBody,
        ),
      ),
    );
  }

  _sharer() {
    Share.share(" YOU - What internet knows about you\n" +
        "https://play.google.com/store/apps/details?id=indiancoder.you");
  }

  Drawer _drawer() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Container(
            width: 400.0,
            height: 170.0,
            child: Image.asset(
              'assets/image/logo.jpg',
              fit: BoxFit.cover,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          _divider,
          ListTile(
            leading: Icon(Icons.settings_input_antenna, color: Colors.white),
            title: Text(
              "Your   Location",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            onTap: () {
              setState(() {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => Detail(
                          imagetype: "lost",
                          url: 'https://www.google.com/android/find?u=0',
                        )));
              });
            },
          ),
          _divider,
          ListTile(
            leading: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
            title: Text(
              "Live   Tracking",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            onTap: () {
              setState(() {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => Detail(
                          imagetype: "click",
                          url: 'https://clickclickclick.click',
                        )));
              });
            },
          ),
          _divider,
          Expanded(
            child: ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.white,
              ),
              title: Text(
                "Share  App",
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              onTap: () => _sharer(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 55.0),
          )
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double statusBarHeight = mediaQueryData.padding.top;
    final double screenHeight = mediaQueryData.size.height;
    final double appBarMaxHeight = screenHeight - statusBarHeight;
    final double appBarMidScrollOffset =
        statusBarHeight + appBarMaxHeight - kAppBarMidHeight;

    if (_scrollController.offset >= appBarMidScrollOffset) {
      _scrollController.animateTo(0.0,
          curve: kScrollCurve, duration: kScrollDuration);
          return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  void _handleBackButton(double midScrollOffset) {
    // if (_scrollController.offset >= midScrollOffset)
    //   _scrollController.animateTo(0.0, curve: _kScrollCurve, duration: _kScrollDuration);
    // else
    _scaffoldKey.currentState!.openDrawer();
  }

  // Only enable paging for the heading when the user has scrolled to midScrollOffset.
  // Paging is enabled/disabled by setting the heading's PageView scroll physics.
  bool _handleScrollNotification(
      ScrollNotification notification, double midScrollOffset) {
    if (notification.depth == 0 && notification is ScrollUpdateNotification) {
      final ScrollPhysics physics =
          _scrollController.position.pixels >= midScrollOffset
              ? const PageScrollPhysics()
              : const NeverScrollableScrollPhysics();
      if (physics != _headingScrollPhysics) {
        setState(() {
          _headingScrollPhysics = physics;
        });
      }
    }
    return false;
  }

  void _maybeScroll(double midScrollOffset, int pageIndex, double xOffset) {
    if (_scrollController.offset < midScrollOffset) {
      // Scroll the overall list to the point where only one section card shows.
      // At the same time scroll the PageViews to the page at pageIndex.
      _headingPageController.animateToPage(pageIndex,
          curve: kScrollCurve, duration: kScrollDuration);
      _scrollController.animateTo(midScrollOffset,
          curve: kScrollCurve, duration: kScrollDuration);
    } else {
      // One one section card is showing: scroll one page forward or back.
      final double centerX =
          _headingPageController.position.viewportDimension / 2.0;
      final int pageindex = xOffset > centerX ? pageIndex + 1 : pageIndex - 1;
      _headingPageController.animateToPage(pageindex,
          curve: kScrollCurve, duration: kScrollDuration);
    }
  }

  bool _handlePageNotification(ScrollNotification notification,
      PageController leader, PageController follower) {
    if (notification.depth == 0 && notification is ScrollUpdateNotification) {
      selectedIndex.value = leader.page!;
      if (follower.page != leader.page)
        follower.position
            .jumpTo(leader.position.pixels); // ignore: deprecated_member_use
    }
    return false;
  }

  Iterable<Widget> _detailItemsFor(Section section) {
    final Iterable<Widget> detailItems =
        section.details.map((SectionDetail detail) {
      return SectionDetailView(detail: detail);
    });
    return ListTile.divideTiles(context: context, tiles: detailItems);
  }

  List<Widget> _allHeadingItems(double maxHeight, double midScrollOffset) {
    final List<Widget> sectionCards = <Widget>[];
    for (int index = 0; index < allSections.length; index++) {
      sectionCards.add(LayoutId(
        id: 'card$index',
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: SectionCard(section: allSections[index]),
            onTapUp: (TapUpDetails details) {
              final double xOffset = details.globalPosition.dx;
              setState(() {
                _maybeScroll(midScrollOffset, index, xOffset);
              });
            }),
      ));
    }

    final List<Widget> headings = <Widget>[];
    for (int index = 0; index < allSections.length; index++) {
      headings.add(Container(
        color: kAppBackgroundColor,
        child: ClipRect(
          child: AllSectionsView(
            sectionIndex: index,
            sections: allSections,
            selectedIndex: selectedIndex,
            minHeight: kAppBarMinHeight,
            midHeight: kAppBarMidHeight,
            maxHeight: maxHeight,
            sectionCards: sectionCards,
          ),
        ),
      ));
    }
    return headings;
  }

  Widget _buildBody(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double statusBarHeight = mediaQueryData.padding.top;
    final double screenHeight = mediaQueryData.size.height;
    final double appBarMaxHeight = screenHeight - statusBarHeight;

    // The scroll offset that reveals the appBarMidHeight appbar.
    final double appBarMidScrollOffset =
        statusBarHeight + appBarMaxHeight - kAppBarMidHeight;

    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              return _handleScrollNotification(
                  notification, appBarMidScrollOffset);
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics:
                  SnappingScrollPhysics(midScrollOffset: appBarMidScrollOffset),
              slivers: <Widget>[
                // Start out below the status bar, gradually move to the top of the screen.
                StatusBarPaddingSliver(
                  maxHeight: statusBarHeight,
                  scrollFactor: 7.0,
                ),
                // Section Headings
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: kAppBarMinHeight,
                    maxHeight: appBarMaxHeight,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        return _handlePageNotification(notification,
                            _headingPageController, _detailsPageController);
                      },
                      child: PageView(
                        physics: _headingScrollPhysics,
                        controller: _headingPageController,
                        children: _allHeadingItems(
                            appBarMaxHeight, appBarMidScrollOffset),
                      ),
                    ),
                  ),
                ),
                // Details
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 610.0,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        return _handlePageNotification(notification,
                            _detailsPageController, _headingPageController);
                      },
                      child: PageView(
                        controller: _detailsPageController,
                        children: allSections.map((Section section) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: _detailItemsFor(section).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: statusBarHeight,
            left: 0.0,
            child: IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: SafeArea(
                top: false,
                bottom: false,
                child: IconButton(
                    icon: const Icon(Icons.menu),
                    tooltip: 'Menu',
                    onPressed: () {
                      _handleBackButton(appBarMidScrollOffset);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
