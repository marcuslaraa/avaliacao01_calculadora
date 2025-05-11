import 'package:avaliacao01_calculadora/enums/button_content_calculator.dart';
import 'package:flutter/material.dart';

class ButtonCalculator extends StatefulWidget {
  final List<ButtonContentCalculator> buttons;
  const ButtonCalculator({super.key, required this.buttons});

  @override
  State<ButtonCalculator> createState() => _ButtonCalculatorState();
}

class _ButtonCalculatorState extends State<ButtonCalculator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('1')),
        ElevatedButton(onPressed: () {}, child: const Text('2')),
        ElevatedButton(onPressed: () {}, child: const Text('3')),
        ElevatedButton(onPressed: () {}, child: const Text('+')),
      ],
    );
  }
}
