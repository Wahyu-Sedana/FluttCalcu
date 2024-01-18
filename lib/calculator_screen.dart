import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    input,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style:
                        TextStyle(fontSize: 47, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.white),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12),
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(buttonList[index]);
                }),
          ))
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: () {
        handleButtonPress(text);
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                  offset: Offset(-3, -3))
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: getColor(text), fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void handleButtonPress(String text) {
    setState(() {
      // Implement your button press logic here
      if (text == 'AC') {
        input = '';
        result = '0';
        return;
      } else if (text == 'C') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
          return;
        }
      } else if (text == "=") {
        result = calculate();
        input = result;

        if (input.endsWith(".0")) {
          input = input.replaceAll(".0", "");
        }

        if (result.endsWith(".0")) {
          result = result.replaceAll(".0", "");
          return;
        }
      }
      input += text;
    });
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "(" ||
        text == ")" ||
        text == "C") {
      return Color.fromARGB(255, 252, 100, 10);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == "AC") {
      return Color.fromARGB(255, 252, 100, 10);
    }

    if (text == "=") {
      return Color.fromARGB(255, 104, 204, 155);
    }
    return Color(0xFF1d2630);
  }

  String calculate() {
    try {
      var exp = Parser().parse(input);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return " error";
    }
  }
}
