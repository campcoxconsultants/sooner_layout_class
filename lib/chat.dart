import 'dart:io';

class Chat {
  Chat({
    required this.fromName,
    required this.toName,
    required this.time,
    required this.text,
    this.image,
  });

  final String fromName;

  final String toName;

  final String time;

  final String text;
  // TODO: make this final (copy with)
  File? image;

  bool get hasImage => image != null;
}
