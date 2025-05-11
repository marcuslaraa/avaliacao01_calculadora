import 'package:avaliacao01_calculadora/enums/button_content_calculator.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Calculator(title: 'Calculadora'),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController _controller = TextEditingController(text: '0');
  late ButtonContentCalculator lastOperation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButtonPressed(ButtonContentCalculator value) {
    setState(() {
      switch (value) {
        case ButtonContentCalculator.clear:
          _controller.clear();
          _controller.text = '0';
          lastOperation = value;
          break;
        case ButtonContentCalculator.cl:
          if (_controller.text.isNotEmpty) {
            _controller.text = _controller.text.substring(
              0,
              _controller.text.length - 1,
            );
          }
          break;
        case ButtonContentCalculator.plus:
          if (validateInput(value, _controller.text)) break;
          _controller.text += ButtonContentCalculator.plus.label!;
          lastOperation = value;
          break;
        case ButtonContentCalculator.minus:
          if (validateInput(value, _controller.text)) break;
          _controller.text += ButtonContentCalculator.minus.label!;
          lastOperation = value;
          break;
        case ButtonContentCalculator.multiply:
          if (validateInput(value, _controller.text)) break;
          _controller.text += ButtonContentCalculator.multiply.label!;
          lastOperation = value;
          break;
        case ButtonContentCalculator.divide:
          if (validateInput(value, _controller.text)) break;
          _controller.text += ButtonContentCalculator.divide.label!;
          lastOperation = value;
          break;
        case ButtonContentCalculator.equal:
          _calculateResult();
          lastOperation = value;
          break;
        default:
          if (validateInput(value, _controller.text)) break;
          if (_controller.text == '0') {
            _controller.text = value.label!;
          } else {
            _controller.text += value.label!;
          }
          break;
      }
    });
  }

  bool validateInput(ButtonContentCalculator value, String input) {
    String lastChar = input.isNotEmpty ? input[input.length - 1] : '';
    if (lastChar == ButtonContentCalculator.zero.label &&
        input.length == 1 &&
        value.type == 'operator') {
      _controller.text = '0';
      return true;
    }

    if (value.type == 'operator') {
      if (lastChar == '+' ||
          lastChar == '-' ||
          lastChar == '*' ||
          lastChar == '/') {
        return true;
      }
      return false;
    }

    if (lastOperation == ButtonContentCalculator.equal) {
      return true;
    }

    return false;
  }

  void _calculateResult() {
    setState(() {
      try {
        String expression = _controller.text;

        expression = expression.replaceAll(',', '.');

        Parser parser = Parser();
        Expression exp = parser.parse(expression);

        ContextModel context = ContextModel();

        double result = exp.evaluate(EvaluationType.REAL, context);

        _controller.text = result.toString();
      } catch (e) {
        _controller.text = 'Erro';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF84CAFF), Color(0xFF001E3C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 200),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                    textAlign: TextAlign.right,
                    readOnly: true,
                  ),
                ),
                SizedBox(height: 60),

                Wrap(
                  spacing: 35,
                  runSpacing: 35,
                  children:
                      ButtonContentCalculator.values.map((button) {
                        return ElevatedButton(
                          onPressed: () {
                            _onButtonPressed(button);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.lightBlue,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child:
                              button.icon != null
                                  ? Icon(button.icon)
                                  : Text(button.label!),
                        );
                      }).toList(),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
