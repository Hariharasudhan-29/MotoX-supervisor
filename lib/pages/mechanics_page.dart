import 'package:flutter/material.dart';
import '../widgets/interactive_card.dart';
import '../widgets/pulsing_dot.dart';

class MechanicsPage extends StatefulWidget {
  const MechanicsPage({super.key});

  @override
  State<MechanicsPage> createState() => _MechanicsPageState();
}

class _MechanicsPageState extends State<MechanicsPage> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> mechanics = [
      {
        "name": "Dave Miller",
        "specialization": "EV & Hybrid Powertrains",
        "rating": "4.95",
        "status": "Busy",
        "statusColor": Colors.orange,
        "avatarChar": "D",
        "activeBay": "Bay 1",
        "activeVehicle": "Mercedes S-Class",
      },
      {
        "name": "John Doe",
        "specialization": "Engine Diagnostics & ECU Tuning",
        "rating": "4.88",
        "status": "Busy",
        "statusColor": Colors.orange,
        "avatarChar": "J",
        "activeBay": "Bay 2",
        "activeVehicle": "BMW M4 Coupe",
      },
      {
        "name": "Sarah Connor",
        "specialization": "Suspension & Laser Alignment",
        "rating": "4.92",
        "status": "Available",
        "statusColor": Colors.green,
        "avatarChar": "S",
        "activeBay": "Bay 3 (Free)",
        "activeVehicle": "None",
      },
      {
        "name": "Marcus Aurelius",
        "specialization": "Premium Ceramic Paint & Detail",
        "rating": "4.97",
        "status": "Offline",
        "statusColor": Colors.grey,
        "avatarChar": "M",
        "activeBay": "Detailing Bay (Offline)",
        "activeVehicle": "None",
      }
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Workshop Mechanics",
              style: TextStyle(
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Track active advisor/technician workloads and real-time bay utilization. Tap a mechanic to view their specialization.",
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onBackground.withValues(alpha: 0.6),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: mechanics.length,
                itemBuilder: (context, index) {
                  final mech = mechanics[index];
                  final isBusy = mech["status"] == "Busy";
                  final isAvailable = mech["status"] == "Available";
                  final accentColor = mech["statusColor"] as Color;
                  final isExpanded = _expandedIndex == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InteractiveCard(
                      onTap: () {
                        setState(() {
                          _expandedIndex = isExpanded ? null : index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade100,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: accentColor.withValues(alpha: 0.1),
                              child: Text(
                                mech["avatarChar"]!,
                                style: TextStyle(
                                  color: accentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
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
                                          mech["name"]!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.onBackground,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        mech["rating"]!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons.keyboard_arrow_down_rounded,
                                        size: 20,
                                        color: theme.colorScheme.onBackground.withValues(alpha: 0.4),
                                      ),
                                    ],
                                  ),
                                  
                                  // Expandable Specialization Dropdown
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                    child: isExpanded
                                        ? Padding(
                                            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.workspace_premium_rounded,
                                                  size: 14,
                                                  color: accentColor.withValues(alpha: 0.7),
                                                ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    mech["specialization"]!,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: theme.colorScheme.onBackground.withValues(alpha: 0.7),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                  
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 14,
                                        color: theme.colorScheme.onBackground.withValues(alpha: 0.4),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Bay: ${mech["activeBay"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: theme.colorScheme.onBackground.withValues(alpha: 0.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isBusy) ...[
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.engineering_outlined,
                                          size: 14,
                                          color: theme.colorScheme.onBackground.withValues(alpha: 0.4),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Vehicle: ${mech["activeVehicle"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: theme.colorScheme.onBackground.withValues(alpha: 0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isAvailable || isBusy) ...[
                                    PulsingDot(color: accentColor, size: 6),
                                    const SizedBox(width: 6),
                                  ],
                                  Text(
                                    mech["status"]!,
                                    style: TextStyle(
                                      color: accentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
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
    );
  }
}
