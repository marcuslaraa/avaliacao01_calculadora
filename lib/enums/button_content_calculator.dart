import 'package:flutter/material.dart';

enum ButtonContentCalculator {
  clear(null, 'C'),
  cl(Icons.backspace),
  divide(null, '/', 'operator'),
  multiply(null, '*', 'operator'),

  seven(null, '7'),
  eight(null, '8'),
  nine(null, '9'),
  minus(null, '-', 'operator'),
  four(null, '4'),
  five(null, '5'),
  six(null, '6'),
  plus(null, '+', 'operator'),
  one(null, '1'),
  two(null, '2'),
  three(null, '3'),
  equal(null, '='),
  zero(null, '0'),
  dot(null, '.');

  final IconData? icon;
  final String? label;
  final String? type;

  const ButtonContentCalculator(this.icon, [this.label, this.type = '']);
}
