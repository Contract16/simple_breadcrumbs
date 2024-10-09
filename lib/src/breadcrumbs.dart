import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_breadcrumbs/src/data.dart';

class Breadcrumbs extends StatelessWidget {
  final bool capitalize;
  final Iterable<Breadcrumb> breadcrumbs;
  final String divider;
  final String pathConnector;
  final Function(String path)? onNavigate;
  final TextStyle? textStyle;
  final TextStyle? selectedStyle;
  final TextStyle? dividerStyle;
  final int? maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;

  const Breadcrumbs({
    super.key,
    required this.breadcrumbs,
    this.divider = ' ... ',
    this.pathConnector = '/',
    this.capitalize = false,
    this.onNavigate,
    this.textStyle,
    this.selectedStyle,
    this.dividerStyle,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      text: TextSpan(
        children: [
          ...breadcrumbs
              .mapIndexed(
                (index, bc) => [
                  TextSpan(
                    text: capitalize ? bc.label.capitalize : bc.label,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => onNavigate?.call(_fullPath(index)),
                    style: index == breadcrumbs.length - 1
                        ? selectedStyle ?? textStyle
                        : textStyle,
                  ),
                  if (index < breadcrumbs.length - 1)
                    TextSpan(
                      text: divider,
                      style: dividerStyle,
                    ),
                ],
              )
              .expand((i) => i),
        ],
      ),
    );
  }

  String _fullPath(int index) =>
      breadcrumbs.take(index + 1).map((b) => b.path).join(pathConnector);
}

extension on String {
  String get capitalize =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}
