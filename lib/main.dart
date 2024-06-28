import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kalkulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ' '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String equation = "0";
  String result = "0";
  String expression = " ";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "del") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "c") {
        if (equation!= "0") {
          equation = equation.substring(0, equation.length - 1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, [Color backgroundColor = const Color.fromARGB(255, 255, 20, 3)]) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: const Color.fromARGB(255, 16, 16, 16),
          side: BorderSide(width: 1, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Text('•••'),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            
            SizedBox(height: 32),
              Text(
                'Preference',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),

            CheckboxListTile(
  secondary: Icon(Icons.vibration), // Icon on the left side
  title: Text('Vibration on touch'),
  value: false , // Replace with a variable to control the checked state
  onChanged: (bool? value) {
    setState(() {
      // Update your state variable here to reflect the new value
    });
  },
),
            CheckboxListTile(
  secondary: Icon(Icons.memory), // Icon on the left side
  title: Text('Memory buttons'),
  value: false, // Replace with a variable to control the checked state
  onChanged: (bool? value) {
    setState(() {
      // Update your state variable here to reflect the new value
    });
  },
),
    ListTile(
  leading: Icon(Icons.keyboard), // Ikon email
  title: Text('Keyped layout'),
  subtitle: RichText(
    text: TextSpan(
      children: [
        TextSpan(text: 'Standard\n', style: TextStyle(fontSize: 16)),
      ],
    ),
  ),
  onTap: () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
           title: Text('Keyped Layout', style: TextStyle(color: Colors.red, fontSize: 20)), // Increased font size to 20
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Divider(height: 1, color: const Color.fromARGB(255, 236, 74, 74)), // Add divider
               ListTile(
                title: Text('Standard'),
                trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 249, 249)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 1 selection
                  print('Standard selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
ListTile(
  title: Text('Stylish'),
  trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 249, 249)), // Set the fill color to white
  ),
  onTap: () {
    // Handle option 2 selection
    print('Stylish selected');
    Navigator.pop(context);
  },
),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Ergonomic'),
                trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 249, 249)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 3 selection
                  print('Ergonomic selected');
                  Navigator.pop(context);
                },
              ),
               Divider(height: 1, color: Colors.grey), // Add divider
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 18, 18, 18) // Button text size
                  ),
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  },
),

ListTile(
  leading: Icon(Icons.color_lens), // Ikon email
  title: Text('Theme'),
  subtitle: RichText(
    text: TextSpan(
      children: [
        TextSpan(text: 'Material - Red\n', style: TextStyle(fontSize: 16)),
      ],
    ),
  ),
  onTap: () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
           title: Text('Theme', style: TextStyle(color: Colors.red, fontSize: 15)), // Increased font size to 20
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(height: 1, color: Color.fromARGB(255, 246, 120, 120)), // Add divider
              ListTile(
                title: Text('Matrial - Indigo'),
                trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 1 selection
                  print('Option 1 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Matrial - Red'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 2 selection
                  print('Option 2 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Matrial - Green'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 3 selection
                  print('Option 3 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Matrial - Amber'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 4 selection
                  print('Option 4 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Matrial - Pink'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 5 selection
                  print('Option 5 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Matrial - Brown'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 6 selection
                  print('Option 6 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Original - Black'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 7 selection
                  print('Option 7 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Original - White'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 8 selection
                  print('Option 8 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Original - Blue'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 9 selection
                  print('Option 9 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Original - Green'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 10 selection
                  print('Option 10 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('Original - Red'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 219, 216, 216)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 11 selection
                  print('Option 11 selected');
                  Navigator.pop(context);
                },
              )
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 13, 13, 13), textStyle: const TextStyle(fontSize: 18), // Button text size
                  ),
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  },
),

ListTile(
  leading: Icon(Icons.format_list_numbered), // Ikon email
  title: Text('display format'),
  subtitle: RichText(
    text: TextSpan(
      children: [
        TextSpan(text: '1.234,5\n', style: TextStyle(fontSize: 16)),
      ],
    ),
  ),
  onTap: () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('display format', style: TextStyle(color: Colors.red, fontSize: 15)), // Increased font size to 20
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('1,234.5'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 249, 249)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 1 selection
                  print('Option 1 selected');
                  Navigator.pop(context);
                },
              ),
               Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('1 234,5'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 249, 249)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 1 selection
                  print('1 234,5 selected');
                  Navigator.pop(context);
                },
              ),
               Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('1.234,5'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 249, 249)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 1 selection
                  print('Option 1 selected');
                  Navigator.pop(context);
                },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
              ListTile(
                title: Text('1123.5'),
                 trailing: Radio(
    value: null,
    groupValue: null,
    onChanged: (value) {}, // Handle radio button change
    activeColor: Colors.white, // Set the active color to white
    fillColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 249, 249)), // Set the fill color to white
  ),
                onTap: () {
                  // Handle option 2 selection
                  print('Option 2 selected');
                  Navigator.pop(context);
               },
              ),
              Divider(height: 1, color: Colors.grey), // Add divider
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                     textStyle: const TextStyle(fontSize: 18), // Button text size
                  ),
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  },
),       
SizedBox(height: 32),
              Text(
                'Others',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ListTile(
              title: Text('Send this app'),
              onTap: () {
                // Handle tap on Business item
              },
            ),
            ListTile(
              title: Text('Send feedback'),
              onTap: () {
                // Handle tap on Business item
              },
            ),
            ListTile(
              title: Text('Rate this app'),
              onTap: () {
                // Handle tap on School item
              },
            ),
            ListTile(
              title: Text('Uprage (Ad-free version)'),
              onTap: () {
                // Handle tap on Business item
              },
            ),
            ListTile(
              title: Text('Other apps'),
              onTap: () {
                // Handle tap on Business item
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Handle tap on Business item
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: Text(
              result + '⌫', // Add '=>' after the result
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // First Row
                  Row(
                    children: <Widget>[
                      buildButton("del", Color.fromARGB(255, 246, 4, 4)), // Button withwhite background 
                      buildButton("c", Color.fromARGB(255, 249, 5, 5)), // Button with white background
                      buildButton("%", Color.fromARGB(255, 254, 4, 4)), // Button with white background
                      buildButton("÷"),
                    ],
                  ),
                  
                  Row(
                    children: <Widget>[
                      buildButton("7", Colors.white), // Button with white background
                      buildButton("8", Colors.white), // Button with white background
                      buildButton("9", Colors.white), // Button with white background
                      buildButton("×"),
                    ],
                  ),
                 
                  Row(
                    children: <Widget>[
                      buildButton("4", Colors.white), // Button with white background
                      buildButton("5", Colors.white), // Button with white background
                      buildButton("6", Colors.white), // Button with white background
                      buildButton("-"),
                    ],
                  ),
                  
                  Row(
                    children: <Widget>[
                      buildButton("1", Colors.white), // Button with white background
                      buildButton("2", Colors.white), // Button with white background
                      buildButton("3", Colors.white), // Button with white background
                      buildButton("+"),
                    ],
                  ),
                
                  Row(
                    children: <Widget>[
                      buildButton("0", Colors.white), // Button with white background
                      buildButton("00", Colors.white), // Button with white background
                      buildButton(".", Colors.white), // Button with white background
                      buildButton("="),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}