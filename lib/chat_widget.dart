import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class SingleChat extends StatefulWidget {
  const SingleChat({
    super.key,
    required this.chat,
    this.paddingSize = 32,
    required this.removeChat,
  });

  final Chat chat;

  final double paddingSize;

  final void Function(Chat chat) removeChat;

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  bool _actionsExpanded = false;

  void _deleteChat() {
    widget.removeChat(widget.chat);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 56),
            Text(widget.chat.fromName),
            const Text(' to '),
            Text(
              widget.chat.toName,
              style: const TextStyle(color: Color(0xFF2D6BD2)),
            ),
            const SizedBox(width: 16),
            Text(widget.chat.time),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  color: Color(0xFFE2F0FE),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.chat.text),
                    for (int i = 0; i < widget.chat.images.length; ++i)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.file(
                              widget.chat.images[i],
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                print('pressed actions');
                setState(() {
                  _actionsExpanded = !_actionsExpanded;
                });
              },
              icon: const Text('...'),
            ),
            if (_actionsExpanded)
              Column(children: [
                IconButton(
                    onPressed: () => _deleteChat(),
                    icon: const Icon(Icons.delete)),
              ]),
          ],
        ),
        SizedBox(height: widget.paddingSize),
      ],
    );
  }
}
