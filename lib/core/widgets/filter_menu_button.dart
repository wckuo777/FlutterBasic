import 'package:flutter/material.dart';

/// PopupMenuButton
class FilterMenuButton extends StatelessWidget {
  final String currentValue; // 當前選擇
  final List<String> options; // 所有選項
  final ValueChanged<String> onSelected; // 點選回調

  const FilterMenuButton({
    super.key,
    required this.currentValue,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list),
      onSelected: onSelected,
      itemBuilder: (context) {
        return options.map((option) {
          return PopupMenuItem<String>(
            value: option,
            child: Row(
              children: [
                if (option == currentValue)
                  const Icon(Icons.check, size: 16)
                else
                  const SizedBox(width: 16),
                const SizedBox(width: 8),
                Text(option),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
