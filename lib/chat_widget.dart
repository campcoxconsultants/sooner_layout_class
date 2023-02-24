import 'package:flutter/material.dart';

import 'chat.dart';

class SingleChat extends StatefulWidget {
  const SingleChat({
    super.key,
    required this.chat,
    this.paddingSize = 32,
  });

  final Chat chat;

  final double paddingSize;

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  bool actionsExpanded = false;

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
                child: Text(widget.chat.text),
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
        SizedBox(height: widget.paddingSize),
      ],
    );
  }
}
