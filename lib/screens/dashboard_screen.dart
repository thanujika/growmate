import 'package:flutter/material.dart';
import '../models/reminder.dart';
import 'add_reminder_screen.dart';
import 'edit_reminder_screen.dart';
import 'calendar_screen.dart';
import 'notification_settings_screen.dart';
import '../widgets/reminder_card.dart';
import '../widgets/stats_card.dart';
import '../services/notification_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CropType? selectedCrop;
  final NotificationService _notificationService = NotificationService();
  List<Reminder> reminders = [
    Reminder(
      id: '1',
      fieldName: 'North Paddy Field',
      cropType: CropType.paddy,
      reminderType: ReminderType.irrigation,
      dateTime: DateTime.now().add(const Duration(hours: 2)),
      notes: 'Morning irrigation for paddy field',
    ),
    Reminder(
      id: '2',
      fieldName: 'Corn Field A',
      cropType: CropType.corn,
      reminderType: ReminderType.fertilizing,
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      notes: 'Apply NPK fertilizer',
      isCompleted: true,
    ),
    Reminder(
      id: '3',
      fieldName: 'South Paddy Field',
      cropType: CropType.paddy,
      reminderType: ReminderType.harvesting,
      dateTime: DateTime.now().add(const Duration(days: 3)),
      notes: 'Harvest mature paddy',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scheduleAllNotifications();
  }

  void _scheduleAllNotifications() {
    for (final reminder in reminders) {
      if (!reminder.isCompleted && reminder.dateTime.isAfter(DateTime.now())) {
        _notificationService.scheduleReminderNotification(reminder);
      }
    }
  }

  void _scheduleNotification(Reminder reminder) {
    if (!reminder.isCompleted && reminder.dateTime.isAfter(DateTime.now())) {
      _notificationService.scheduleReminderNotification(reminder);
    }
  }

  void _cancelNotification(Reminder reminder) {
    final id = int.tryParse(reminder.id);
    if (id != null) {
      _notificationService.cancelNotification(id);
    }
  }

  int get todayCount => reminders
      .where((r) => r.formattedDate == 'Today' && !r.isCompleted)
      .length;

  int get overdueCount => reminders
      .where((r) => r.dateTime.isBefore(DateTime.now()) && !r.isCompleted)
      .length;

  int get upcomingCount => reminders
      .where((r) => r.dateTime.isAfter(DateTime.now()) && !r.isCompleted)
      .length;

  int get completedCount => reminders.where((r) => r.isCompleted).length;

  List<Reminder> get filteredReminders {
    if (selectedCrop == null) {
      return reminders;
    }
    return reminders.where((r) => r.cropType == selectedCrop).toList();
  }

  void _editReminder(Reminder reminder) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReminderScreen(
          initialReminder: reminder,
          onSave: (updatedReminder) {
            _cancelNotification(reminder);
            
            final index = reminders.indexWhere((r) => r.id == updatedReminder.id);
            if (index != -1) {
              setState(() {
                reminders[index] = updatedReminder;
              });
              
              _scheduleNotification(updatedReminder);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Reminder updated successfully!'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GrowMate',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Crop Reminder System',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationSettingsScreen(),
                            ),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.notifications,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CalendarScreen(reminders: reminders),
                            ),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stats Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  StatsCard(
                    count: todayCount,
                    label: 'Today',
                    color: Colors.blue,
                    icon: Icons.today,
                  ),
                  StatsCard(
                    count: overdueCount,
                    label: 'Overdue',
                    color: Colors.red,
                    icon: Icons.warning,
                  ),
                  StatsCard(
                    count: upcomingCount,
                    label: 'Upcoming',
                    color: Colors.orange,
                    icon: Icons.upcoming,
                  ),
                  StatsCard(
                    count: completedCount,
                    label: 'Completed',
                    color: Colors.green,
                    icon: Icons.check_circle,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Filter Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter by Crop',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildFilterChip('All Crops', null),
                      const SizedBox(width: 8),
                      _buildFilterChip('Paddy', CropType.paddy),
                      const SizedBox(width: 8),
                      _buildFilterChip('Corn', CropType.corn),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Reminders List
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Reminders',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${filteredReminders.length} tasks',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: filteredReminders.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.notifications_off,
                                      size: 64,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No reminders found',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tap + to add your first reminder',
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.separated(
                                itemCount: filteredReminders.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final reminder = filteredReminders[index];
                                  return ReminderCard(
                                    reminder: reminder,
                                    onTap: () =>
                                        _showReminderOptions(context, reminder),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddReminderScreen(),
            ),
          );
          if (result != null && result is Reminder) {
            setState(() {
              reminders.add(result);
            });
            _scheduleNotification(result);
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Reminder added successfully!'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add Reminder'),
      ),
    );
  }

  Widget _buildFilterChip(String label, CropType? cropType) {
    final isSelected = selectedCrop == cropType;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedCrop = selected ? cropType : null;
        });
      },
      selectedColor: const Color(0xFF4CAF50),
      backgroundColor: Colors.grey.shade100,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  void _showReminderOptions(BuildContext context, Reminder reminder) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Reminder Options',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _buildOptionTile(
                Icons.check_circle,
                'Mark as Completed',
                Colors.green,
                () {
                  setState(() {
                    reminder.isCompleted = true;
                  });
                  _cancelNotification(reminder);
                  Navigator.pop(context);
                  _showSnackbar(context, 'Marked as completed');
                },
              ),
              _buildOptionTile(
                Icons.snooze,
                'Snooze 1 hour',
                Colors.orange,
                () {
                  setState(() {
                    reminder.dateTime =
                        reminder.dateTime.add(const Duration(hours: 1));
                  });
                  _cancelNotification(reminder);
                  _scheduleNotification(reminder);
                  Navigator.pop(context);
                  _showSnackbar(context, 'Snoozed for 1 hour');
                },
              ),
              _buildOptionTile(
                Icons.edit,
                'Edit Reminder',
                Colors.blue,
                () {
                  Navigator.pop(context);
                  _editReminder(reminder);
                },
              ),
              _buildOptionTile(
                Icons.delete,
                'Delete Reminder',
                Colors.red,
                () {
                  setState(() {
                    reminders.remove(reminder);
                  });
                  _cancelNotification(reminder);
                  Navigator.pop(context);
                  _showSnackbar(context, 'Reminder deleted');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionTile(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}