import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
  bool imageSelected = false;
  late File image;

  // Handler for selecting images
  Future getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        image = file;
        imageSelected = !imageSelected;
      });
    } else {
      setState(() {
        imageSelected = !imageSelected;
      });
    }
  }

  removeImage() {
    setState(() {
      imageSelected = false;
      actionsExpanded = false;
    });
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
                    if (imageSelected) const SizedBox(height: 10),
                    if (imageSelected)
                      Container(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.file(
                              image,
                              height: 200,
                              width: 250,
                            ),
                            IconButton(
                              onPressed: removeImage,
                              icon: const Icon(Icons.close),
                            )
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
                  actionsExpanded = !actionsExpanded;
                });
              },
              icon: const Text('...'),
            ),
            if (actionsExpanded)
              Column(children: [
                const Text('Copy'),
                const Text('Quote'),
                IconButton(
                  onPressed: getImage,
                  icon: const Icon(Icons.image),
                )
              ]),
          ],
        ),
        SizedBox(height: widget.paddingSize),
      ],
    );
  }
}
