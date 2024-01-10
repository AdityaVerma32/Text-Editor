import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // list to store text widgets
  List<TextWidget> textWidgets = [];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double DW = mediaQuery.size.width;
    double DH = mediaQuery.size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('Text App'),
        ),
        body: Stack(
          children: [
            for (var textWidget in textWidgets) textWidget,
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _addTextWidget();
            },
            label: Text("Add Text box")));
  }

  void _addTextWidget() {
    setState(() {
      textWidgets.add(TextWidget());
    });
  }
}

class TextWidget extends StatefulWidget {
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  Offset position = Offset(150, 400);
  double fontSize = 16.0;
  Color textColor = Colors.black;
  String textContent = 'Edit me';
  FontStyle fontStyle = FontStyle.normal;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        child: GestureDetector(
          onTap: () {
            _showTextEditorDialog();
          },
          child: Text(
            textContent,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontStyle: fontStyle,
            ),
          ),
        ),
        feedback: Container(
          width: 100,
          height: 50,
          child: Text(
            textContent,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontStyle: fontStyle,
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
      ),
    );
  }

  Future<void> _showTextEditorDialog() async {
    TextEditingController _fontSizeController = TextEditingController();
    TextEditingController _textEditorController = TextEditingController();
    TextEditingController _fontStyleController = TextEditingController();
    TextEditingController _fontColorController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Text Editor'),
          content: Column(
            children: [
              // for changing Content of text
              TextField(
                controller: _textEditorController,
                decoration: InputDecoration(labelText: 'Text Content'),
                keyboardType: TextInputType.text,
              ),

              TextField(
                controller: _fontStyleController,
                decoration: InputDecoration(labelText: 'Font Style'),
                keyboardType: TextInputType.text,
              ),

              TextField(
                controller: _fontColorController,
                decoration: InputDecoration(labelText: 'Font Color'),
              ),

              // for changing font size of the text
              TextField(
                controller: _fontSizeController,
                decoration: InputDecoration(labelText: 'Font Size'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              //  onPressed: () {
              //   _updateTextProperties(
              //     double.parse(_fontSizeController.text),
              //     _colorController.text.isNotEmpty
              //         ? Color(int.parse('0xFF${_colorController.text}'))
              //         : textColor,
              //   );
              //   Navigator.of(context).pop();
              // },
              onPressed: () {
                _updateTextProperties(
                  double.parse(_fontSizeController.text),
                  _fontColorController.text.isNotEmpty
                      ? getFontColorFromString(_fontColorController.text)
                      : textColor,
                  _textEditorController.text.isNotEmpty
                      ? _textEditorController.text
                      : textContent,
                  _fontStyleController.text.isNotEmpty
                      ? getFontStyleFromString(_fontStyleController.text)
                      : fontStyle,
                );
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void _updateTextProperties(
      double newSize, Color newColor, String newText, FontStyle newFontStyle) {
    setState(() {
      fontSize = newSize;
      textColor = newColor;
      textContent = newText;
      fontStyle = newFontStyle;
    });
  }
}

FontStyle getFontStyleFromString(String fontStyleString) {
  switch (fontStyleString.toLowerCase()) {
    case 'normal':
      return FontStyle.normal;
    case 'italic':
      return FontStyle.italic;
    default:
      return FontStyle.normal;
  }
}

Color getFontColorFromString(String fontColor) {
  switch (fontColor.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'yellow':
      return Colors.yellow;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'purple':
      return Colors.purple;
    case 'orange':
      return Colors.orange;
    case 'brown':
      return Colors.brown;
    default:
      return Colors.black;
  }
}
