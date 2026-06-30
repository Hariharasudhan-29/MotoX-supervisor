import 'package:flutter/material.dart';
import '../widgets/interactive_card.dart';
import '../main.dart';
import '../job_card_model.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCustomerDetailsDialog(BuildContext context, Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161622) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with avatar
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: (customer["statusColor"] as Color).withValues(alpha: 0.1),
                      child: Text(
                        customer["name"]![0],
                        style: TextStyle(
                          color: customer["statusColor"] as Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer["name"]!,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: (customer["statusColor"] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              customer["status"]!,
                              style: TextStyle(
                                color: customer["statusColor"] as Color,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                // Detail Fields
                _buildPopupRow(context, Icons.phone_android_rounded, "Contact Number", customer["phone"]!),
                const SizedBox(height: 14),
                _buildPopupRow(context, Icons.email_outlined, "Email Address", customer["email"]!),
                const SizedBox(height: 14),
                _buildPopupRow(context, Icons.directions_car_rounded, "Vehicle Info", customer["car"]!),
                const SizedBox(height: 14),
                _buildPopupRow(context, Icons.calendar_month_outlined, "Account Status", "Active Client"),
                
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                
                // Footer button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Close Profile", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopupRow(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary.withValues(alpha: 0.7)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> mockCustomers = [
      {
        "name": "John Doe",
        "phone": "+91 98765 43210",
        "email": "john.doe@gmail.com",
        "car": "Mercedes Benz S-Class",
        "status": "In Service",
        "statusColor": Colors.blue,
      },
      {
        "name": "Sarah Connor",
        "phone": "+91 99887 76655",
        "email": "sarah.c@outlook.com",
        "car": "BMW M4 Coupe",
        "status": "Scheduled",
        "statusColor": Colors.orange,
      },
      {
        "name": "Tony Stark",
        "phone": "+91 90000 11111",
        "email": "tony@starkindustries.com",
        "car": "Audi R8 Spyder",
        "status": "Completed",
        "statusColor": Colors.green,
      },
      {
        "name": "Bruce Wayne",
        "phone": "+91 88888 88888",
        "email": "bruce@waynecorp.com",
        "car": "Lamborghini Aventador",
        "status": "Delivered",
        "statusColor": Colors.teal,
      }
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Customer Profiles",
              style: TextStyle(
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 16),
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.grey.shade200,
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 14),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Search customers by name, phone or vehicle...",
                  prefixIcon: Icon(Icons.search, size: 20),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ValueListenableBuilder<List<JobCardModel>>(
                valueListenable: jobCardsNotifier,
                builder: (context, newCards, child) {
                  final allCustomers = [
                    ...mockCustomers,
                    ...newCards.map((card) => {
                          "name": card.custName,
                          "phone": "+91 ${card.custPhone}",
                          "email": card.custEmail.isEmpty ? "N/A" : card.custEmail,
                          "car": "${card.make} ${card.model}",
                          "status": "In Service",
                          "statusColor": Colors.blue,
                        }),
                  ];

                  final filteredCustomers = allCustomers.where((customer) {
                    final name = (customer["name"] as String).toLowerCase();
                    final car = (customer["car"] as String).toLowerCase();
                    final phone = (customer["phone"] as String).toLowerCase();
                    final query = _searchQuery.toLowerCase();
                    return name.contains(query) || car.contains(query) || phone.contains(query);
                  }).toList();

                  if (filteredCustomers.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_outline_rounded, size: 48, color: Colors.grey.withValues(alpha: 0.5)),
                          const SizedBox(height: 8),
                          const Text(
                            "No customers match search query",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredCustomers.length,
                    padding: const EdgeInsets.only(bottom: 100),
                    itemBuilder: (context, index) {
                      final customer = filteredCustomers[index];
                      final statusColor = customer["statusColor"] as Color;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InteractiveCard(
                          onTap: () => _showCustomerDetailsDialog(context, customer),
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
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: statusColor.withValues(alpha: 0.1),
                                  child: Text(
                                    customer["name"]![0],
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        customer["name"]!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        customer["car"]!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: theme.colorScheme.onBackground.withValues(alpha: 0.6),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(Icons.phone, size: 12, color: theme.colorScheme.onBackground.withValues(alpha: 0.4)),
                                          const SizedBox(width: 6),
                                          Text(
                                            customer["phone"]!,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: theme.colorScheme.onBackground.withValues(alpha: 0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.email, size: 12, color: theme.colorScheme.onBackground.withValues(alpha: 0.4)),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              customer["email"]!,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: theme.colorScheme.onBackground.withValues(alpha: 0.5),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    customer["status"]!,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
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
