import 'package:flutter/material.dart';

import 'chat.dart';

class ChatEntry extends StatefulWidget {
  const ChatEntry({
    super.key,
    required this.names,
    required this.addChat,
  });

  final List<String> names;

  final void Function(Chat chat) addChat;

  @override
  State<ChatEntry> createState() => _ChatEntryState();
}

class _ChatEntryState extends State<ChatEntry> {
  static const _maxCharacters = 144;

  late String _selectedName;
  late List<String> _names;
  late final _ChatTextController _controller;

  @override
  void initState() {
    super.initState();

    _selectedName = widget.names.first;
    _names = ['Everyone', ...widget.names];

    _controller = _ChatTextController(maxCharacters: _maxCharacters)..addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();

    super.dispose();
  }

  int get _charactersRemaining => _maxCharacters - _controller.text.length;

  bool get _canAddText => _controller.text.isNotEmpty && _controller.text.length <= _maxCharacters;

  Color get _charactersRemainingColor => _charactersRemaining < 0 ? Colors.red : Colors.black;

  void _onTextChanged() {
    final text = _controller.text;

    if (text.length > _maxCharacters) {
      final currentOffset = _controller.selection.end;
      _controller.text = text.substring(text.length - _maxCharacters);
      _controller.selection = TextSelection.collapsed(offset: currentOffset - 1);
    }

    if (text.contains(RegExp('shit'))) {
      final selection = _controller.selection;
      _controller.text = text.replaceAll('shit', '****');
      _controller.selection = selection;
    }
    setState(() {});
  }

  void _callAddText() {
    print('Add message: ${_controller.text}');

    // TODO: figure out how to address this
    widget.addChat(
      Chat(
        fromName: 'You',
        toName: _selectedName,
        // TODO: Add time
        time: '12:07',
        text: _controller.text,
      ),
    );

    setState(() {
      _controller.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _toSelection,
        _textEntry,
        _iconRow,
      ],
    );
  }

  Widget get _toSelection {
    return Row(
      children: [
        const Text('To: '),
        DropdownButton<String>(
          value: _selectedName,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          // underline: Container(
          //   height: 2,
          //   color: Colors.deepPurpleAccent,
          // ),
          onChanged: (String? value) {
            setState(() {
              _selectedName = value!;
            });
          },
          items: _names.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(width: 8),
        if (_selectedName != _names[0])
          const Text(
            '(Direct Message)',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Widget get _textEntry {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Type message here ...',
          ),
          minLines: 2,
          maxLines: 4,
          controller: _controller,
        ),
        Text(
          '$_charactersRemaining char left',
          style: TextStyle(color: _charactersRemainingColor),
        )
      ],
    );
  }

  Widget get _iconRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: _canAddText ? _callAddText : null,
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}

class _ChatTextController extends TextEditingController {
  _ChatTextController({super.text, required this.maxCharacters});

  final int maxCharacters;

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    // TODO: implement buildTextSpan
    return TextSpan(
      text: text.substring(0, maxCharacters),
      style: style?.copyWith(color: Colors.red),
    );
  }
}
