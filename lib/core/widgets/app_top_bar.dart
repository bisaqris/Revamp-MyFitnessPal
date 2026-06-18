import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../features/home/notification_screen.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  static const List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.bedtime, 'label': 'Sleep'},
    {'icon': Icons.receipt_long, 'label': 'Recipes'},
    {'icon': Icons.fitness_center, 'label': 'Workouts'},
    {'icon': Icons.flag, 'label': 'Goals'},
    {'icon': Icons.school, 'label': 'Learn'},
    {'icon': Icons.groups, 'label': 'community'},
    {'icon': Icons.group, 'label': 'Friends'},
    {'icon': Icons.settings, 'label': 'Setting'},
  ];

  void _openNotification(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationScreen()),
    );
  }

  void _openMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final Offset topRight = button.localToGlobal(
      Offset(button.size.width, button.size.height),
      ancestor: overlay,
    );

    showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (_) => Stack(
        children: [
          Positioned(
            top: topRight.dy + 4,
            right: 20,
            child: _MenuDropdown(items: _menuItems),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        children: [
          // Logo avatar
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Spacer(),
          // Notification bell
          GestureDetector(
            onTap: () => _openNotification(context),
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.background,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Menu button
          Builder(
            builder: (menuContext) => GestureDetector(
              onTap: () => _openMenu(menuContext),
              child: const Icon(Icons.menu, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuDropdown extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const _MenuDropdown({required this.items});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isFirst = index == 0;
            final isLast = index == items.length - 1;
            return Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.vertical(
                    top: isFirst ? const Radius.circular(16) : Radius.zero,
                    bottom: isLast ? const Radius.circular(16) : Radius.zero,
                  ),
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item['label'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLast) const Divider(height: 1, color: AppColors.border),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
