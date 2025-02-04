import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ryan Miner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _expression = '';

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _evaluateExpression() {
    final expression = Expression.parse(_expression);
    final evaluator = const ExpressionEvaluator();
    final result = evaluator.eval(expression, {});

    setState(() {
      _expression = result.toString();
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 45,
        ),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 17, 255),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: Text(
                _expression,
                style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('+'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('/'),
            ],
          ),
          Row(
            children: [
              _buildButton('C'),
              _buildButton('%')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          if (value == '=') {
            _evaluateExpression();
          } else if (value == 'C') {
            _clearExpression();
          } else {
            _addToExpression(value);
          }
        },
        child: Text(
          value,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Color.fromARGB(255, 0, 17, 255)),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue[300]),
          foregroundColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(255, 0, 17, 255)),
          
        ),
      ),
    );
  }
}

//Copilot seems to have gotten the logic correct
//Copilot did not do styling though, so the font sizing, weight, colors, etc. are my doing
//Calculator does indeed handle edge cases, but needs to be cleared after doing so.

//V2: Added modulus operator