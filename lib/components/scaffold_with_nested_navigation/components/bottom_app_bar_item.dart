import 'package:flutter/material.dart';

class BottomAppBarItem extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final String label;
  final String route;
  final bool isActive;

  const BottomAppBarItem({
    super.key,
    required this.onPressed,
    required this.label,
    required this.iconData,
    required this.route,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor:
            isActive ? Theme.of(context).primaryColor : const Color(0xff5F6368),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData),
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
