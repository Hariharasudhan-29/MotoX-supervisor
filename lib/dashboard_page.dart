import 'dart:convert';
import 'package:flutter/material.dart';
import 'job_card_model.dart';
import 'main.dart'; // To reuse GlassPanel, AmbientOrbs, and SummaryChip

// Conditional import for cross-platform exporting
import 'export_helper_stub.dart'
    if (dart.library.html) 'export_helper_web.dart' as exporter;

class JobCardDashboardPage extends StatelessWidget {
  final bool? isDarkMode;
  final VoidCallback? onToggleTheme;
  final List<JobCardModel>? jobCards;
  final VoidCallback? onCreateNew;

  const JobCardDashboardPage({
    super.key,
    this.isDarkMode,
    this.onToggleTheme,
    this.jobCards,
    this.onCreateNew,
  });

  void _exportJobCard(JobCardModel card) {
    exporter.exportJobCardPdf(card.toJson());
  }

  void _showDetailsDialog(BuildContext context, JobCardModel card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final isMobile = MediaQuery.of(context).size.width < 600;

        final customerColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('CUSTOMER', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
            const SizedBox(height: 6),
            _buildDetailRow('Name', card.custName),
            _buildDetailRow('Mobile', '+91 ${card.custPhone}'),
            _buildDetailRow('Email', card.custEmail.isEmpty ? '—' : card.custEmail),
            _buildDetailRow('Address', card.custAddress.isEmpty ? '—' : card.custAddress),
            _buildDetailRow('Advisor', card.saName),
            _buildDetailRow('Technician', card.techName),
          ],
        );

        final vehicleColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('VEHICLE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
            const SizedBox(height: 6),
            _buildDetailRow('Reg No.', card.regNumber),
            _buildDetailRow('Model', '${card.make} ${card.model}'),
            _buildDetailRow('Year/Color', '${card.year} • ${card.color}'),
            _buildDetailRow('Odometer', '${card.odo} KM'),
            _buildDetailRow('Transmission', card.transmission),
            _buildDetailRow('Chassis', card.chassis.isEmpty ? '—' : card.chassis, isMono: true),
          ],
        );

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161622) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.08),
              ),
            ),
            child: Column(
              children: [
                // Dialog Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Job Card Details',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // JC Code & Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              card.jcNumber,
                              style: const TextStyle(
                                fontFamily: 'JetBrains Mono',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6366F1),
                              ),
                            ),
                            Text(
                              card.jcDate,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Customer & Vehicle columns responsive layout
                        isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customerColumn,
                                  const SizedBox(height: 20),
                                  vehicleColumn,
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: customerColumn),
                                  const SizedBox(width: 20),
                                  Expanded(child: vehicleColumn),
                                ],
                              ),
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 12),

                        // Service details
                        const Text('SERVICE DETAILS', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                        const SizedBox(height: 6),
                        _buildDetailRow('Service Types', card.serviceTypes.join(', ')),
                        _buildDetailRow('Complaints', card.complaints.join(', ')),
                        if (card.complaintDetails.isNotEmpty)
                          _buildDetailRow('Complaint Details', card.complaintDetails),
                        _buildDetailRow('Fuel Level', '${card.fuelLevel.toInt()}%'),
                        
                        const SizedBox(height: 12),
                        const Text('INVENTORY RECEIVED', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _buildInventoryChip('Spare Wheel', card.hasSpareWheel),
                            _buildInventoryChip('Tool Kit', card.hasToolKit),
                            _buildInventoryChip('Jack Kit', card.hasJackKit),
                            _buildInventoryChip('Documents', card.hasDocuments),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 12),

                        // Inspection and other issues
                        const Text('INSPECTION ISSUES', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: card.inspectionStatuses.entries
                              .where((entry) => !entry.value)
                              .map((entry) => SummaryChip(label: entry.key, isIssue: true))
                              .toList()
                              .isEmpty
                              ? [const SummaryChip(label: 'All Clear ✓', isOk: true)]
                              : card.inspectionStatuses.entries
                                  .where((entry) => !entry.value)
                                  .map((entry) => SummaryChip(label: entry.key, isIssue: true))
                                  .toList(),
                        ),
                        
                        if (card.otherIssues.isNotEmpty) ...[
                          const SizedBox(height: 12),
                           const Text('OTHER INSPECTION ISSUES', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                          const SizedBox(height: 6),
                          Text(
                            card.otherIssues,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: isDark ? const Color(0xFFF0F0F5) : const Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                        
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 12),

                        // Signature
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('SIGNATURE STATUS', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF34D399).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.verified, size: 10, color: Color(0xFF34D399)),
                                  SizedBox(width: 4),
                                  Text(
                                    'Signed & Authorized',
                                    style: TextStyle(fontSize: 9, color: Color(0xFF34D399), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Dialog Footer Action
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _exportJobCard(card);
                          },
                          icon: const Icon(Icons.picture_as_pdf, size: 16),
                          label: const Text('Export PDF'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isMono = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 1),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: isMono ? 'JetBrains Mono' : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryChip(String label, bool isPresent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPresent ? const Color(0xFF34D399).withOpacity(0.08) : const Color(0xFFF87171).withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isPresent ? const Color(0xFF34D399).withOpacity(0.2) : const Color(0xFFF87171).withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPresent ? Icons.check_circle : Icons.cancel,
            size: 11,
            color: isPresent ? const Color(0xFF34D399) : const Color(0xFFF87171),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
              color: isPresent ? const Color(0xFF34D399) : const Color(0xFFF87171),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkState = isDarkMode ?? (theme.brightness == Brightness.dark);
    final toggleAction = onToggleTheme ?? () => isDarkModeNotifier.value = !isDarkModeNotifier.value;
    final createNewAction = onCreateNew ?? () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ValueListenableBuilder<bool>(
            valueListenable: isDarkModeNotifier,
            builder: (context, isDarkMode, child) {
              return JobCardWizardPage(
                isDarkMode: isDarkMode,
                onToggleTheme: () => isDarkModeNotifier.value = !isDarkMode,
              );
            },
          ),
        ),
      );
    };

    final Color surfaceColor = isDarkState
        ? Colors.white.withOpacity(0.04)
        : Colors.white.withOpacity(0.75);
    final Color borderColor = isDarkState
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.08);

    if (jobCards != null) {
      return _buildDashboardBody(context, jobCards!, surfaceColor, borderColor, isDarkState, createNewAction, toggleAction);
    } else {
      return ValueListenableBuilder<List<JobCardModel>>(
        valueListenable: jobCardsNotifier,
        builder: (context, cards, child) {
          return _buildDashboardBody(context, cards, surfaceColor, borderColor, isDarkState, createNewAction, toggleAction);
        },
      );
    }
  }

  Widget _buildDashboardBody(
    BuildContext context,
    List<JobCardModel> cardsList,
    Color surfaceColor,
    Color borderColor,
    bool isDarkState,
    VoidCallback createNewAction,
    VoidCallback toggleAction,
  ) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: AmbientOrbs(isDarkMode: isDarkState),
          ),
          SafeArea(
            child: Column(
              children: [

                // Dashboard Summary Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GlassPanel(
                    surfaceColor: surfaceColor,
                    borderColor: borderColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Today's Overview",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                            ),
                            ElevatedButton.icon(
                              onPressed: createNewAction,
                              icon: const Icon(Icons.add, size: 16),
                              label: const Text('Create Job Card', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            _buildStatCard(
                              context,
                              'TOTAL CREATED TODAY',
                              cardsList.length.toString(),
                              const Color(0xFF6366F1),
                              Icons.assignment,
                            ),
                            const SizedBox(width: 12),
                            _buildStatCard(
                              context,
                              'ACTIVE VEHICLES',
                              cardsList.length.toString(), // Mocked equal to total
                              const Color(0xFF22D3EE),
                              Icons.directions_car,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Job Cards List Label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'RECENT JOB CARDS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: theme.colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
                
                // Job Cards List
                Expanded(
                  child: cardsList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.assignment_outlined, size: 48, color: Colors.grey.withOpacity(0.6)),
                              const SizedBox(height: 8),
                              const Text(
                                'No Job Cards Created Yet',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          itemCount: cardsList.length,
                          itemBuilder: (context, index) {
                            final card = cardsList[cardsList.length - 1 - index]; // Show latest first
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GlassPanel(
                                surfaceColor: surfaceColor,
                                borderColor: borderColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          card.jcNumber,
                                          style: const TextStyle(
                                            fontFamily: 'JetBrains Mono',
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF6366F1),
                                          ),
                                        ),
                                        Text(
                                          card.jcDate.split(' ')[0], // Show date only
                                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.person, size: 14, color: theme.colorScheme.onBackground.withOpacity(0.6)),
                                        const SizedBox(width: 6),
                                        Text(
                                          card.custName,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Icon(Icons.directions_car, size: 14, color: theme.colorScheme.onBackground.withOpacity(0.6)),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${card.make} ${card.model}',
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Divider(height: 1),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () => _exportJobCard(card),
                                          icon: const Icon(Icons.picture_as_pdf, size: 14),
                                          label: const Text('Export PDF', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                        ),
                                        const SizedBox(width: 10),
                                        ElevatedButton.icon(
                                          onPressed: () => _showDetailsDialog(context, card),
                                          icon: const Icon(Icons.visibility, size: 14),
                                          label: const Text('View Details', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                                            foregroundColor: theme.colorScheme.primary,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 80), // Prevent overlay by floating navigation bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String val, Color accentColor, IconData icon) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.02),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: accentColor.withOpacity(0.15),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accentColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, letterSpacing: 0.5, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    val,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
