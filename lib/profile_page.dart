import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'assigned_jobs_page.dart';
import 'screens/login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Alex Carter";
  String phone = "+91 9876543210";
  String email = "alex.carter@gmail.com";

  final List<Map<String, String>> jobs = [
    {
      "title": "BMW Engine Repair",
      "location": "Anna Nagar",
      "status": "In Progress"
    },
    {
      "title": "Hyundai Service",
      "location": "Tambaram",
      "status": "Completed"
    },
    {
      "title": "Toyota Brake Service",
      "location": "Velachery",
      "status": "Pending"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff1E293B),
                    Color(0xff2563EB),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.car_repair,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 5),
                      Text(
                        "4.9 Rating",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Statistics
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  statBox("248", "Jobs", Icons.build),
                  const SizedBox(width: 10),
                  statBox("4.9", "Rating", Icons.star),
                  const SizedBox(width: 10),
                  statBox("₹25K", "Earned", Icons.currency_rupee),
                ],
              ),
            ),

            const SizedBox(height: 20),

            buildCard(
              "Personal Information",
              [
                infoTile(Icons.person, "Name", name),
                infoTile(Icons.phone, "Phone", phone),
                infoTile(Icons.email, "Email", email),
                infoTile(Icons.location_on, "Location", "Chennai"),
              ],
            ),

            buildCard(
              "Professional Details",
              [
                infoTile(Icons.car_repair,
                    "Specialization", "Car Mechanic"),
                infoTile(Icons.workspace_premium,
                    "Experience", "5 Years"),
                infoTile(Icons.verified,
                    "Certification", "Certified Technician"),
              ],
            ),

            const SizedBox(height: 20),
            actionButton(
              "Edit Profile",
              Icons.edit,
              Colors.blue,
                  () async {
                final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfilePage(
                      name: name,
                      phone: phone,
                      email: email,
                    ),
                  ),
                );

                if (updatedData != null) {
                  setState(() {
                    name = updatedData['name'];
                    phone = updatedData['phone'];
                    email = updatedData['email'];
                  });
                }
              },
            ),




            actionButton(
              "Assigned Jobs",
              Icons.work,
              Colors.green,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AssignedJobsPage(),
                  ),
                );
              },
            ),

            actionButton(
              "Logout",
              Icons.logout,
              Colors.red,
              logout,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget statBox(String value, String title, IconData icon) {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff1E293B),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2563EB),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget infoTile(
      IconData icon,
      String title,
      String subtitle,
      ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        title,
        style: TextStyle(color: Colors.grey.shade600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xff1E293B),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget actionButton(
      String text,
      IconData icon,
      Color color,
      VoidCallback function,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          icon: Icon(icon),
          label: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: function,
        ),
      ),
    );
  }

  void editProfile() {
    TextEditingController nameController =
    TextEditingController(text: name);

    TextEditingController phoneController =
    TextEditingController(text: phone);

    TextEditingController emailController =
    TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration:
                const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: phoneController,
                decoration:
                const InputDecoration(labelText: "Phone"),
              ),
              TextField(
                controller: emailController,
                decoration:
                const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  phone = phoneController.text;
                  email = emailController.text;
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        );
      },
    );
  }

  void showJobs() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xFFF1F5F9),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(
                  Icons.car_repair,
                  color: Color(0xff2563EB),
                ),
                title: Text(
                  jobs[index]["title"]!,
                  style: const TextStyle(
                    color: Color(0xff1E293B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  jobs[index]["location"]!,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                trailing: Text(
                  jobs[index]["status"]!,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text(
            "Are you sure you want to logout?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Logged Out Successfully"),
                  ),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text("Logout"),
            )
          ],
        );
      },
    );
  }
}