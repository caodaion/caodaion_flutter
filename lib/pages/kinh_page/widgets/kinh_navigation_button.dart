import 'package:flutter/material.dart';

class KinhNavigationButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final IconData icon;
  final String iconLocation;

  const KinhNavigationButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.icon,
    this.iconLocation = "start",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconLocation == 'start' ? 24 : 0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            SizedBox(
                width: iconLocation == 'start'
                    ? 8
                    : 0), // Adjust spacing between icon and text
            Expanded(
              child: Text(
                buttonText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: iconLocation == 'end' ? 8 : 0),
            Icon(
              icon,
              size: iconLocation == 'end' ? 24 : 0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }
}
