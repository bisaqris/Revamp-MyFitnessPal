import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_bottom_nav.dart';
import '../home/home_screen.dart';
import '../activity/activity_screen.dart';
import 'under_construction_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  // Each tab has its own navigator — preserves stack per tab, no reload.
  final List<GlobalKey<NavigatorState>> _navKeys = [
    GlobalKey<NavigatorState>(), // 0 — Home
    GlobalKey<NavigatorState>(), // 1 — Activity
    GlobalKey<NavigatorState>(), // 2 — FAB (unused slot)
    GlobalKey<NavigatorState>(), // 3 — Progress
    GlobalKey<NavigatorState>(), // 4 — Profile
  ];

  void _onTabTap(int index) {
    if (index == 2) {
      _showAddBottomSheet();
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _showAddBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _buildAddBottomSheet(),
    );
  }

  Widget _buildAddBottomSheet() {
    final items = [
      {'icon': Icons.content_paste, 'label': 'Log Food'},
      {'icon': Icons.fitness_center, 'label': 'Excercise'},
      {'icon': Icons.monitor_weight, 'label': 'Weight'},
      {'icon': Icons.water_drop, 'label': 'Water'},
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.3,
            children: items.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  if (item['label'] == 'Excercise') {
                    _navKeys[_currentIndex].currentState?.push(
                      MaterialPageRoute(
                        builder: (_) => const ActivityScreen(),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: AppColors.primary,
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['label'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final nav = _navKeys[_currentIndex].currentState;
        if (nav != null && nav.canPop()) {
          // Pop within the current tab's navigator.
          nav.pop();
        } else if (_currentIndex != 0) {
          // If at the root of a non-home tab, switch back to Home.
          setState(() => _currentIndex = 0);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildTab(0, const HomeScreen()),
            _buildTab(1, const UnderConstructionScreen()),
            const SizedBox.shrink(), // 2 — FAB slot
            _buildTab(3, const UnderConstructionScreen()),
            _buildTab(4, const UnderConstructionScreen()),
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: _currentIndex,
          onTap: _onTabTap,
          onFabTap: _showAddBottomSheet,
        ),
      ),
    );
  }

  Widget _buildTab(int index, Widget rootScreen) {
    return Navigator(
      key: _navKeys[index],
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (_) => rootScreen,
      ),
    );
  }
}
