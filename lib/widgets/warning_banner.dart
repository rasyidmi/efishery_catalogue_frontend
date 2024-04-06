import 'package:flutter/material.dart';

class WarningBanner extends StatelessWidget {
  final Widget child;
  const WarningBanner({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        children: [
          const SizedBox(width: 2),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
              color: Colors.yellow,
              child: Row(
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Flexible(child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
