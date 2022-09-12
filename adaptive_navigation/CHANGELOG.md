## 0.0.8 - Sep 12, 2022

- Add path property to `AdaptiveScaffoldDestination` for simpler usage with routing.
- Add `AdaptiveNavigationScaffold.of(context)` method to provide its state to descendants.
- Add `appBarBuilder` to build different AppBars depending on `NavigationType`.
- Add `navigationRailTrailing` and `permanentDrawerFooter`.
- `FAB` now can be inside `permanentDrawer` and is controlled by `fabInPermanentDrawer` property.
- Add `railDestinationsOverflow` property.
- Menu/Back button is now moved inside `NavigationRail` from the `AppBar` to be perfectly aligned with `NavigationRailDestinations`.
- Make `floatingActionButton` type `Widget` not `FloatingActionButton` as it is in the `Scaffold`.
- Add `AdaptiveFloatingActionButton`. This widget should be used to have and expanded FAB inside permanent drawer.
- Update examples.
- Update dependencies.

## 0.0.7 - May 23, 2022

- Tweaked pubspec description.
- Polished README.
- Updated dependencies.

## 0.0.6 - May 19, 2022

- Updated the value of the pubspec 'repository' field.

## 0.0.5 - November 18, 2021

- Add missing key to Scaffold widgets.
- Replace `AppBar` deprecated fields and add linting to example.

## 0.0.4 - July 14, 2021

- Adopt `flutter_lints` and migrate from `RaisedButton` to `ElevatedButton`.

## 0.0.3 - December 14, 2020

- Migrate to NNBD

## 0.0.2 - October 9, 2020

- Update adaptive_breakpoint dependency.

## 0.0.1 - August 12, 2020

- The initial release adds adaptive navigation(https://material.io/design/layout/responsive-layout-grid.html##ui-regions)
