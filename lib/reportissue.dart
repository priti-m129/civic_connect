/*
// lib/report_issue_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:civic_connect/chat_popup.dart';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  int _selectedIndex = 2; // Default selected index is 'Report'

  // ✅ THIS FUNCTION IS NOW UPDATED
  void _onItemTapped(int index) {
    // If the Home icon is tapped, navigate to the HomePage
    if (index == 0) {
      // We use pushNamedAndRemoveUntil to clear the back stack
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showChatPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ChatPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CivicConnect', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.send_outlined),
            onPressed: _showChatPopup,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Quick Actions'),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildSectionTitle('Recent Activity', showViewAll: true),
            _buildRecentActivityList(),
            const SizedBox(height: 24),
            _buildSectionTitle('Community Impact'),
            _buildCommunityImpactCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Trending in Your Area'),
            _buildTrendingList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- Helper Widgets ---

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.purple.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back, User!', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(color: Colors.black87),
                    children: [
                      const TextSpan(text: 'Your community impact: '),
                      TextSpan(
                        text: '3 reports resolved',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.waving_hand, color: Colors.orangeAccent, size: 36),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showViewAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        if (showViewAll) TextButton(onPressed: () {}, child: const Text('View All')),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        _buildQuickActionCard('Report Issue', Icons.add_task, Colors.blue.shade100, () {}),
        const SizedBox(width: 16),
        _buildQuickActionCard('My Reports', Icons.list_alt, Colors.green.shade100, () {}),
      ],
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32, color: Colors.black87),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivityList() {
    return Column(
      children: [
        _buildActivityItem(Icons.check_circle, 'Pothole on Main St - Resolved', '2 hours ago', 'Fixed', Colors.green),
        _buildActivityItem(Icons.construction, 'Streetlight on Oak Ave - In Progress', '1 day ago', 'Working', Colors.orange),
        _buildActivityItem(Icons.rate_review, 'Graffiti Report - Under Review', '3 days ago', 'Review', Colors.blue),
      ],
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String subtitle, String status, Color statusColor) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: statusColor),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ),
    );
  }

  Widget _buildCommunityImpactCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildImpactStat('127', 'Issues Resolved'),
            _buildImpactStat('23', 'In Progress'),
            _buildImpactStat('8', 'This Week'),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactStat(String count, String label) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTrendingList() {
    return Column(
      children: [
        _buildTrendingItem(Icons.remove_road, 'Road Issues', '+5 today', Colors.red),
        _buildTrendingItem(Icons.lightbulb_outline, 'Streetlights', '+2 today', Colors.orange),
      ],
    );
  }

  Widget _buildTrendingItem(IconData icon, String title, String stat, Color statColor) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(stat, style: TextStyle(color: statColor, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    final navItems = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.list_alt, 'label': 'My Reports'},
      {'icon': Icons.add, 'label': 'Report'},
      {'icon': Icons.people, 'label': 'Community'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          if (index == 2) return const SizedBox(width: 48);
          return IconButton(
            icon: Icon(navItems[index]['icon'] as IconData, color: _selectedIndex == index ? Colors.blue.shade700 : Colors.grey),
            onPressed: () => _onItemTapped(index),
          );
        }),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:civic_connect/chat_popup.dart';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  int _selectedIndex = 2; // Default selected index is 'Report'

  void _onItemTapped(int index) {
    // This function now handles navigation for Home and My Reports
    if (index == 0) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showChatPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ChatPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CivicConnect', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.send_outlined),
            onPressed: _showChatPopup,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Quick Actions'),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildSectionTitle('Recent Activity', showViewAll: true),
            _buildRecentActivityList(),
            const SizedBox(height: 24),
            _buildSectionTitle('Community Impact'),
            _buildCommunityImpactCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Trending in Your Area'),
            _buildTrendingList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- Helper Widgets ---

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.purple.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back, User!', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(color: Colors.black87),
                    children: [
                      const TextSpan(text: 'Your community impact: '),
                      TextSpan(
                        text: '3 reports resolved',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.waving_hand, color: Colors.orangeAccent, size: 36),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showViewAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        if (showViewAll) TextButton(onPressed: () {}, child: const Text('View All')),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        _buildQuickActionCard('Report Issue', Icons.add_task, Colors.blue.shade100, () {}),
        const SizedBox(width: 16),
        _buildQuickActionCard('My Reports', Icons.list_alt, Colors.green.shade100, () {}),
      ],
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32, color: Colors.black87),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivityList() {
    return Column(
      children: [
        _buildActivityItem(Icons.check_circle, 'Pothole on Main St - Resolved', '2 hours ago', 'Fixed', Colors.green),
        _buildActivityItem(Icons.construction, 'Streetlight on Oak Ave - In Progress', '1 day ago', 'Working', Colors.orange),
        _buildActivityItem(Icons.rate_review, 'Graffiti Report - Under Review', '3 days ago', 'Review', Colors.blue),
      ],
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String subtitle, String status, Color statusColor) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: statusColor),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ),
    );
  }

  Widget _buildCommunityImpactCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildImpactStat('127', 'Issues Resolved'),
            _buildImpactStat('23', 'In Progress'),
            _buildImpactStat('8', 'This Week'),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactStat(String count, String label) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTrendingList() {
    return Column(
      children: [
        _buildTrendingItem(Icons.remove_road, 'Road Issues', '+5 today', Colors.red),
        _buildTrendingItem(Icons.lightbulb_outline, 'Streetlights', '+2 today', Colors.orange),
      ],
    );
  }

  Widget _buildTrendingItem(IconData icon, String title, String stat, Color statColor) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(stat, style: TextStyle(color: statColor, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    final navItems = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.list_alt, 'label': 'My Reports'},
      {'icon': Icons.add, 'label': 'Report'},
      {'icon': Icons.people, 'label': 'Community'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          if (index == 2) return const SizedBox(width: 48);
          return IconButton(
            icon: Icon(navItems[index]['icon'] as IconData, color: _selectedIndex == index ? Colors.blue.shade700 : Colors.grey),
            onPressed: () => _onItemTapped(index),
          );
        }),
      ),
    );
  }
}