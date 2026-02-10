import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Farmer';
  String _email = 'john.farmer@gmail.com';
  String _phone = '+94 77 123 4567';
  String _address = '123 Farm Road, Colombo, Sri Lanka';
  String _farmSize = '5 acres';
  String _crops = 'Paddy, Corn, Vegetables';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: const Color(0xFF2E7D32),
                        ),
                        const Text(
                          'My Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Edit profile
                          },
                          color: const Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Profile Image
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF4CAF50),
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Premium Farmer',
                        style: TextStyle(
                          color: Color(0xFF4CAF50),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Personal Information
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.phone,
                      title: 'Phone Number',
                      value: _phone,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: Icons.location_on,
                      title: 'Address',
                      value: _address,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: Icons.agriculture,
                      title: 'Farm Size',
                      value: _farmSize,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: Icons.grass,
                      title: 'Main Crops',
                      value: _crops,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Settings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildSettingItem(
                            icon: Icons.notifications,
                            title: 'Notifications',
                            onTap: () {},
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),
                          _buildSettingItem(
                            icon: Icons.lock,
                            title: 'Change Password',
                            onTap: () {},
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),
                          _buildSettingItem(
                            icon: Icons.language,
                            title: 'Language',
                            value: 'English',
                            onTap: () {},
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),
                          _buildSettingItem(
                            icon: Icons.help,
                            title: 'Help & Support',
                            onTap: () {},
                          ),
                          Divider(height: 1, color: Colors.grey.shade200),
                          _buildSettingItem(
                            icon: Icons.privacy_tip,
                            title: 'Privacy Policy',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4CAF50),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF4CAF50),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          const SizedBox(width: 8),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}