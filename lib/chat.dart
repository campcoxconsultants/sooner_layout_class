import 'dart:io';

class Chat {
  Chat({
    required this.fromName,
    required this.toName,
    required this.time,
    required this.text,
    required this.images,
  });

  final String fromName;

  final String toName;

  final String time;

  final String text;
  // TODO: make this final (copy with)
  List<File> images = [];

  bool get hasImage => images.isNotEmpty;
}
