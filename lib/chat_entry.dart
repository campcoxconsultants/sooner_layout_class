import 'package:flutter/material.dart';

class ChatEntry extends StatefulWidget {
  const ChatEntry({
    super.key,
    required this.names,
  });

  final List<String> names;

  @override
  State<ChatEntry> createState() => _ChatEntryState();
}

class _ChatEntryState extends State<ChatEntry> {
  static const _maxCharacters = 144;

  late String _selectedName;
  late List<String> _names;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _selectedName = widget.names.first;
    _names = ['Everyone', ...widget.names];

    _controller = TextEditingController()..addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();

    super.dispose();
  }

  int get _charactersRemaining => _maxCharacters - _controller.text.length;

  _onTextChanged() {
    final text = _controller.text;

    if (text.contains(RegExp('shit'))) {
      _controller.text = text.replaceAll('shit', '****');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_toSelection, _textEntry, _iconRow],
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
        Text('$_charactersRemaining char left')
      ],
    );
  }

  Widget get _iconRow {
    return SizedBox();
  }
}
