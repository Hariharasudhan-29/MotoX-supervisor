import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../home.dart';
import 'profile_page.dart';
import 'mechanics_page.dart';
import 'customer_page.dart';
import '../dashboard_page.dart';
import '../widgets/bottom_nav.dart';
import '../main.dart'; // Import to use navigationIndexNotifier and isDarkModeNotifier

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> pages = [
    const Home(),
    const JobCardDashboardPage(),
    const MechanicsPage(),
    const CustomerPage(),
    const ProfilePage(),
  ];

  bool _showBottomNav = true;

  @override
  void initState() {
    super.initState();
    navigationIndexNotifier.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    navigationIndexNotifier.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    if (!_showBottomNav) {
      setState(() {
        _showBottomNav = true;
      });
    }
  }

  Widget _buildGlobalTopBar(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final surfaceColor = isDark
        ? Colors.white.withValues(alpha: 0.04)
        : Colors.white.withValues(alpha: 0.75);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.08);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF22D3EE)],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.verified_user,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MOTO-X',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'SERVICE MANAGEMENT',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onBackground.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                isDarkModeNotifier.value = !isDarkModeNotifier.value;
              },
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: theme.colorScheme.onBackground,
              ),
              style: IconButton.styleFrom(
                backgroundColor: surfaceColor,
                side: BorderSide(color: borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ValueListenableBuilder<int>(
      valueListenable: navigationIndexNotifier,
      builder: (context, selectedIndex, child) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is UserScrollNotification) {
              if (notification.direction == ScrollDirection.reverse) {
                // Scrolling down (User swiped up) -> Hide nav bar
                if (_showBottomNav) {
                  setState(() {
                    _showBottomNav = false;
                  });
                }
              } else if (notification.direction == ScrollDirection.forward) {
                // Scrolling up (User swiped down) -> Show nav bar
                if (!_showBottomNav) {
                  setState(() {
                    _showBottomNav = true;
                  });
                }
              }
            }
            return false; // Let notification bubble
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 600;
              final isExtended = constraints.maxWidth >= 900;

              return Scaffold(
                extendBody: true, // Allows content to show behind floating glass bottom nav
                body: Row(
                  children: [
                    if (isWide)
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                        ),
                        child: NavigationRail(
                          selectedIndex: selectedIndex,
                          extended: isExtended,
                          backgroundColor: isDark ? const Color(0xFF161622) : Colors.white,
                          selectedIconTheme: const IconThemeData(color: Color(0xFF6366F1)),
                          selectedLabelTextStyle: const TextStyle(
                            color: Color(0xFF6366F1),
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedIconTheme: IconThemeData(color: isDark ? Colors.white38 : Colors.grey),
                          unselectedLabelTextStyle: TextStyle(color: isDark ? Colors.white38 : Colors.grey),
                          onDestinationSelected: (index) {
                            navigationIndexNotifier.value = index;
                          },
                          leading: isExtended
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.1),
                                        child: const Icon(Icons.directions_car, color: Color(0xFF6366F1), size: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        "MotoX",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6366F1),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.1),
                                    child: const Icon(Icons.directions_car, color: Color(0xFF6366F1), size: 20),
                                  ),
                                ),
                          destinations: const [
                            NavigationRailDestination(
                              icon: Icon(Icons.home_outlined),
                              selectedIcon: Icon(Icons.home_rounded),
                              label: Text("Home"),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.assignment_outlined),
                              selectedIcon: Icon(Icons.assignment_rounded),
                              label: Text("Job Cards"),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.engineering_outlined),
                              selectedIcon: Icon(Icons.engineering_rounded),
                              label: Text("Mechanics"),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.people_outline),
                              selectedIcon: Icon(Icons.people_rounded),
                              label: Text("Customers"),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.person_outline),
                              selectedIcon: Icon(Icons.person_rounded),
                              label: Text("Profile"),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Column(
                        children: [
                          _buildGlobalTopBar(context, isDark),
                          Expanded(
                            child: IndexedStack(
                              index: selectedIndex,
                              children: pages,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: isWide
                    ? null
                    : AnimatedSlide(
                        offset: _showBottomNav ? Offset.zero : const Offset(0, 1.5),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                        child: BottomNav(
                          currentIndex: selectedIndex,
                          onTap: (index) {
                            navigationIndexNotifier.value = index;
                          },
                        ),
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
