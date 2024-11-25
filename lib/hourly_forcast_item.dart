import 'package:flutter/material.dart';

class HourlyForcastItem extends StatelessWidget {
  final String timeOfDay;
  final IconData icon;
  final String value;

  const HourlyForcastItem(
      {super.key,
      required this.timeOfDay,
      required this.icon,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          elevation: 20,
          child: Container(
            width: 120,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  timeOfDay,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    icon,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
