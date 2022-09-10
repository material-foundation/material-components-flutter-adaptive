// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef NavigationTypeResolver = NavigationType Function(BuildContext context);

typedef AppBarBuilder = PreferredSizeWidget? Function(
    BuildContext context, NavigationType navigationType);

// The navigation mechanism to configure the [Scaffold] with.
enum NavigationType {
  // Used to configure a [Scaffold] with a [BottomNavigationBar].
  bottom,

  // Used to configure a [Scaffold] with a [NavigationRail].
  rail,

  // Used to configure a [Scaffold] with a modal [Drawer].
  drawer,

  // Used to configure a [Scaffold] with an always open [Drawer].
  permanentDrawer,
}

/// Used to configure items or destinations in the various navigation
/// mechanism. For [BottomNavigationBar], see [BottomNavigationBarItem]. For
/// [NavigationRail], see [NavigationRailDestination]. For [Drawer], see
/// [ListTile].
class AdaptiveScaffoldDestination {
  final String title;
  final IconData icon;
  final String? path;

  const AdaptiveScaffoldDestination({
    required this.title,
    required this.icon,
    this.path,
  });
}

/// A widget that adapts to the current display size, displaying a [Drawer],
/// [NavigationRail], or [BottomNavigationBar]. Navigation destinations are
/// defined in the [destinations] parameter.
class AdaptiveNavigationScaffold extends StatefulWidget {
  const AdaptiveNavigationScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    required this.selectedIndex,
    required this.destinations,
    this.onDestinationSelected,
    this.navigationTypeResolver,
    this.appBarBuilder,
    this.drawerHeader,
    this.navigationRailTrailing,
    this.permanentDrawerTrailing,
    this.fabInRail = true,
    this.fabInPermanentDrawer = true,
    this.includeBaseDestinationsInMenu = true,
    this.bottomNavigationOverflow = 5,
    this.railDestinationsOverflow = 7,
  }) : super(key: key);

  /// See [Scaffold.appBar].
  final PreferredSizeWidget? appBar;

  /// See [Scaffold.body].
  final Widget body;

  /// See [Scaffold.floatingActionButton].
  final Widget? floatingActionButton;

  /// See [Scaffold.floatingActionButtonLocation].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// See [Scaffold.floatingActionButtonAnimator].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons].
  final List<Widget>? persistentFooterButtons;

  /// See [Scaffold.endDrawer].
  final Widget? endDrawer;

  /// See [Scaffold.drawerScrimColor].
  final Color? drawerScrimColor;

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;

  /// See [Scaffold.bottomSheet].
  final Widget? bottomSheet;

  /// See [Scaffold.resizeToAvoidBottomInset].
  final bool? resizeToAvoidBottomInset;

  /// See [Scaffold.primary].
  final bool primary;

  /// See [Scaffold.drawerDragStartBehavior].
  final DragStartBehavior drawerDragStartBehavior;

  /// See [Scaffold.extendBody].
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar].
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.drawerEdgeDragWidth].
  final double? drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture].
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture].
  final bool endDrawerEnableOpenDragGesture;

  /// The index into [destinations] for the current selected
  /// [AdaptiveScaffoldDestination].
  final int selectedIndex;

  /// Defines the appearance of the items that are arrayed within the
  /// navigation.
  ///
  /// The value must be a list of two or more [AdaptiveScaffoldDestination]
  /// values.
  final List<AdaptiveScaffoldDestination> destinations;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the adaptive scaffold needs to keep
  /// track of the index of the selected [AdaptiveScaffoldDestination] and call
  /// `setState` to rebuild the adaptive scaffold with the new [selectedIndex].
  final ValueChanged<int>? onDestinationSelected;

  /// Determines the navigation type that the scaffold uses.
  final NavigationTypeResolver? navigationTypeResolver;

  /// Builder for appBar according to navigation type of the scaffold.
  ///
  /// If null, [appBar] is used for all navigation types.
  final AppBarBuilder? appBarBuilder;

  /// The leading item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no header.
  final Widget? drawerHeader;

  /// The trailing widget in the NavigationRail
  ///
  /// If null, then there is no trailing
  final Widget? navigationRailTrailing;

  /// The trailing widget in the permanent drawer
  ///
  /// If null, then there is no trailing
  final Widget? permanentDrawerTrailing;

  /// Whether the [floatingActionButton] is inside or the rail or in the regular
  /// spot.
  ///
  /// If true, then [floatingActionButtonLocation] and
  /// [floatingActionButtonAnimation] are ignored.
  final bool fabInRail;

  /// Whether the [floatingActionButton] is inside the permanent drawer or in the regular
  /// spot.
  ///
  /// If true, then [floatingActionButtonLocation] and
  /// [floatingActionButtonAnimation] are ignored.
  final bool fabInPermanentDrawer;

  /// Weather the overflow menu defaults to include overflow destinations and
  /// the overflow destinations.
  final bool includeBaseDestinationsInMenu;

  /// Maximum number of items to display in [BottomNavigationBar].
  ///
  /// Defaults to 5.
  final int bottomNavigationOverflow;

  /// Maximum number of items to display in [NavigationRail].
  ///
  /// Defaults to 7.
  final int railDestinationsOverflow;

  static AdaptiveNavigationScaffoldState of(BuildContext context) {
    final state =
        context.findAncestorStateOfType<AdaptiveNavigationScaffoldState>();
    assert(state != null,
        'No AdaptiveNavigationScaffoldState found in the context');
    return state!;
  }

  @override
  State<AdaptiveNavigationScaffold> createState() =>
      AdaptiveNavigationScaffoldState();
}

class AdaptiveNavigationScaffoldState
    extends State<AdaptiveNavigationScaffold> {
  NavigationType _defaultNavigationTypeResolver(BuildContext context) {
    if (_isLargeScreen(context)) {
      return NavigationType.permanentDrawer;
    } else if (_isMediumScreen(context)) {
      return NavigationType.rail;
    } else {
      return NavigationType.bottom;
    }
  }

  PreferredSizeWidget? appBar;

  Drawer _defaultDrawer(List<AdaptiveScaffoldDestination> destinations) {
    return Drawer(
      child: ListView(
        children: [
          if (widget.drawerHeader != null) widget.drawerHeader!,
          for (int i = 0; i < destinations.length; i++)
            ListTile(
              leading: Icon(destinations[i].icon),
              title: Text(destinations[i].title),
              onTap: () {
                widget.onDestinationSelected?.call(i);
              },
            )
        ],
      ),
    );
  }

  Widget _buildBottomNavigationScaffold() {
    final bottomDestinations = widget.destinations.sublist(
      0,
      math.min(widget.destinations.length, widget.bottomNavigationOverflow),
    );
    final drawerDestinations =
        widget.destinations.length > widget.bottomNavigationOverflow
            ? widget.destinations.sublist(widget.includeBaseDestinationsInMenu
                ? 0
                : widget.bottomNavigationOverflow)
            : <AdaptiveScaffoldDestination>[];
    return Scaffold(
      key: widget.key,
      body: widget.body,
      appBar: appBar,
      drawer: Navigator.of(context).canPop() || drawerDestinations.isEmpty
          ? null
          : _defaultDrawer(drawerDestinations),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (final destination in bottomDestinations)
            BottomNavigationBarItem(
              icon: Icon(destination.icon),
              label: destination.title,
            ),
        ],
        currentIndex: widget.selectedIndex,
        onTap: widget.onDestinationSelected ?? (_) {},
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
    );
  }

  Widget _buildNavigationRailScaffold() {
    final railDestinations = widget.destinations.sublist(
      0,
      math.min(widget.destinations.length, widget.railDestinationsOverflow),
    );
    final drawerDestinations =
        widget.destinations.length > widget.railDestinationsOverflow
            ? widget.destinations.sublist(widget.includeBaseDestinationsInMenu
                ? 0
                : widget.railDestinationsOverflow)
            : <AdaptiveScaffoldDestination>[];
    return Scaffold(
      drawer: Navigator.of(context).canPop() || drawerDestinations.isEmpty
          ? null
          : _defaultDrawer(drawerDestinations),
      body: Builder(builder: (context) {
        return Row(
          children: [
            NavigationRail(
              leading: Navigator.of(context).canPop() ||
                      widget.fabInRail ||
                      drawerDestinations.isNotEmpty
                  ? Column(
                      children: [
                        if (drawerDestinations.isNotEmpty ||
                            Navigator.of(context).canPop())
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Navigator.of(context).canPop()
                                ? const BackButton()
                                : IconButton(
                                    onPressed: () =>
                                        Scaffold.of(context).openDrawer(),
                                    icon: const Icon(Icons.menu)),
                          ),
                        if (widget.fabInRail &&
                            widget.floatingActionButton != null)
                          widget.floatingActionButton!,
                      ],
                    )
                  : null,
              destinations: [
                for (final destination in railDestinations)
                  NavigationRailDestination(
                    icon: Icon(destination.icon),
                    label: Text(destination.title),
                  ),
              ],
              trailing: widget.navigationRailTrailing,
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected ?? (_) {},
            ),
            Expanded(
              child: Scaffold(
                key: widget.key,
                appBar: appBar,
                floatingActionButton:
                    widget.fabInRail ? null : widget.floatingActionButton,
                floatingActionButtonLocation:
                    widget.floatingActionButtonLocation,
                floatingActionButtonAnimator:
                    widget.floatingActionButtonAnimator,
                body: widget.body,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildNavigationDrawerScaffold() {
    return Scaffold(
      key: widget.key,
      body: widget.body,
      appBar: appBar,
      drawer: Drawer(
        child: Column(
          children: [
            if (widget.drawerHeader != null) widget.drawerHeader!,
            for (final destination in widget.destinations)
              ListTile(
                leading: Icon(destination.icon),
                title: Text(destination.title),
                selected: widget.destinations.indexOf(destination) ==
                    widget.selectedIndex,
                onTap: () => _destinationTapped(destination),
              ),
          ],
        ),
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      endDrawer: widget.endDrawer,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: true,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
    );
  }

  Widget _buildPermanentDrawerScaffold() {
    return Row(
      children: [
        Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.drawerHeader != null) widget.drawerHeader!,
              if (widget.fabInPermanentDrawer &&
                  widget.floatingActionButton != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.floatingActionButton,
                ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final destination in widget.destinations)
                        ListTile(
                          leading: Icon(destination.icon),
                          title: Text(destination.title),
                          selected: widget.destinations.indexOf(destination) ==
                              widget.selectedIndex,
                          onTap: () => _destinationTapped(destination),
                        ),
                    ],
                  ),
                ),
              ),
              if (widget.permanentDrawerTrailing != null)
                widget.permanentDrawerTrailing!,
            ],
          ),
        ),
        Expanded(
          child: Scaffold(
            key: widget.key,
            appBar: appBar,
            body: widget.body,
            floatingActionButton: widget.fabInPermanentDrawer
                ? null
                : widget.floatingActionButton,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
            persistentFooterButtons: widget.persistentFooterButtons,
            endDrawer: widget.endDrawer,
            bottomSheet: widget.bottomSheet,
            backgroundColor: widget.backgroundColor,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
            primary: true,
            drawerDragStartBehavior: widget.drawerDragStartBehavior,
            extendBody: widget.extendBody,
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
            drawerScrimColor: widget.drawerScrimColor,
            drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
            endDrawerEnableOpenDragGesture:
                widget.endDrawerEnableOpenDragGesture,
          ),
        ),
      ],
    );
  }

  late NavigationType navigationType;

  @override
  Widget build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver =
        widget.navigationTypeResolver ?? _defaultNavigationTypeResolver;
    navigationType = navigationTypeResolver(context);
    appBar = widget.appBarBuilder != null
        ? widget.appBarBuilder!(context, navigationType)
        : widget.appBar;
    switch (navigationType) {
      case NavigationType.bottom:
        return _buildBottomNavigationScaffold();
      case NavigationType.rail:
        return _buildNavigationRailScaffold();
      case NavigationType.drawer:
        return _buildNavigationDrawerScaffold();
      case NavigationType.permanentDrawer:
        return _buildPermanentDrawerScaffold();
    }
  }

  void _destinationTapped(AdaptiveScaffoldDestination destination) {
    final index = widget.destinations.indexOf(destination);
    if (index != widget.selectedIndex) {
      widget.onDestinationSelected?.call(index);
    }
  }
}

bool _isLargeScreen(BuildContext context) =>
    getWindowType(context) >= AdaptiveWindowType.large;

bool _isMediumScreen(BuildContext context) =>
    getWindowType(context) == AdaptiveWindowType.medium;
