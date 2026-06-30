import 'package:flutter/material.dart';
import '../widgets/interactive_card.dart';
import '../main.dart';
import '../job_card_model.dart';
import '../utils/vehicle_theme.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final catalogServices = [
      {
        "name": "Periodic Service Package",
        "description": "Engine oil change, filter replacement, fluid check, and 50-point inspection.",
        "duration": "2 - 3 Hours",
        "price": "₹4,999 onwards",
        "icon": Icons.build_circle_outlined,
        "color": Colors.blue,
      },
      {
        "name": "Ceramic Coating & Detailing",
        "description": "9H hardness ceramic coating, exterior polish, interior deep clean, and leather treatment.",
        "duration": "1 - 2 Days",
        "price": "₹15,000 onwards",
        "icon": Icons.auto_awesome_outlined,
        "color": Colors.amber,
      },
      {
        "name": "Wheel Alignment & Balancing",
        "description": "Precision laser alignment, computer balancing, and tyre tread safety check.",
        "duration": "1 Hour",
        "price": "₹1,200 onwards",
        "icon": Icons.donut_large_rounded,
        "color": Colors.teal,
      },
      {
        "name": "Engine Diagnostics & ECU Tuning",
        "description": "Full electronic systems scan, fault code clearance, and fuel efficiency tuning.",
        "duration": "2 Hours",
        "price": "₹3,500 onwards",
        "icon": Icons.settings_input_component_outlined,
        "color": Colors.red,
      }
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          title: Text(
            "Services & Workshop",
            style: TextStyle(
              color: theme.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          bottom: TabBar(
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.onBackground.withOpacity(0.6),
            indicatorColor: theme.colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: "Service Catalog"),
              Tab(text: "Active Vehicle Services"),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
        ),
        body: TabBarView(
          children: [
            // Tab 1: Service Catalog
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select from our curated list of elite workshop treatments.",
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onBackground.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: catalogServices.length,
                      itemBuilder: (context, index) {
                        final service = catalogServices[index];
                        final iconColor = service["color"] as Color;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: InteractiveCard(
                            child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white.withOpacity(0.04) : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade100,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: iconColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    service["icon"] as IconData,
                                    color: iconColor,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service["name"] as String,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        service["description"] as String,
                                        style: TextStyle(
                                          fontSize: 13,
                                          height: 1.4,
                                          color: theme.colorScheme.onBackground.withOpacity(0.6),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time_rounded, size: 14, color: theme.colorScheme.onBackground.withOpacity(0.4)),
                                          const SizedBox(width: 4),
                                          Text(
                                            service["duration"] as String,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: theme.colorScheme.onBackground.withOpacity(0.5),
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                          Icon(Icons.payments_outlined, size: 14, color: theme.colorScheme.onBackground.withOpacity(0.4)),
                                          const SizedBox(width: 4),
                                          Text(
                                            service["price"] as String,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    ),
                  ),
                ],
              ),
            ),

            // Tab 2: Active Vehicle Services
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ValueListenableBuilder<List<JobCardModel>>(
                valueListenable: jobCardsNotifier,
                builder: (context, newCards, child) {
                  if (newCards.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_car_outlined,
                            size: 64,
                            color: theme.colorScheme.onBackground.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No Active Vehicle Services",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onBackground.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Create a new job card to see it here.",
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.colorScheme.onBackground.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: newCards.length,
                    itemBuilder: (context, index) {
                      final card = newCards[index];
                      final vehicleName = "${card.make} ${card.model}";
                      final vTheme = VehicleTheme.getThemeForVehicle(vehicleName);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InteractiveCard(
                          child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: vTheme.gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.6),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: vTheme.shadowColor,
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: vTheme.accentColor.withOpacity(0.1),
                                child: Icon(
                                  vTheme.logoIcon,
                                  color: vTheme.accentColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          vehicleName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: vTheme.textColor,
                                          ),
                                        ),
                                        Text(
                                          card.jcNumber,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: vTheme.accentColor,
                                            fontFamily: 'JetBrains Mono',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Registration: ${card.regNumber}  •  Odometer: ${card.odo} KM",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: vTheme.subtitleColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.person_outline, size: 13, color: vTheme.subtitleColor.withOpacity(0.7)),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Advisor: ${card.saName}",
                                          style: TextStyle(fontSize: 11, color: vTheme.subtitleColor),
                                        ),
                                        const SizedBox(width: 16),
                                        Icon(Icons.engineering_outlined, size: 13, color: vTheme.subtitleColor.withOpacity(0.7)),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Tech: ${card.techName}",
                                          style: TextStyle(fontSize: 11, color: vTheme.subtitleColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: 4,
                                      children: card.serviceTypes.map((st) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: vTheme.accentColor.withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: vTheme.accentColor.withOpacity(0.15),
                                            ),
                                          ),
                                          child: Text(
                                            st,
                                            style: TextStyle(
                                              color: vTheme.accentColor,
                                              fontSize: 9.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
