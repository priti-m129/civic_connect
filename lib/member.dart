/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  int _selectedIndex = 4; // Profile tab selected
  String _selectedLanguage = 'EN';

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/community');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _makePhoneCall() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SMS Help', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Call +91-1800-CIVIC for SMS help and support.',
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SelectableText(
                '+91-1800-CIVIC',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Phone number copied to clipboard!');
              },
              child: Text('Copy Number', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _showSupport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('24/7 Support', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            'Our support team is available 24/7 to help you with any issues or questions.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Support contacted successfully!');
              },
              child: Text('Contact Support', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    _showSnackBar('Language changed to $language');
  }

  void _viewCertificate(String certificateName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(certificateName, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                'This certificate verifies your achievements in the CivicConnect community.',
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Certificate downloaded!');
              },
              child: Text('Download', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Community Member',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'member@civicconnect.com',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Profile updated successfully!');
              },
              child: Text('Save', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _openNotificationSettings() {
    Navigator.pushNamed(context, '/notifications');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHelpSupportCards(),
                  const SizedBox(height: 24),
                  _buildLanguageSection(),
                  const SizedBox(height: 24),
                  _buildAwardsSection(),
                  const SizedBox(height: 24),
                  _buildCertificationsSection(),
                  const SizedBox(height: 24),
                  _buildSettingsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/issue-form'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 36, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(
            'Community Member',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Active Citizen',
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 20),
              const SizedBox(width: 4),
              Text(
                '2,847 points',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSupportCards() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _makePhoneCall,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.red, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SMS Help',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '+91-1800-CIVIC',
                        style: GoogleFonts.poppins(
                          color: Colors.red.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: _showSupport,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.support_agent, color: Colors.blue, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Support',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '24/7 Available',
                        style: GoogleFonts.poppins(
                          color: Colors.blue.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    final languages = [
      {'code': 'EN', 'name': 'English', 'color': Colors.orange},
      {'code': 'हि', 'name': 'Hindi', 'color': Colors.orange.shade200},
      {'code': 'मर', 'name': 'Marathi', 'color': Colors.blue.shade200},
      {'code': 'த', 'name': 'Tamil', 'color': Colors.pink.shade200},
      {'code': 'ગુ', 'name': 'Gujarati', 'color': Colors.green.shade200},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: languages.map((lang) {
              final isSelected = _selectedLanguage == lang['code'];
              return GestureDetector(
                onTap: () => _changeLanguage(lang['code'] as String),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? (lang['color'] as Color) : (lang['color'] as Color).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected ? Border.all(color: Colors.orange.shade600, width: 2) : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.orange,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.asset(
                            'assets/flag_india.png', // You'll need to add this asset
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.orange,
                                child: const Icon(Icons.flag, size: 12, color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        lang['code'] as String,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAwardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Awards & Recognition',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildAwardCard(
              title: 'Top Reporter',
              subtitle: '50+ Issues Reported',
              year: '2024',
              icon: Icons.star,
              color: Colors.orange.shade200,
            ),
            _buildAwardCard(
              title: 'Community Hero',
              subtitle: 'Helped 100+ Neighbors',
              year: '2024',
              icon: Icons.shield,
              color: Colors.purple.shade200,
            ),
            _buildAwardCard(
              title: 'Early Adopter',
              subtitle: 'Founding Member',
              year: '2023',
              icon: Icons.check_circle,
              color: Colors.green.shade200,
            ),
            _buildAwardCard(
              title: 'Social Champion',
              subtitle: 'Most Liked Posts',
              year: '2024',
              icon: Icons.favorite,
              color: Colors.pink.shade200,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAwardCard({
    required String title,
    required String subtitle,
    required String year,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.black54, size: 24),
              Text(
                year,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certifications',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildCertificationCard(
          title: 'Civic Leadership Certificate',
          subtitle: 'Issued by CivicConnect • Dec 2024',
          color: Colors.green.shade100,
          icon: Icons.verified,
          iconColor: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildCertificationCard(
          title: 'Community Safety Ambassador',
          subtitle: 'Issued by CivicConnect • Nov 2024',
          color: Colors.blue.shade100,
          icon: Icons.security,
          iconColor: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildCertificationCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: () => _viewCertificate(title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.visibility, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildSettingItem(
          icon: Icons.edit,
          title: 'Edit Profile',
          color: Colors.grey.shade100,
          onTap: _editProfile,
        ),
        const SizedBox(height: 12),
        _buildSettingItem(
          icon: Icons.notifications,
          title: 'Notifications',
          color: Colors.yellow.shade100,
          onTap: _openNotificationSettings,
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.list_alt, 'My Reports', 1),
          const SizedBox(width: 48),
          _buildNavItem(Icons.people, 'Community', 3),
          _buildNavItem(Icons.person, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.blue.shade700 : Colors.grey),
      onPressed: () => _onItemTapped(index),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  int _selectedIndex = 3; // Profile tab selected
  String _selectedLanguage = 'EN';

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/community');
    } else if (index == 3) {
      // Already on Member page
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _makePhoneCall() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SMS Help', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Call +91-1800-CIVIC for SMS help and support.',
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SelectableText(
                '+91-1800-CIVIC',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Phone number copied to clipboard!');
              },
              child: Text('Copy Number', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _showSupport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('24/7 Support', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            'Our support team is available 24/7 to help you with any issues or questions.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Support contacted successfully!');
              },
              child: Text('Contact Support', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    _showSnackBar('Language changed to $language');
  }

  void _viewCertificate(String certificateName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(certificateName, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                'This certificate verifies your achievements in the CivicConnect community.',
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Certificate downloaded!');
              },
              child: Text('Download', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Community Member',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'member@civicconnect.com',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar('Profile updated successfully!');
              },
              child: Text('Save', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _openNotificationSettings() {
    Navigator.pushNamed(context, '/notifications');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHelpSupportCards(),
                  const SizedBox(height: 24),
                  _buildLanguageSection(),
                  const SizedBox(height: 24),
                  _buildAwardsSection(),
                  const SizedBox(height: 24),
                  _buildCertificationsSection(),
                  const SizedBox(height: 24),
                  _buildSettingsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/issue-form'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 36, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(
            'Community Member',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Active Citizen',
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 20),
              const SizedBox(width: 4),
              Text(
                '2,847 points',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSupportCards() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _makePhoneCall,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.red, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SMS Help',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '+91-1800-CIVIC',
                        style: GoogleFonts.poppins(
                          color: Colors.red.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: _showSupport,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.support_agent, color: Colors.blue, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Support',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '24/7 Available',
                        style: GoogleFonts.poppins(
                          color: Colors.blue.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    final languages = [
      {'code': 'EN', 'name': 'English', 'color': Colors.orange},
      {'code': 'हि', 'name': 'Hindi', 'color': Colors.orange.shade200},
      {'code': 'मर', 'name': 'Marathi', 'color': Colors.blue.shade200},
      {'code': 'த', 'name': 'Tamil', 'color': Colors.pink.shade200},
      {'code': 'ગુ', 'name': 'Gujarati', 'color': Colors.green.shade200},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: languages.map((lang) {
              final isSelected = _selectedLanguage == lang['code'];
              return GestureDetector(
                onTap: () => _changeLanguage(lang['code'] as String),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? (lang['color'] as Color) : (lang['color'] as Color).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected ? Border.all(color: Colors.orange.shade600, width: 2) : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.orange,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.asset(
                            'assets/flag_india.png', // You'll need to add this asset
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.orange,
                                child: const Icon(Icons.flag, size: 12, color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        lang['code'] as String,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAwardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Awards & Recognition',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildAwardCard(
              title: 'Top Reporter',
              subtitle: '50+ Issues Reported',
              year: '2024',
              icon: Icons.star,
              color: Colors.orange.shade200,
            ),
            _buildAwardCard(
              title: 'Community Hero',
              subtitle: 'Helped 100+ Neighbors',
              year: '2024',
              icon: Icons.shield,
              color: Colors.purple.shade200,
            ),
            _buildAwardCard(
              title: 'Early Adopter',
              subtitle: 'Founding Member',
              year: '2023',
              icon: Icons.check_circle,
              color: Colors.green.shade200,
            ),
            _buildAwardCard(
              title: 'Social Champion',
              subtitle: 'Most Liked Posts',
              year: '2024',
              icon: Icons.favorite,
              color: Colors.pink.shade200,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAwardCard({
    required String title,
    required String subtitle,
    required String year,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.black54, size: 24),
              Text(
                year,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certifications',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildCertificationCard(
          title: 'Civic Leadership Certificate',
          subtitle: 'Issued by CivicConnect • Dec 2024',
          color: Colors.green.shade100,
          icon: Icons.verified,
          iconColor: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildCertificationCard(
          title: 'Community Safety Ambassador',
          subtitle: 'Issued by CivicConnect • Nov 2024',
          color: Colors.blue.shade100,
          icon: Icons.security,
          iconColor: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildCertificationCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: () => _viewCertificate(title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.visibility, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildSettingItem(
          icon: Icons.edit,
          title: 'Edit Profile',
          color: Colors.grey.shade100,
          onTap: _editProfile,
        ),
        const SizedBox(height: 12),
        _buildSettingItem(
          icon: Icons.notifications,
          title: 'Notifications',
          color: Colors.yellow.shade100,
          onTap: _openNotificationSettings,
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.list_alt, 'My Reports', 1),
          const SizedBox(width: 48),
          _buildNavItem(Icons.people, 'Community', 2),
          _buildNavItem(Icons.person, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.blue.shade700 : Colors.grey),
      onPressed: () => _onItemTapped(index),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Localization class for managing translations
class AppLocalizations {
  static Map<String, String> _currentTranslations = _englishTranslations;

  static final Map<String, String> _englishTranslations = {
    // Member Page
    'community_member': 'Community Member',
    'active_citizen': 'Active Citizen',
    'points': 'points',
    'sms_help': 'SMS Help',
    'support': 'Support',
    'available_24_7': '24/7 Available',
    'language': 'Language',
    'awards_recognition': 'Awards & Recognition',
    'top_reporter': 'Top Reporter',
    'issues_reported': '50+ Issues Reported',
    'community_hero': 'Community Hero',
    'helped_neighbors': 'Helped 100+ Neighbors',
    'early_adopter': 'Early Adopter',
    'founding_member': 'Founding Member',
    'social_champion': 'Social Champion',
    'most_liked_posts': 'Most Liked Posts',
    'certifications': 'Certifications',
    'civic_leadership_certificate': 'Civic Leadership Certificate',
    'issued_by_civicconnect': 'Issued by CivicConnect',
    'community_safety_ambassador': 'Community Safety Ambassador',
    'settings': 'Settings',
    'edit_profile': 'Edit Profile',
    'notifications': 'Notifications',

    // Common
    'home': 'Home',
    'my_reports': 'My Reports',
    'community': 'Community',
    'profile': 'Profile',
    'close': 'Close',
    'cancel': 'Cancel',
    'save': 'Save',
    'done': 'Done',
    'copy_number': 'Copy Number',
    'contact_support': 'Contact Support',
    'download': 'Download',
    'phone_number_copied': 'Phone number copied to clipboard!',
    'support_contacted': 'Support contacted successfully!',
    'language_changed': 'Language changed to',
    'certificate_downloaded': 'Certificate downloaded!',
    'profile_updated': 'Profile updated successfully!',

    // Dialog content
    'sms_help_dialog_content': 'Call +91-1800-CIVIC for SMS help and support.',
    'support_dialog_content': 'Our support team is available 24/7 to help you with any issues or questions.',
    'certificate_dialog_content': 'This certificate verifies your achievements in the CivicConnect community.',
    'name_hint': 'Community Member',
    'email_hint': 'member@civicconnect.com',

    // Homepage
    'civicconnect': 'CivicConnect',
    'hello_user': 'Hello User!',
    'ready_to_improve': 'Ready to improve your city today?',
    'report_an_issue': 'Report an Issue',
    'trending_issues': 'Trending Issues',
    'potholes': 'Potholes',
    'lights_out': 'Lights Out',
    'garbage': 'Garbage',
    'active': 'Active',
    'nearby_reports': 'Nearby Reports',
    'pothole': 'Pothole',
    'light_out': 'Light Out',
    'resolved': 'Resolved',
    'recent_updates': 'Recent Updates',
    'pothole_resolved': 'Pothole on Main St resolved! • 2 hours ago',
    'community_impact': 'Community Impact',
    'together_resolved': 'Together we\'ve resolved',
    'issues_count': '247 issues',

    // My Reports
    'total_reports': 'Total Reports',
    'in_progress': 'In Progress',
    'all': 'All',
    'view_details': 'View Details',
    'add_update': 'Add Update',
    'no_reports_found': 'No reports found',
    'no_reports_match_filter': 'No reports match the current filter',
    'location': 'Location',
    'date_reported': 'Date Reported',
    'status': 'Status',
    'description': 'Description',
    'progress_updates': 'Progress Updates',
    'enter_update': 'Enter your update...',
    'add_update_content': 'Add additional information or updates about this report:',
    'submit': 'Submit',
    'update_added_success': 'Update added successfully!',
    'fixed': 'Fixed',
    'working': 'Working',
    'review': 'Review',

    // Community
    'feed': 'Feed',
    'trending': 'Trending',
    'stats': 'Stats',
    'create_new_post': 'Create New Post',
    'take_photo': 'Take Photo',
    'choose_from_gallery': 'Choose from Gallery',
    'report_issue': 'Report Issue',
    'notification_settings': 'Notification Settings',
    'push_notifications': 'Push Notifications',
    'email_notifications': 'Email Notifications',
    'issue_updates': 'Issue Updates',
    'community_news': 'Community News',
    'trending_reports': 'Trending Reports',
    'comments': 'Comments',
    'add_comment': 'Add a comment...',
    'share_post': 'Share Post',
    'message': 'Message',
    'copy_link': 'Copy Link',
    'more': 'More',
    'road_issues': 'Road Issues',
    'streetlights': 'Streetlights',
    'water_issues': 'Water Issues',
    'waste_management': 'Waste Management',
    'reports_last_hours': 'reports in last 2 hours',
    'reports_today': 'reports today',
    'hot': 'HOT',
    'warm': 'WARM',
    'mild': 'MILD',
    'low': 'LOW',
    'popular_categories': 'Popular Categories',
    'city_impact_today': 'City Impact Today',
    'new_reports': 'New Reports',
    'active_citizens': 'Active Citizens',
    'recent_activity': 'Recent Activity',
    'refresh': 'Refresh',
    'citizen_reported_resolved': 'Citizen #247 reported pothole resolved',
    'downtown_minutes_ago': 'Downtown • 5 minutes ago',
  };

  static final Map<String, String> _hindiTranslations = {
    // Member Page
    'community_member': 'समुदायिक सदस्य',
    'active_citizen': 'सक्रिय नागरिक',
    'points': 'अंक',
    'sms_help': 'SMS सहायता',
    'support': 'सहायता',
    'available_24_7': '24/7 उपलब्ध',
    'language': 'भाषा',
    'awards_recognition': 'पुरस्कार और मान्यता',
    'top_reporter': 'शीर्ष रिपोर्टर',
    'issues_reported': '50+ मुद्दे रिपोर्ट किए',
    'community_hero': 'समुदायिक नायक',
    'helped_neighbors': '100+ पड़ोसियों की मदद की',
    'early_adopter': 'प्रारंभिक अपनाने वाला',
    'founding_member': 'संस्थापक सदस्य',
    'social_champion': 'सामाजिक चैंपियन',
    'most_liked_posts': 'सबसे ज्यादा पसंद किए गए पोस्ट',
    'certifications': 'प्रमाणपत्र',
    'civic_leadership_certificate': 'नागरिक नेतृत्व प्रमाणपत्र',
    'issued_by_civicconnect': 'CivicConnect द्वारा जारी',
    'community_safety_ambassador': 'समुदायिक सुरक्षा राजदूत',
    'settings': 'सेटिंग्स',
    'edit_profile': 'प्रोफाइल संपादित करें',
    'notifications': 'सूचनाएं',

    // Common
    'home': 'होम',
    'my_reports': 'मेरी रिपोर्ट्स',
    'community': 'समुदाय',
    'profile': 'प्रोफाइल',
    'close': 'बंद करें',
    'cancel': 'रद्द करें',
    'save': 'सेव करें',
    'done': 'हो गया',
    'copy_number': 'नंबर कॉपी करें',
    'contact_support': 'सहायता से संपर्क करें',
    'download': 'डाउनलोड',
    'phone_number_copied': 'फोन नंबर क्लिपबोर्ड में कॉपी किया गया!',
    'support_contacted': 'सहायता से सफलतापूर्वक संपर्क हुआ!',
    'language_changed': 'भाषा बदली गई',
    'certificate_downloaded': 'प्रमाणपत्र डाउनलोड हुआ!',
    'profile_updated': 'प्रोफाइल सफलतापूर्वक अपडेट हुआ!',

    // Dialog content
    'sms_help_dialog_content': 'SMS सहायता और सहारे के लिए +91-1800-CIVIC पर कॉल करें।',
    'support_dialog_content': 'हमारी सहायता टीम आपकी किसी भी समस्या या प्रश्न में 24/7 मदद के लिए उपलब्ध है।',
    'certificate_dialog_content': 'यह प्रमाणपत्र CivicConnect समुदाय में आपकी उपलब्धियों को सत्यापित करता है।',
    'name_hint': 'समुदायिक सदस्य',
    'email_hint': 'member@civicconnect.com',

    // Homepage
    'civicconnect': 'CivicConnect',
    'hello_user': 'नमस्ते उपयोगकर्ता!',
    'ready_to_improve': 'आज अपने शहर को बेहतर बनाने के लिए तैयार हैं?',
    'report_an_issue': 'समस्या रिपोर्ट करें',
    'trending_issues': 'चलन में मुद्दे',
    'potholes': 'गड्ढे',
    'lights_out': 'लाइट्स आउट',
    'garbage': 'कचरा',
    'active': 'सक्रिय',
    'nearby_reports': 'आस-पास की रिपोर्ट्स',
    'pothole': 'गड्ढा',
    'light_out': 'लाइट आउट',
    'resolved': 'हल हो गया',
    'recent_updates': 'हाल की अपडेट्स',
    'pothole_resolved': 'मेन सेंट पर गड्ढा हल हुआ! • 2 घंटे पहले',
    'community_impact': 'समुदायिक प्रभाव',
    'together_resolved': 'मिलकर हमने हल किया है',
    'issues_count': '247 मुद्दे',

    // My Reports
    'total_reports': 'कुल रिपोर्ट्स',
    'in_progress': 'प्रगति में',
    'all': 'सभी',
    'view_details': 'विवरण देखें',
    'add_update': 'अपडेट जोड़ें',
    'no_reports_found': 'कोई रिपोर्ट नहीं मिली',
    'no_reports_match_filter': 'वर्तमान फिल्टर से कोई रिपोर्ट मैच नहीं करती',
    'location': 'स्थान',
    'date_reported': 'रिपोर्ट की तारीख',
    'status': 'स्थिति',
    'description': 'विवरण',
    'progress_updates': 'प्रगति अपडेट्स',
    'enter_update': 'अपना अपडेट दर्ज करें...',
    'add_update_content': 'इस रिपोर्ट के बारे में अतिरिक्त जानकारी या अपडेट जोड़ें:',
    'submit': 'जमा करें',
    'update_added_success': 'अपडेट सफलतापूर्वक जोड़ा गया!',
    'fixed': 'ठीक हो गया',
    'working': 'कार्य में',
    'review': 'समीक्षा',

    // Community
    'feed': 'फीड',
    'trending': 'ट्रेंडिंग',
    'stats': 'आंकड़े',
    'create_new_post': 'नई पोस्ट बनाएं',
    'take_photo': 'फोटो लें',
    'choose_from_gallery': 'गैलरी से चुनें',
    'report_issue': 'समस्या रिपोर्ट करें',
    'notification_settings': 'सूचना सेटिंग्स',
    'push_notifications': 'पुश सूचनाएं',
    'email_notifications': 'ईमेल सूचनाएं',
    'issue_updates': 'मुद्दा अपडेट्स',
    'community_news': 'समुदायिक समाचार',
    'trending_reports': 'ट्रेंडिंग रिपोर्ट्स',
    'comments': 'टिप्पणियां',
    'add_comment': 'टिप्पणी जोड़ें...',
    'share_post': 'पोस्ट साझा करें',
    'message': 'संदेश',
    'copy_link': 'लिंक कॉपी करें',
    'more': 'और',
    'road_issues': 'सड़क की समस्याएं',
    'streetlights': 'स्ट्रीट लाइट्स',
    'water_issues': 'पानी की समस्याएं',
    'waste_management': 'कचरा प्रबंधन',
    'reports_last_hours': 'पिछले 2 घंटों में रिपोर्ट्स',
    'reports_today': 'आज की रिपोर्ट्स',
    'hot': 'गर्म',
    'warm': 'उष्ण',
    'mild': 'मध्यम',
    'low': 'कम',
    'popular_categories': 'लोकप्रिय श्रेणियां',
    'city_impact_today': 'आज शहर का प्रभाव',
    'new_reports': 'नई रिपोर्ट्स',
    'active_citizens': 'सक्रिय नागरिक',
    'recent_activity': 'हाल की गतिविधि',
    'refresh': 'रीफ्रेश',
    'citizen_reported_resolved': 'नागरिक #247 ने गड्ढा हल होने की रिपोर्ट की',
    'downtown_minutes_ago': 'डाउनटाउन • 5 मिनट पहले',
  };

  static String get(String key) {
    return _currentTranslations[key] ?? key;
  }

  static void setLanguage(String languageCode) {
    switch (languageCode) {
      case 'हि':
        _currentTranslations = _hindiTranslations;
        break;
      case 'EN':
      default:
        _currentTranslations = _englishTranslations;
        break;
    }
  }

  static bool get isHindi => _currentTranslations == _hindiTranslations;
}

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  int _selectedIndex = 3; // Profile tab selected
  String _selectedLanguage = 'EN';

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/community');
    } else if (index == 3) {
      // Already on Member page
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _makePhoneCall() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.get('sms_help'), style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.get('sms_help_dialog_content'),
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SelectableText(
                '+91-1800-CIVIC',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.get('close'), style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar(AppLocalizations.get('phone_number_copied'));
              },
              child: Text(AppLocalizations.get('copy_number'), style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _showSupport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('24/7 ${AppLocalizations.get('support')}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            AppLocalizations.get('support_dialog_content'),
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.get('close'), style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar(AppLocalizations.get('support_contacted'));
              },
              child: Text(AppLocalizations.get('contact_support'), style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
      AppLocalizations.setLanguage(language);
    });
    String langName = language == 'हि' ? 'Hindi' : 'English';
    _showSnackBar('${AppLocalizations.get('language_changed')} $langName');
  }

  void _viewCertificate(String certificateName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(certificateName, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.get('certificate_dialog_content'),
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.get('close'), style: GoogleFonts.poppins(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar(AppLocalizations.get('certificate_downloaded'));
              },
              child: Text(AppLocalizations.get('download'), style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.get('edit_profile'), style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.get('name_hint').split(' ')[0], // 'Name' in respective language
                  hintText: AppLocalizations.get('name_hint'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: AppLocalizations.get('email_hint'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.get('cancel'), style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar(AppLocalizations.get('profile_updated'));
              },
              child: Text(AppLocalizations.get('save'), style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _openNotificationSettings() {
    Navigator.pushNamed(context, '/notifications');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHelpSupportCards(),
                  const SizedBox(height: 24),
                  _buildLanguageSection(),
                  const SizedBox(height: 24),
                  _buildAwardsSection(),
                  const SizedBox(height: 24),
                  _buildCertificationsSection(),
                  const SizedBox(height: 24),
                  _buildSettingsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/issue-form'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 36, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.get('community_member'),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            AppLocalizations.get('active_citizen'),
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 20),
              const SizedBox(width: 4),
              Text(
                '2,847 ${AppLocalizations.get('points')}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSupportCards() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _makePhoneCall,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.red, size: 24),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.get('sms_help'),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '+91-1800-CIVIC',
                          style: GoogleFonts.poppins(
                            color: Colors.red.shade700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: _showSupport,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.support_agent, color: Colors.blue, size: 24),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.get('support'),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          AppLocalizations.get('available_24_7'),
                          style: GoogleFonts.poppins(
                            color: Colors.blue.shade700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    final languages = [
      {'code': 'EN', 'name': 'English', 'color': Colors.orange},
      {'code': 'हि', 'name': 'Hindi', 'color': Colors.orange.shade200},
      {'code': 'मर', 'name': 'Marathi', 'color': Colors.blue.shade200},
      {'code': 'த', 'name': 'Tamil', 'color': Colors.pink.shade200},
      {'code': 'ગુ', 'name': 'Gujarati', 'color': Colors.green.shade200},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.get('language'),
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: languages.map((lang) {
              final isSelected = _selectedLanguage == lang['code'];
              return GestureDetector(
                onTap: () => _changeLanguage(lang['code'] as String),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? (lang['color'] as Color) : (lang['color'] as Color).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected ? Border.all(color: Colors.orange.shade600, width: 2) : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.orange,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.asset(
                            'assets/flag_india.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.orange,
                                child: const Icon(Icons.flag, size: 12, color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        lang['code'] as String,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAwardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.get('awards_recognition'),
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildAwardCard(
              title: AppLocalizations.get('top_reporter'),
              subtitle: AppLocalizations.get('issues_reported'),
              year: '2024',
              icon: Icons.star,
              color: Colors.orange.shade200,
            ),
            _buildAwardCard(
              title: AppLocalizations.get('community_hero'),
              subtitle: AppLocalizations.get('helped_neighbors'),
              year: '2024',
              icon: Icons.shield,
              color: Colors.purple.shade200,
            ),
            _buildAwardCard(
              title: AppLocalizations.get('early_adopter'),
              subtitle: AppLocalizations.get('founding_member'),
              year: '2023',
              icon: Icons.check_circle,
              color: Colors.green.shade200,
            ),
            _buildAwardCard(
              title: AppLocalizations.get('social_champion'),
              subtitle: AppLocalizations.get('most_liked_posts'),
              year: '2024',
              icon: Icons.favorite,
              color: Colors.pink.shade200,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAwardCard({
    required String title,
    required String subtitle,
    required String year,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.black54, size: 24),
              Text(
                year,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.get('certifications'),
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildCertificationCard(
          title: AppLocalizations.get('civic_leadership_certificate'),
          subtitle: '${AppLocalizations.get('issued_by_civicconnect')} • Dec 2024',
          color: Colors.green.shade100,
          icon: Icons.verified,
          iconColor: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildCertificationCard(
          title: AppLocalizations.get('community_safety_ambassador'),
          subtitle: '${AppLocalizations.get('issued_by_civicconnect')} • Nov 2024',
          color: Colors.blue.shade100,
          icon: Icons.security,
          iconColor: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildCertificationCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: () => _viewCertificate(title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.visibility, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.get('settings'),
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildSettingItem(
          icon: Icons.edit,
          title: AppLocalizations.get('edit_profile'),
          color: Colors.grey.shade100,
          onTap: _editProfile,
        ),
        const SizedBox(height: 12),
        _buildSettingItem(
          icon: Icons.notifications,
          title: AppLocalizations.get('notifications'),
          color: Colors.yellow.shade100,
          onTap: _openNotificationSettings,
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home, AppLocalizations.get('home'), 0),
          _buildNavItem(Icons.list_alt, AppLocalizations.get('my_reports'), 1),
          const SizedBox(width: 48),
          _buildNavItem(Icons.people, AppLocalizations.get('community'), 2),
          _buildNavItem(Icons.person, AppLocalizations.get('profile'), 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.blue.shade700 : Colors.grey),
      onPressed: () => _onItemTapped(index),
    );
  }
}