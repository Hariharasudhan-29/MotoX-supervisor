import 'package:flutter/material.dart';

class AssignedJobsPage extends StatelessWidget {
  const AssignedJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Assigned Jobs"),
        backgroundColor: const Color(0xff2563EB),
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(15),

        children: [

          buildJobCard(
            car: "BMW X5",
            service: "Engine Repair",
            location: "Anna Nagar",
            status: "In Progress",
            statusColor: Colors.orange,
          ),

          buildJobCard(
            car: "Hyundai Creta",
            service: "Full Service",
            location: "Tambaram",
            status: "Completed",
            statusColor: Colors.green,
          ),

          buildJobCard(
            car: "Toyota Fortuner",
            service: "Brake Replacement",
            location: "Velachery",
            status: "Pending",
            statusColor: Colors.red,
          ),

          buildJobCard(
            car: "Honda City",
            service: "Oil Change",
            location: "OMR",
            status: "Completed",
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget buildJobCard({
    required String car,
    required String service,
    required String location,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: const EdgeInsets.only(bottom: 15),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                const Icon(
                  Icons.directions_car,
                  color: Colors.blueAccent,
                  size: 30,
                ),

                const SizedBox(width: 10),

                Text(
                  car,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1E293B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Text(
              "Service : $service",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Location : $location",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}