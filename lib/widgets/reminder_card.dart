import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onTap;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onTap,
  });

  Color _getReminderColor(ReminderType type) {
    switch (type) {
      case ReminderType.sowing:
        return Colors.blue.shade100;
      case ReminderType.irrigation:
        return Colors.blue.shade50;
      case ReminderType.fertilizing:
        return Colors.orange.shade100;
      case ReminderType.harvesting:
        return Colors.green.shade100;
    }
  }

  Color _getCropColor(CropType type) {
    switch (type) {
      case CropType.paddy:
        return Colors.blue;
      case CropType.corn:
        return Colors.orange;
    }
  }

  IconData _getReminderIcon(ReminderType type) {
    switch (type) {
      case ReminderType.sowing:
        return Icons.agriculture;
      case ReminderType.irrigation:
        return Icons.water_drop;
      case ReminderType.fertilizing:
        return Icons.eco;
      case ReminderType.harvesting:
        return Icons.grass;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getReminderColor(reminder.reminderType);
    final cropColor = _getCropColor(reminder.cropType);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getReminderIcon(reminder.reminderType),
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          reminder.reminderTypeString,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: cropColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          reminder.cropTypeString,
                          style: TextStyle(
                            fontSize: 12,
                            color: cropColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reminder.fieldName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${reminder.formattedDate} • ${reminder.formattedTime}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const Spacer(),
                      if (reminder.isCompleted)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}