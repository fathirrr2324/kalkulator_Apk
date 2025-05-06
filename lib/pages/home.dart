import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(KalkulatorApp());

class KalkulatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: KalkulatorHome(),
    );
  }
}

class KalkulatorHome extends StatefulWidget {
  @override
  _KalkulatorHomeState createState() => _KalkulatorHomeState();
}

class _KalkulatorHomeState extends State<KalkulatorHome> {
  String userInput = '';
  String result = '';

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', '=', 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator Flutter')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                userInput,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () => onButtonPressed(buttons[index]),
                  child: Text(
                    buttons[index],
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        userInput = '';
        result = '';
      } else if (buttonText == 'DEL') {
        userInput = userInput.substring(0, userInput.length - 1);
      } else if (buttonText == '=') {
        calculateResult();
      } else {
        userInput += buttonText;
      }
    });
  }

  void calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(userInput.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toString();
      userInput = result;
    } catch (e) {
      result = 'Error';
    }
  }
}
