import 'package:flutter/material.dart';

class IconBar extends StatelessWidget {
  const IconBar({
    super.key,
    required this.onIconTap,
  });

  final void Function(String icon) onIconTap;

  static const List<String> _icons = [
    '🙂',
    '😃',
    '😍',
    '😂',
    '😭',
    '😠',
    '😡',
    '😜',
    '😘',
    '😉',
    '🤔',
    '🤗',
    '😷',
    '🤢',
    '🤮',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          for (final icon in _icons)
            GestureDetector(
              onTap: () => onIconTap(icon),
              child: Text(
                icon,
                style: const TextStyle(fontSize: 24),
              ),
            ),
        ],
      ),
    );
  }
}
