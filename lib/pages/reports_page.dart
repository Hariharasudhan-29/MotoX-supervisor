import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../main.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Workshop Analytics",
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mini dashboard summarizing workshop output and customer satisfaction metrics.",
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onBackground.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            
            // Premium Analytics Preview Card
            GlassPanel(
              surfaceColor: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
              borderColor: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Monthly KPI Target",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "June 2026",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: MediaQuery.of(context).size.width < 500 ? 2 : 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85,
                          children: [
                            _buildCircularChart(
                              label: "Total Vehicles",
                              value: "150",
                              percentage: 0.85,
                              color: Colors.blue,
                              animationVal: _progressAnimation.value,
                            ),
                            _buildCircularChart(
                              label: "Pending",
                              value: "12",
                              percentage: 0.12,
                              color: Colors.orange,
                              animationVal: _progressAnimation.value,
                            ),
                            _buildCircularChart(
                              label: "Completed",
                              value: "138",
                              percentage: 0.92,
                              color: Colors.green,
                              animationVal: _progressAnimation.value,
                            ),
                            _buildCircularChart(
                              label: "Satisfaction",
                              value: "98%",
                              percentage: 0.98,
                              color: Colors.purple,
                              animationVal: _progressAnimation.value,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Recent Operations Summary",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildReportListTile(
              title: "Daily Job Card Output Report",
              subtitle: "Generated 3 hours ago • 14 Job Cards processed",
              icon: Icons.assignment_turned_in_outlined,
              color: Colors.green,
              theme: theme,
              isDark: isDark,
            ),
            _buildReportListTile(
              title: "Parts Requisition and Expenses",
              subtitle: "Generated yesterday • Total spend \$4,250",
              icon: Icons.monetization_on_outlined,
              color: Colors.blue,
              theme: theme,
              isDark: isDark,
            ),
            _buildReportListTile(
              title: "Technician Turnaround Analysis",
              subtitle: "Generated 2 days ago • Avg check-in: 34 mins",
              icon: Icons.query_stats_outlined,
              color: Colors.purple,
              theme: theme,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularChart({
    required String label,
    required String value,
    required double percentage,
    required Color color,
    required double animationVal,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: percentage * animationVal,
                  strokeWidth: 7,
                  backgroundColor: color.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildReportListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.grey.shade100,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.colorScheme.onBackground.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: theme.colorScheme.onBackground.withValues(alpha: 0.3),
            size: 20,
          ),
        ],
      ),
    );
  }
}
