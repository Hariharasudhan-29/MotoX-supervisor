import 'package:flutter/material.dart';
import 'package:moto_x/home.dart';
import 'package:moto_x/pages/customer_page.dart';
import 'package:moto_x/pages/services_page.dart';
import 'package:moto_x/pages/profile_page.dart';
import 'package:moto_x/widgets/bottom_nav.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const Home(),
    const CustomerPage(),
    const ServicesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;
        final isExtended = constraints.maxWidth >= 900;

        return Scaffold(
          body: Row(
            children: [
              if (isWide)
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: NavigationRail(
                    selectedIndex: selectedIndex,
                    extended: isExtended,
                    backgroundColor: Colors.white,
                    selectedIconTheme: const IconThemeData(color: Colors.blue),
                    selectedLabelTextStyle: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedIconTheme: const IconThemeData(color: Colors.grey),
                    unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
                    onDestinationSelected: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    leading: isExtended
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.blue.shade100,
                                  child: const Icon(Icons.directions_car, color: Colors.blue, size: 20),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "MotoX",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.blue.shade100,
                              child: const Icon(Icons.directions_car, color: Colors.blue, size: 20),
                            ),
                          ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: Text("Home"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.people_outline),
                        selectedIcon: Icon(Icons.people),
                        label: Text("Customers"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.build_outlined),
                        selectedIcon: Icon(Icons.build),
                        label: Text("Services"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: Text("Profile"),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: pages,
                ),
              ),
            ],
          ),
          bottomNavigationBar: isWide
              ? null
              : BottomNav(
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
        );
      },
    );
  }
}
