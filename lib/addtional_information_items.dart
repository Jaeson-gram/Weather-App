import 'package:flutter/material.dart';

class AdditionalInformationItems extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInformationItems(
      {super.key,
      required this.icon,
      required this.label,
      required this.value
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
