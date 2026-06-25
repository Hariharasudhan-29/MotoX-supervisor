import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  final TextEditingController experienceController =
  TextEditingController(text: "5 Years");

  final TextEditingController locationController =
  TextEditingController(text: "Chennai");

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    experienceController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: const Color(0xff2563EB),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            buildField(
              controller: nameController,
              label: "Mechanic Name",
              icon: Icons.person,
            ),

            buildField(
              controller: phoneController,
              label: "Phone Number",
              icon: Icons.phone,
            ),

            buildField(
              controller: emailController,
              label: "Email",
              icon: Icons.email,
            ),

            buildField(
              controller: experienceController,
              label: "Experience",
              icon: Icons.workspace_premium,
            ),

            buildField(
              controller: locationController,
              label: "Location",
              icon: Icons.location_on,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    {
                      'name': nameController.text,
                      'phone': phoneController.text,
                      'email': emailController.text,
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

  Widget buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),

      child: TextField(
        controller: controller,
        style: const TextStyle(color: Color(0xff1E293B)),

        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.blueAccent,
          ),

          labelText: label,

          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}