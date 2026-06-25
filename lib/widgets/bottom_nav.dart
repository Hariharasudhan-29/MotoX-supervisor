import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex ;
  final Function(int) onTap ;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
});



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: onTap,

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Customers"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: "Services"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
        ),
      ],
    );
  }
}
