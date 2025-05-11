import 'package:avaliacao01_calculadora/enums/button_content_calculator.dart';
import 'package:flutter/material.dart';

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
  late String _input;

  @override
  void initState() {
    super.initState();
    _input = '';
  }

  void _onButtonPressed(ButtonContentCalculator value) {
    setState(() {
      switch (value) {
        case ButtonContentCalculator.clear:
          _controller.clear();
          _controller.text = '0';
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
          // validateInput(value, _controller.text);
          _controller.text += '+';
          break;
        case ButtonContentCalculator.minus:
          _controller.text += '-';
          break;
        case ButtonContentCalculator.multiply:
          _controller.text += '*';
          break;
        case ButtonContentCalculator.divide:
          _controller.text += '/';
          break;
        default:
          // validateInput(value, _controller.text);
          break;
      }
    });
  }

  // void validateInput(ButtonContentCalculator value, String input) {
  //   if (input[input.length - 1] == ButtonContentCalculator.zero.label &&
  //       input.length == 1 &&
  //       value.type == 'operator') {
  //     _controller.text = '';
  //     return;
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
