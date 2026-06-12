/*
import 'package:civic_connect/chat_popup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // for BottomNavigationBar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showChatPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Important for rounded corners
      isScrollControlled: true,
      builder: (context) {
        return const ChatPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'CC',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          'CivicConnect',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.send_outlined, color: Colors.black, size: 26),
                onPressed: _showChatPopup,
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildReportButton(),
              const SizedBox(height: 24),
              _buildTrendingIssues(),
              const SizedBox(height: 24),
              _buildNearbyReports(),
              const SizedBox(height: 24),
              _buildRecentUpdates(),
              const SizedBox(height: 24),
              _buildCommunityImpact(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/report-issue');
        },
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white,),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- Helper Widgets for Building the UI ---

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello User!', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
        Text('Ready to improve your city today?', style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildReportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/report-issue');
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Report an Issue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
        ),
      ),
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                _buildTrendingCard(
                  title: 'Potholes',
                  subtitle: '12 Active',
                  icon: Icons.remove_road,
                  gradientColors: [const Color(0xFFFFA726), const Color(0xFFFB8C00)],
                ),
                _buildTrendingCard(
                  title: 'Lights Out',
                  subtitle: '8 Active',
                  icon: Icons.lightbulb_outline,
                  gradientColors: [const Color(0xFFFFEE58), const Color(0xFFFFD54F)],
                ),
                _buildTrendingCard(
                  title: 'Garbage',
                  subtitle: '5 Active',
                  icon: Icons.delete_outline,
                  gradientColors: [const Color(0xFF66BB6A), const Color(0xFF4CAF50)],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors[1].withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 36, color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyReports() {
    return _buildSectionCard(
      title: 'Nearby Reports',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMapStatus('Pothole', Colors.red.shade400),
          _buildMapStatus('Light Out', Colors.yellow.shade600),
          _buildMapStatus('Resolved', Colors.green.shade400),
        ],
      ),
    );
  }

  Widget _buildMapStatus(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentUpdates() {
    return _buildSectionCard(
      title: 'Recent Updates',
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Pothole on Main St resolved! • 2 hours ago',
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityImpact() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow.shade100, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Community Impact', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Together we\'ve resolved', style: GoogleFonts.poppins(color: Colors.grey[700])),
          const SizedBox(height: 8),
          Text('247 issues', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue.shade800)),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          child,
        ],
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
          const SizedBox(width: 48), // The space for the FAB
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
}
*/
/*import 'package:civic_connect/chat_popup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/community');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/member');
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
      builder: (context) {
        return const ChatPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'CC',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          'CivicConnect',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.send_outlined, color: Colors.black, size: 26),
                onPressed: _showChatPopup,
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildReportButton(), // This will navigate to issue-form
              const SizedBox(height: 24),
              _buildTrendingIssues(),
              const SizedBox(height: 24),
              _buildNearbyReports(),
              const SizedBox(height: 24),
              _buildRecentUpdates(),
              const SizedBox(height: 24),
              _buildCommunityImpact(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        // This will navigate to reportissue.dart (dashboard/overview)
        onPressed: () => Navigator.pushNamed(context, '/report-issue'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white,),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- Helper Widgets for Building the UI ---

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello User!', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
        Text('Ready to improve your city today?', style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildReportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        // ✅ Blue box navigates to the issue form page (issuepage.dart)
        onPressed: () => Navigator.pushNamed(context, '/issue-form'),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Report an Issue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
        ),
      ),
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
              height: 160,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                      children: [
                        _buildTrendingCard(
                            title: 'Potholes',
                            subtitle: '12 Active',
                            icon: Icons.remove_road,
                            gradientColors: [const Color(0xFFFFA726), const Color(0xFFFB8C00)]
                        ),
                        _buildTrendingCard(
                            title: 'Lights Out',
                            subtitle: '8 Active',
                            icon: Icons.lightbulb_outline,
                            gradientColors: [const Color(0xFFFFEE58), const Color(0xFFFFD54F)]
                        ),
                        _buildTrendingCard(
                            title: 'Garbage',
                            subtitle: '5 Active',
                            icon: Icons.delete_outline,
                            gradientColors: [const Color(0xFF66BB6A), const Color(0xFF4CAF50)]
                        )
                      ]
                  )
              )
          )
        ]
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradientColors,
  }) {
    return Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: gradientColors[1].withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 5)
              )
            ]
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(subtitle, style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 12))
                  ]
              )
            ]
        )
    );
  }

  Widget _buildNearbyReports() {
    return _buildSectionCard(
        title: 'Nearby Reports',
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMapStatus('Pothole', Colors.red.shade400),
              _buildMapStatus('Light Out', Colors.yellow.shade600),
              _buildMapStatus('Resolved', Colors.green.shade400)
            ]
        )
    );
  }

  Widget _buildMapStatus(String label, Color color) {
    return Column(
        children: [
          Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color)
          ),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.poppins(fontSize: 12))
        ]
    );
  }

  Widget _buildRecentUpdates() {
    return _buildSectionCard(
        title: 'Recent Updates',
        child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                  child: Text('Pothole on Main St resolved! • 2 hours ago', style: GoogleFonts.poppins())
              )
            ]
        )
    );
  }

  Widget _buildCommunityImpact() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.yellow.shade100, Colors.green.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Community Impact', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Together we\'ve resolved', style: GoogleFonts.poppins(color: Colors.grey[700])),
              const SizedBox(height: 8),
              Text('247 issues', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue.shade800))
            ]
        )
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5
              )
            ]
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              child
            ]
        )
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
import 'package:civic_connect/chat_popup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Already on home page
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/community');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/member');
    }
  }

  void _showChatPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const ChatPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'CC',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          'CivicConnect',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.send_outlined, color: Colors.black, size: 26),
                onPressed: _showChatPopup,
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildReportButton(),
              const SizedBox(height: 24),
              _buildTrendingIssues(),
              const SizedBox(height: 24),
              _buildNearbyReports(),
              const SizedBox(height: 24),
              _buildRecentUpdates(),
              const SizedBox(height: 24),
              _buildCommunityImpact(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/report-issue'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white,),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello User!', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
        Text('Ready to improve your city today?', style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildReportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, '/issue-form'),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Report an Issue', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
        ),
      ),
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
              height: 160,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                      children: [
                        _buildTrendingCard(
                            title: 'Potholes',
                            subtitle: '12 Active',
                            icon: Icons.remove_road,
                            gradientColors: [const Color(0xFFFFA726), const Color(0xFFFB8C00)]
                        ),
                        _buildTrendingCard(
                            title: 'Lights Out',
                            subtitle: '8 Active',
                            icon: Icons.lightbulb_outline,
                            gradientColors: [const Color(0xFFFFEE58), const Color(0xFFFFD54F)]
                        ),
                        _buildTrendingCard(
                            title: 'Garbage',
                            subtitle: '5 Active',
                            icon: Icons.delete_outline,
                            gradientColors: [const Color(0xFF66BB6A), const Color(0xFF4CAF50)]
                        )
                      ]
                  )
              )
          )
        ]
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradientColors,
  }) {
    return Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: gradientColors[1].withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 5)
              )
            ]
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(subtitle, style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 12))
                  ]
              )
            ]
        )
    );
  }

  Widget _buildNearbyReports() {
    return _buildSectionCard(
        title: 'Nearby Reports',
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMapStatus('Pothole', Colors.red.shade400),
              _buildMapStatus('Light Out', Colors.yellow.shade600),
              _buildMapStatus('Resolved', Colors.green.shade400)
            ]
        )
    );
  }

  Widget _buildMapStatus(String label, Color color) {
    return Column(
        children: [
          Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color)
          ),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.poppins(fontSize: 12))
        ]
    );
  }

  Widget _buildRecentUpdates() {
    return _buildSectionCard(
        title: 'Recent Updates',
        child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                  child: Text('Pothole on Main St resolved! • 2 hours ago', style: GoogleFonts.poppins())
              )
            ]
        )
    );
  }

  Widget _buildCommunityImpact() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.yellow.shade100, Colors.green.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Community Impact', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Together we\'ve resolved', style: GoogleFonts.poppins(color: Colors.grey[700])),
              const SizedBox(height: 8),
              Text('247 issues', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue.shade800))
            ]
        )
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5
              )
            ]
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              child
            ]
        )
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
}
