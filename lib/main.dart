import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              SingleChat(),
              SizedBox(height: 32),
              SingleChat(),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleChat extends StatefulWidget {
  const SingleChat({Key? key}) : super(key: key);

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  bool actionsExpanded = false;

  final String fromName = 'You';

  final String toName = 'Everyone';

  final String time = '2:08 PM';

  final String text = 'export FLUTTER_SDK=\$HOME/flutter\n\nexport DART_SDK=\$FLUTTER_SDK/\n\n'
      'bin/cache/dart-sdk\n\nexport PATH=\$PATH:\$FLUTTER SDK/\n\nbin: \$DART_SDK/bin';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 56),
            Text(fromName),
            const Text(' to '),
            Text(
              toName,
              style: const TextStyle(color: Colors.lightBlue),
            ),
            const SizedBox(width: 16),
            Text(time),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: const Center(
                child: Text(
                  'D',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(text),
              ),
            ),
            const SizedBox(width: 8),
            if (actionsExpanded)
              Column(children: const [
                Text('Copy'),
                Text('Quote'),
                Text('Button'),
              ])
            else
              IconButton(
                onPressed: () {
                  print('pressed actions');
                  setState(() {
                    actionsExpanded = !actionsExpanded;
                  });
                },
                icon: const Text('...'),
              ),
          ],
        ),
      ],
    );
  }
}
