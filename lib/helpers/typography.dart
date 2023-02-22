import 'package:flutter/material.dart';
import '../const.dart';
import '../theme.dart';

double pW(double percent) => width() * (percent / 100);

TextStyle largeHeaderStyle() => TextStyle(
    color: textColor, fontWeight: FontWeight.w300, fontSize: pW(6));

TextStyle normalHeaderStyle() =>
    const TextStyle(color: textColor, fontWeight: FontWeight.w300);

TextStyle articleFontTiny({Color color = textColor}) =>
    TextStyle(fontSize: pW(2), fontWeight: FontWeight.w300, color: color);

TextStyle articleFontAlmostTiny({Color color = textColor}) =>
    TextStyle(fontSize: pW(2.7), fontWeight: FontWeight.w300, color: color);

TextStyle articleFontExtraSmall({Color color = textColor}) =>
    TextStyle(fontSize: pW(3), fontWeight: FontWeight.w300, color: color);


TextStyle articleFontMidSmall({Color color = textColor}) =>
    TextStyle(fontSize: pW(3.2), fontWeight: FontWeight.w300, color: color);

TextStyle articleFontSmall({Color color = textColor}) =>
    TextStyle(fontSize: pW(3.4), fontWeight: FontWeight.w300, color: color);

TextStyle articleFontMedium({Color color = textColor}) =>
    TextStyle(fontSize: pW(4.1), fontWeight: FontWeight.w300, color: color);

TextStyle articleFontMedium2({Color color = textColor}) =>
    TextStyle(fontSize: pW(4), fontWeight: FontWeight.w300, color: color);


TextStyle articleFontMedium3({Color color = textColor}) =>
    TextStyle(fontSize: pW(4.5), fontWeight: FontWeight.w300, color: color);


TextStyle articleFontBig({Color color = textColor}) =>
    TextStyle(fontSize: pW(5.0), fontWeight: FontWeight.w300, color: color);


