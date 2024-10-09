import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_breadcrumbs/src/data.dart';

class Breadcrumbs extends StatelessWidget {
  final Iterable<Breadcrumb> breadcrumbs;
  final String divider;
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
                    text: bc.label,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => onNavigate?.call(bc.path),
                    style: index == breadcrumbs.length - 1
                        ? selectedStyle ?? textStyle
                        : textStyle,
                  ),
                  if (index < breadcrumbs.length - 1)
                    TextSpan(
                      text: divider,
                      style: dividerStyle ?? textStyle,
                    ),
                ],
              )
              .expand((i) => i),
        ],
      ),
    );
  }
}
