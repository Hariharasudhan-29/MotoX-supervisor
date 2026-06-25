import 'package:flutter/material.dart';
import '../utils/vehicle_theme.dart';

class ActivityCard extends StatelessWidget {
  final String customerName;
  final String vehicleName;
  final String status;
  final Color statusColor;
  final String time;
  final IconData icon;

  const ActivityCard({
    super.key,
    required this.customerName,
    required this.vehicleName,
    required this.status,
    required this.statusColor,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final vTheme = VehicleTheme.getThemeForVehicle(vehicleName);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
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
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: vTheme.accentColor.withValues(alpha: 0.1),
            child: Icon(
              vTheme.logoIcon,
              color: vTheme.accentColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  vehicleName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: vTheme.textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  runSpacing: 2,
                  children: [
                    Text(
                      customerName,
                      style: TextStyle(
                        color: vTheme.subtitleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "•",
                      style: TextStyle(
                        color: vTheme.subtitleColor.withValues(alpha: 0.5),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: vTheme.subtitleColor.withValues(alpha: 0.8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                _buildProgressIndicator(vTheme),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: vTheme.accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: vTheme.accentColor.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: vTheme.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(VehicleTheme vTheme) {
    final isTesla = vTheme.brandName == 'Tesla';
    final isMercedes = vTheme.brandName == 'Mercedes-Benz';
    final isBmw = vTheme.brandName == 'BMW';

    if (isTesla) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4,
            children: [
              Icon(Icons.battery_charging_full_rounded, color: vTheme.accentColor, size: 11),
              Text(
                "85% Charged",
                style: TextStyle(
                  color: vTheme.accentColor,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: 0.85,
              backgroundColor: vTheme.accentColor.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(vTheme.accentColor),
              minHeight: 3,
            ),
          ),
        ],
      );
    } else if (isMercedes || isBmw) {
      final double progress = isMercedes ? 0.67 : 0.33;
      final String progressText = isMercedes ? "2/3 tasks done" : "1/3 tasks done";
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4,
            children: [
              Icon(Icons.playlist_add_check_circle_rounded, color: vTheme.accentColor, size: 11),
              Text(
                progressText,
                style: TextStyle(
                  color: vTheme.accentColor,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: vTheme.accentColor.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(vTheme.accentColor),
              minHeight: 3,
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}