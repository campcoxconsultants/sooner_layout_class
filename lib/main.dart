import 'package:flutter/material.dart';
import 'package:layout/chat_entry.dart';

import 'chat.dart';
import 'chat_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sooners Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Sooners Demo Home Page',
        initialText: 'Hello World',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.initialText,
  });

  final String title;

  final String? initialText;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _numbers = [5, 27, 3, 100];

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController()
      ..addListener(_updateText)
      ..text = widget.initialText ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _updateText() => setState(() {});

  String get _typedText => _controller.text;

  double _spacing = 32;

  bool _isRecording = false;

  String get _recordingString => _isRecording ? 'Recording On' : '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              print('we pressed');
            },
            icon: const Icon(Icons.check_box),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    SingleChat(
                      chat: Chat(
                        fromName: 'You',
                        toName: 'Everyone',
                        time: '2:09 PM',
                        text: 'Hello World',
                      ),
                    ),
                    SizedBox(height: 32),
                    SingleChat(
                      chat: Chat(
                        fromName: 'You',
                        toName: 'Everyone',
                        time: '2:09 PM',
                        text: 'Hello World',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: const BoxDecoration(
              color: Color(0xFFEFEFF4),
              border: Border(
                bottom: BorderSide(color: Color(0xFFC0C0CF)),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_2_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
                Text(
                  'Who can see your messages. $_recordingString',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ChatEntry(names: ['Rebekah']),
          ),
        ],
      ),
    );
  }
}
