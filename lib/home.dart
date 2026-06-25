import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/activity_card.dart';
import 'widgets/stat_card.dart';
import 'widgets/pulsing_dot.dart';
import 'widgets/interactive_card.dart';
import 'utils/vehicle_theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String userName = "Alex";
  bool _showNotification = true;
  static final List<Map<String, dynamic>> stats = [
    {
      "title": "Today's Customers",
      "count": "24",
      "icon": Icons.people,
    },
    {
      "title": "Cars in Service",
      "count": "18",
      "icon": Icons.car_repair,
    },
    {
      "title": "Completed Services",
      "count": "12",
      "icon": Icons.check_circle,
    },
    {
      "title": "Pending Deliveries",
      "count": "5",
      "icon": Icons.local_shipping,
    },
  ];

  static final List<Map<String, dynamic>> activities = [
    {
      "customerName": "James W",
      "vehicleName": "Mercedes Benz S-Class",
      "status": "In Progress",
      "statusColor": Colors.blue,
      "time": "10 mins ago",
      "icon": Icons.build_rounded,
    },
    {
      "customerName": "Sarah K",
      "vehicleName": "BMW M4",
      "status": "Scheduled",
      "statusColor": Colors.orange,
      "time": "2 hours ago",
      "icon": Icons.calendar_today_rounded,
    },
    {
      "customerName": "Michael C",
      "vehicleName": "Tesla Model S",
      "status": "Completed",
      "statusColor": Colors.green,
      "time": "5 hours ago",
      "icon": Icons.check_circle_rounded,
    },
  ];

  final ScrollController _mainScrollController = ScrollController();

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90 + MediaQuery.of(context).padding.top),
        child: SafeArea(
          child: AppBar(
            toolbarHeight: 90,
            backgroundColor: Colors.white,
            elevation: 0,
          title: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Good Morning",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$userName !",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat('EEE, MMM d').format(DateTime.now()),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue.shade100,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade500.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue.shade50,
                              child: const Icon(
                                Icons.person_rounded,
                                color: Colors.blue,
                                size: 24,
                              ),
                            ),
                            Positioned(
                              right: 1,
                              bottom: 1,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFF1F5F9),
              Color(0xFFEEF2F6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isWide = width >= 768;
          final isMedium = width >= 600 && width < 768;

          // Determine grid layout based on screen width
          int crossAxisCount = 2;
          double childAspectRatio = 1.5;
          if (isWide) {
            crossAxisCount = 4;
            childAspectRatio = 1.35;
          } else if (isMedium) {
            crossAxisCount = 4;
            childAspectRatio = 1.25;
          }

          final statsGrid = GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemCount: stats.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              return InteractiveCard(
                child: StatCard(
                  title: stats[index]["title"],
                  count: stats[index]["count"],
                  icon: stats[index]["icon"],
                ),
              );
            },
          );

          final recentActivitiesHeader = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Activities",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("View All"),
              ),
            ],
          );

          final Widget activitiesList;
          if (width >= 600 && width < 768) {
            activitiesList = GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              itemCount: activities.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
                childAspectRatio: 1.8,
              ),
              itemBuilder: (context, index) {
                final act = activities[index];
                return InteractiveCard(
                  child: ActivityCard(
                    customerName: act["customerName"],
                    vehicleName: act["vehicleName"],
                    status: act["status"],
                    statusColor: act["statusColor"],
                    time: act["time"],
                    icon: act["icon"],
                  ),
                );
              },
            );
          } else {
            activitiesList = ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final act = activities[index];
                return InteractiveCard(
                  child: ActivityCard(
                    customerName: act["customerName"],
                    vehicleName: act["vehicleName"],
                    status: act["status"],
                    statusColor: act["statusColor"],
                    time: act["time"],
                    icon: act["icon"],
                  ),
                );
              },
            );
          }

          final quickActionsButton = Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                debugPrint("New Customer Entry Clicked");
              },
              icon: const Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
              label: const Text(
                "New Customer Entry",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          );

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: SingleChildScrollView(
                controller: _mainScrollController,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_showNotification) ...[
                        _buildNotificationBanner(),
                        const SizedBox(height: 24),
                      ],
                      if (isWide) ...[
                        statsGrid,
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const WorkshopBays(),
                                  const SizedBox(height: 32),
                                  recentActivitiesHeader,
                                  const SizedBox(height: 16),
                                  activitiesList,
                                ],
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Quick Actions",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  quickActionsButton,
                                  const SizedBox(height: 20),
                                  _buildQuickInfoCard(),
                                ],
                              ),
                            ),
                          ],
                        )
                      ] else ...[
                        statsGrid,
                        const SizedBox(height: 32),
                        const WorkshopBays(),
                        const SizedBox(height: 32),
                        recentActivitiesHeader,
                        const SizedBox(height: 16),
                        activitiesList,
                        const SizedBox(height: 32),
                        quickActionsButton,
                        const SizedBox(height: 20),
                        _buildQuickInfoCard(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

  Widget _buildQuickInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade100.withValues(alpha: 0.8), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade500.withValues(alpha: 0.03),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.info_outline_rounded, color: Colors.blue, size: 16),
              ),
              const SizedBox(width: 10),
              const Text(
                "Workshop Tip",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF0F172A), // Slate 900
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Keep an eye on pending deliveries. Ensure vehicles undergo a final quality check before customer arrival.",
            style: TextStyle(
              color: const Color(0xFF64748B), // Slate 500
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.85),
            Colors.white.withValues(alpha: 0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.7),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.1),
            child: const Icon(
              Icons.notifications_active_rounded,
              color: Color(0xFF3B82F6),
              size: 18,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Alert Notification",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "5 vehicles are ready for final quality check and delivery.",
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B), size: 18),
            onPressed: () {
              setState(() {
                _showNotification = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

class WorkshopBays extends StatefulWidget {
  const WorkshopBays({super.key});

  @override
  State<WorkshopBays> createState() => _WorkshopBaysState();
}

class _WorkshopBaysState extends State<WorkshopBays> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bays = [
      {"name": "Bay 1", "status": "In Service", "vehicle": "Mercedes S-Class", "active": true},
      {"name": "Bay 2", "status": "Diagnostic", "vehicle": "BMW M4", "active": true},
      {"name": "Bay 3", "status": "Available", "vehicle": "Free", "active": false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Workshop Bays",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("View All"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: bays.map((bay) {
                  final isActive = bay["active"] as bool;
                  final vehicle = bay["vehicle"] as String;
                  
                  final BoxDecoration cardDecoration;
                  final Color textColor;
                  final Color subtitleColor;
                  final IconData iconData;
                  final Color iconColor;
                  final Color iconBgColor;
                  final Color badgeBgColor;
                  final Color badgeTextColor;
                  final String badgeText;

                  if (isActive) {
                    final vTheme = VehicleTheme.getThemeForVehicle(vehicle);
                    cardDecoration = BoxDecoration(
                      gradient: LinearGradient(
                        colors: vTheme.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: vTheme.shadowColor,
                          blurRadius: 16,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.6),
                        width: 1.5,
                      ),
                    );
                    textColor = vTheme.textColor;
                    subtitleColor = vTheme.subtitleColor;
                    iconData = vTheme.logoIcon;
                    iconColor = vTheme.accentColor;
                    iconBgColor = vTheme.accentColor.withValues(alpha: 0.1);
                    badgeBgColor = vTheme.accentColor.withValues(alpha: 0.1);
                    badgeTextColor = vTheme.accentColor;
                    badgeText = "Occupied";
                  } else {
                    cardDecoration = BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    );
                    textColor = const Color(0xFF0F172A);
                    subtitleColor = Colors.grey.shade400;
                    iconData = Icons.add_circle_outline_rounded;
                    iconColor = Colors.grey;
                    iconBgColor = Colors.grey.shade100;
                    badgeBgColor = Colors.grey.shade100;
                    badgeTextColor = Colors.grey;
                    badgeText = "Free";
                  }

                  return InteractiveCard(
                    child: Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: cardDecoration,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: iconBgColor,
                            child: Icon(
                              iconData,
                              color: iconColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  bay["name"] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isActive
                                      ? "${bay["vehicle"]} • ${bay["status"]}"
                                      : "Available for booking",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: subtitleColor,
                                    fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: badgeBgColor,
                              borderRadius: BorderRadius.circular(12),
                              border: isActive 
                                  ? Border.all(color: badgeTextColor.withValues(alpha: 0.15), width: 1)
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isActive) ...[
                                  PulsingDot(color: badgeTextColor, size: 6),
                                  const SizedBox(width: 6),
                                ],
                                Text(
                                  badgeText,
                                  style: TextStyle(
                                    color: badgeTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
