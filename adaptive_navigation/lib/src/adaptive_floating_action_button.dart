import 'package:flutter/material.dart';

import 'adaptive_navigation_scaffold.dart';

/// AdaptiveFloatingActionButton works only inside a [AdaptiveNavigationScaffold]
/// and uses the same API as the [FloatingActionButton.extended] with [isExtended]
/// property set to false by default. It works well with
/// [AdaptiveNavigationScaffold.fabInRail] and
/// [AdaptiveNavigationScaffold.fabInPermanentDrawer] properties.
///
/// It wont be extended when navigation type is rail and
/// [AdaptiveNavigationScaffold.fabInRail] is true even if [isExtended] is true.
///
/// It well be extended when navigation type is permanent drawer and
/// [AdaptiveNavigationScaffold.fabInPermanentDrawer] is true even if
/// [isExtended] is false.
class AdaptiveFloatingActionButton extends StatelessWidget {
  const AdaptiveFloatingActionButton({
    super.key,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.heroTag,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.splashColor,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor = SystemMouseCursors.click,
    this.shape,
    this.isExtended = false,
    this.materialTapTargetSize,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.extendedIconLabelSpacing,
    this.extendedPadding,
    this.extendedTextStyle,
    this.icon,
    required this.label,
    this.enableFeedback,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0);

  /// The icon of the button.
  final Widget? icon;

  /// The label of the widget.
  final Widget label;

  /// See [FloatingActionButton.tooltip].
  final String? tooltip;

  /// See [FloatingActionButton.foregroundColor].
  final Color? foregroundColor;

  /// See [FloatingActionButton.backgroundColor].
  final Color? backgroundColor;

  /// See [FloatingActionButton.focusColor].
  final Color? focusColor;

  /// See [FloatingActionButton.hoverColor].
  final Color? hoverColor;

  /// See [FloatingActionButton.splashColor].
  final Color? splashColor;

  /// See [FloatingActionButton.heroTag].
  final Object? heroTag;

  /// See [FloatingActionButton.onPressed].
  final VoidCallback? onPressed;

  /// {@macro flutter.material.RawMaterialButton.mouseCursor}
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// See [FloatingActionButton.elevation].
  final double? elevation;

  /// See [FloatingActionButton.focusElevation].
  final double? focusElevation;

  /// See [FloatingActionButton.hoverElevation].
  final double? hoverElevation;

  /// See [FloatingActionButton.highlightElevation].
  final double? highlightElevation;

  /// See [FloatingActionButton.disabledElevation].
  final double? disabledElevation;

  /// See [FloatingActionButton.shape].
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// True if this is an "extended" floating action button. Defaults to false.
  ///
  /// Ignore when [AdaptiveNavigationScaffold.fabInRail] or
  /// [AdaptiveNavigationScaffold.fabInPermanentDrawer] are true and
  /// navigation type is rail or permanent drawer respectively.
  ///
  /// The [Scaffold] animates the appearance of ordinary floating
  /// action buttons with scale and rotation transitions. Extended
  /// floating action buttons are scaled and faded in.
  final bool isExtended;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// See [FloatingActionButton.materialTapTargetSize].
  final MaterialTapTargetSize? materialTapTargetSize;

  /// See [FloatingActionButton.enableFeedback].
  final bool? enableFeedback;

  /// See [FloatingActionButton.extendedIconLabelSpacing].
  ///
  /// Ignored for permanent drawer navigation type when
  /// [AdaptiveNavigationScaffold.fabInPermanentDrawer] is true.
  final double? extendedIconLabelSpacing;

  /// See [FloatingActionButton.extendedPadding].
  final EdgeInsetsGeometry? extendedPadding;

  /// See [FloatingActionButton.extendedTextStyle].
  final TextStyle? extendedTextStyle;

  @override
  Widget build(BuildContext context) {

    final bool permanentDrawerWithFab =
        AdaptiveNavigationScaffold.of(context).navigationType ==
                NavigationType.permanentDrawer &&
            AdaptiveNavigationScaffold.of(context).widget.fabInPermanentDrawer;
    final bool railWithFab =
        AdaptiveNavigationScaffold.of(context).navigationType ==
                NavigationType.rail &&
            AdaptiveNavigationScaffold.of(context).widget.fabInRail;

    final ThemeData theme = Theme.of(context);

    final Color labelColor = foregroundColor ??
        theme.floatingActionButtonTheme.foregroundColor ??
        theme.colorScheme.onSecondary;
    final EdgeInsetsGeometry padding = extendedPadding ??
        Theme.of(context).floatingActionButtonTheme.extendedPadding ??
        (icon != null
            ? const EdgeInsetsDirectional.only(start: 16.0, end: 20.0)
            : const EdgeInsetsDirectional.only(start: 20.0, end: 20.0));

    return !permanentDrawerWithFab
        ? FloatingActionButton.extended(
            key: key,
            tooltip: tooltip,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            focusColor: focusColor,
            hoverColor: hoverColor,
            heroTag: heroTag,
            elevation: elevation,
            focusElevation: focusElevation,
            hoverElevation: hoverElevation,
            splashColor: splashColor,
            highlightElevation: highlightElevation,
            disabledElevation: disabledElevation,
            onPressed: onPressed,
            mouseCursor: mouseCursor,
            shape: shape,
            isExtended: isExtended && !railWithFab,
            materialTapTargetSize: materialTapTargetSize,
            clipBehavior: clipBehavior,
            focusNode: focusNode,
            autofocus: autofocus,
            extendedIconLabelSpacing: extendedIconLabelSpacing,
            extendedPadding: extendedPadding,
            extendedTextStyle: extendedTextStyle,
            enableFeedback: enableFeedback,
            icon: icon,
            label: label,
          )
        : FloatingActionButton(
            key: key,
            tooltip: tooltip,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            focusColor: focusColor,
            hoverColor: hoverColor,
            heroTag: heroTag,
            elevation: elevation,
            focusElevation: focusElevation,
            hoverElevation: hoverElevation,
            splashColor: splashColor,
            highlightElevation: highlightElevation,
            disabledElevation: disabledElevation,
            onPressed: onPressed,
            mouseCursor: mouseCursor,
            shape: shape,
            isExtended: isExtended,
            materialTapTargetSize: materialTapTargetSize,
            clipBehavior: clipBehavior,
            focusNode: focusNode,
            autofocus: autofocus,
            enableFeedback: enableFeedback,
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) icon!,
                  Expanded(
                    child: Center(
                        child: extendedTextStyle != null
                            ? DefaultTextStyle(
                                style: extendedTextStyle!
                                    .copyWith(color: labelColor),
                                child: label)
                            : label),
                  ),
                ],
              ),
            ),
          );
  }
}
