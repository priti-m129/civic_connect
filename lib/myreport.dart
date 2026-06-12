/*
// lib/my_reports_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A simple data model for a report
class Report {
  final String title;
  final String location;
  final String date;
  final String description;
  final String status;
  final IconData icon;
  final Color iconBgColor;

  Report({
    required this.title,
    required this.location,
    required this.date,
    required this.description,
    required this.status,
    required this.icon,
    required this.iconBgColor,
  });
}

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({Key? key}) : super(key: key);

  @override
  _MyReportsPageState createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  final List<Report> _reports = [
    Report(title: 'Pothole on Main Street', location: 'Near City Hall', date: 'Dec 15, 2024', description: 'Large pothole causing traffic issues. Reported with photos.', status: 'Fixed', icon: Icons.remove_road, iconBgColor: Colors.green.shade100),
    Report(title: 'Broken Streetlight', location: 'Oak Avenue', date: 'Dec 14, 2024', description: 'Streetlight not working, area is very dark at night.', status: 'Working', icon: Icons.lightbulb_outline, iconBgColor: Colors.orange.shade100),
    Report(title: 'Graffiti Removal', location: 'Park Entrance', date: 'Dec 12, 2024', description: 'Graffiti on park entrance sign needs cleaning.', status: 'Review', icon: Icons.format_paint, iconBgColor: Colors.blue.shade100),
    Report(title: 'Missing Stop Sign', location: 'Elm & 3rd Street', date: 'Dec 10, 2024', description: 'Stop sign was knocked down, creating safety hazard.', status: 'Fixed', icon: Icons.traffic, iconBgColor: Colors.green.shade100),
    Report(title: 'Fallen Tree Branch', location: 'Maple Street', date: 'Dec 8, 2024', description: 'Large branch blocking sidewalk after storm.', status: 'Working', icon: Icons.park, iconBgColor: Colors.orange.shade100),
  ];

  String _activeFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reports', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/report-issue');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 24),
          _buildFilterButtons(),
          const SizedBox(height: 16),
          ..._reports.map((report) => _buildReportCard(report)).toList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      // ✅ FIX: Removed the 'const' keyword from the Row below
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryStat('6', 'Total Reports'),
          _buildSummaryStat('3', 'Resolved'),
          _buildSummaryStat('3', 'In Progress'),
        ],
      ),
    );
  }

  static Widget _buildSummaryStat(String count, String label) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterChip('All (6)'),
        _buildFilterChip('Active (3)'),
        _buildFilterChip('Resolved (3)'),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _activeFilter == label.split(' ')[0];
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _activeFilter = label.split(' ')[0];
          });
        }
      },
      selectedColor: Colors.blue.shade800,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      backgroundColor: Colors.grey.shade200,
      shape: StadiumBorder(side: BorderSide(color: isSelected ? Colors.blue.shade800 : Colors.grey.shade300)),
    );
  }

  Widget _buildReportCard(Report report) {
    Color statusColor = switch (report.status) {
      'Fixed' => Colors.green,
      'Working' => Colors.orange,
      'Review' => Colors.blue,
      _ => Colors.grey,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: report.iconBgColor, child: Icon(report.icon, color: Colors.black54)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(report.title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${report.location} • ${report.date}', style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(report.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(report.description, style: GoogleFonts.poppins()),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('View Details')),
                if (report.status != 'Fixed') const SizedBox(width: 8),
                if (report.status != 'Fixed') ElevatedButton(onPressed: () {}, child: const Text('Add Update')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
// lib/my_reports_page.dart

/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A simple data model for a report
class Report {
  final String id;
  final String title;
  final String location;
  final String date;
  final String description;
  final String status;
  final IconData icon;
  final Color iconBgColor;
  final List<String> updates;

  Report({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.description,
    required this.status,
    required this.icon,
    required this.iconBgColor,
    this.updates = const [],
  });

  Report copyWith({
    String? id,
    String? title,
    String? location,
    String? date,
    String? description,
    String? status,
    IconData? icon,
    Color? iconBgColor,
    List<String>? updates,
  }) {
    return Report(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      date: date ?? this.date,
      description: description ?? this.description,
      status: status ?? this.status,
      icon: icon ?? this.icon,
      iconBgColor: iconBgColor ?? this.iconBgColor,
      updates: updates ?? this.updates,
    );
  }
}

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({Key? key}) : super(key: key);

  @override
  _MyReportsPageState createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  List<Report> _reports = [
    Report(
      id: '1',
      title: 'Pothole on Main Street',
      location: 'Near City Hall',
      date: 'Dec 15, 2024',
      description: 'Large pothole causing traffic issues. Reported with photos.',
      status: 'Fixed',
      icon: Icons.remove_road,
      iconBgColor: Colors.green.shade100,
      updates: ['Report submitted', 'Under review', 'Work crew assigned', 'Repair completed'],
    ),
    Report(
      id: '2',
      title: 'Broken Streetlight',
      location: 'Oak Avenue',
      date: 'Dec 14, 2024',
      description: 'Streetlight not working, area is very dark at night.',
      status: 'Working',
      icon: Icons.lightbulb_outline,
      iconBgColor: Colors.orange.shade100,
      updates: ['Report submitted', 'Under review', 'Work crew assigned'],
    ),
    Report(
      id: '3',
      title: 'Graffiti Removal',
      location: 'Park Entrance',
      date: 'Dec 12, 2024',
      description: 'Graffiti on park entrance sign needs cleaning.',
      status: 'Review',
      icon: Icons.format_paint,
      iconBgColor: Colors.blue.shade100,
      updates: ['Report submitted', 'Under review'],
    ),
    Report(
      id: '4',
      title: 'Missing Stop Sign',
      location: 'Elm & 3rd Street',
      date: 'Dec 10, 2024',
      description: 'Stop sign was knocked down, creating safety hazard.',
      status: 'Fixed',
      icon: Icons.traffic,
      iconBgColor: Colors.green.shade100,
      updates: ['Report submitted', 'Emergency priority assigned', 'Sign replaced'],
    ),
    Report(
      id: '5',
      title: 'Fallen Tree Branch',
      location: 'Maple Street',
      date: 'Dec 8, 2024',
      description: 'Large branch blocking sidewalk after storm.',
      status: 'Working',
      icon: Icons.park,
      iconBgColor: Colors.orange.shade100,
      updates: ['Report submitted', 'Parks department notified', 'Removal scheduled'],
    ),
  ];

  String _activeFilter = 'All';
  int _selectedIndex = 1; // Default to My Reports tab (index 1)

  List<Report> get _filteredReports {
    switch (_activeFilter) {
      case 'Active':
        return _reports.where((report) => report.status != 'Fixed').toList();
      case 'Resolved':
        return _reports.where((report) => report.status == 'Fixed').toList();
      default:
        return _reports;
    }
  }

  int get _totalReports => _reports.length;
  int get _resolvedReports => _reports.where((report) => report.status == 'Fixed').length;
  int get _inProgressReports => _reports.where((report) => report.status != 'Fixed').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'My Reports',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 26),
            onPressed: () {
              Navigator.pushNamed(context, '/report-issue');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 24),
          _buildFilterButtons(),
          const SizedBox(height: 16),
          ..._filteredReports.map((report) => _buildReportCard(report)).toList(),
          if (_filteredReports.isEmpty) _buildEmptyState(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/report-issue'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      tooltip: label,
    );
  }

  void _onItemTapped(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    // Index 1 is the current page, so do nothing
    if (index == 2) Navigator.pushReplacementNamed(context, '/community');
    // if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryStat(_totalReports.toString(), 'Total Reports'),
          _buildSummaryStat(_resolvedReports.toString(), 'Resolved'),
          _buildSummaryStat(_inProgressReports.toString(), 'In Progress'),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterChip('All ($_totalReports)'),
        _buildFilterChip('Active ($_inProgressReports)'),
        _buildFilterChip('Resolved ($_resolvedReports)'),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final String filterKey = label.split(' ')[0];
    final bool isSelected = _activeFilter == filterKey;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _activeFilter = filterKey;
          });
        }
      },
      selectedColor: Colors.blue.shade800,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontSize: 12,
      ),
      backgroundColor: Colors.grey.shade200,
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? Colors.blue.shade800 : Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No reports found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No reports match the current filter',
              style: GoogleFonts.poppins(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(Report report) {
    Color statusColor = switch (report.status) {
      'Fixed' => Colors.green,
      'Working' => Colors.orange,
      'Review' => Colors.blue,
      _ => Colors.grey,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: report.iconBgColor,
                  child: Icon(report.icon, color: Colors.black54),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${report.location} • ${report.date}',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    report.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              report.description,
              style: GoogleFonts.poppins(),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _showReportDetails(report),
                  child: Text(
                    'View Details',
                    style: GoogleFonts.poppins(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (report.status != 'Fixed') const SizedBox(width: 8),
                if (report.status != 'Fixed')
                  ElevatedButton(
                    onPressed: () => _showAddUpdateDialog(report),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add Update',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showReportDetails(Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: report.iconBgColor,
                      child: Icon(report.icon, color: Colors.black54),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        report.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDetailRow('Location', report.location),
                _buildDetailRow('Date Reported', report.date),
                _buildDetailRow('Status', report.status),
                const SizedBox(height: 16),
                Text(
                  'Description',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  report.description,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Progress Updates',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ...report.updates.asMap().entries.map((entry) {
                  int index = entry.key;
                  String update = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${index + 1}. $update',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Close',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddUpdateDialog(Report report) {
    final TextEditingController updateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Add Update',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add additional information or updates about this report:',
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: updateController,
                decoration: InputDecoration(
                  hintText: 'Enter your update...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue.shade600),
                  ),
                ),
                maxLines: 3,
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (updateController.text.trim().isNotEmpty) {
                  _addUpdateToReport(report.id, updateController.text.trim());
                  Navigator.of(context).pop();
                  _showUpdateConfirmation();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addUpdateToReport(String reportId, String update) {
    setState(() {
      final reportIndex = _reports.indexWhere((report) => report.id == reportId);
      if (reportIndex != -1) {
        final existingReport = _reports[reportIndex];
        final updatedReport = existingReport.copyWith(
          updates: [...existingReport.updates, update],
        );
        _reports[reportIndex] = updatedReport;
      }
    });
  }

  void _showUpdateConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Update added successfully!',
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A simple data model for a report
class Report {
  final String id;
  final String title;
  final String location;
  final String date;
  final String description;
  final String status;
  final IconData icon;
  final Color iconBgColor;
  final List<String> updates;

  Report({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.description,
    required this.status,
    required this.icon,
    required this.iconBgColor,
    this.updates = const [],
  });

  Report copyWith({
    String? id,
    String? title,
    String? location,
    String? date,
    String? description,
    String? status,
    IconData? icon,
    Color? iconBgColor,
    List<String>? updates,
  }) {
    return Report(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      date: date ?? this.date,
      description: description ?? this.description,
      status: status ?? this.status,
      icon: icon ?? this.icon,
      iconBgColor: iconBgColor ?? this.iconBgColor,
      updates: updates ?? this.updates,
    );
  }
}

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({Key? key}) : super(key: key);

  @override
  _MyReportsPageState createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  List<Report> _reports = [
    Report(
      id: '1',
      title: 'Pothole on Main Street',
      location: 'Near City Hall',
      date: 'Dec 15, 2024',
      description: 'Large pothole causing traffic issues. Reported with photos.',
      status: 'Fixed',
      icon: Icons.remove_road,
      iconBgColor: Colors.green.shade100,
      updates: ['Report submitted', 'Under review', 'Work crew assigned', 'Repair completed'],
    ),
    Report(
      id: '2',
      title: 'Broken Streetlight',
      location: 'Oak Avenue',
      date: 'Dec 14, 2024',
      description: 'Streetlight not working, area is very dark at night.',
      status: 'Working',
      icon: Icons.lightbulb_outline,
      iconBgColor: Colors.orange.shade100,
      updates: ['Report submitted', 'Under review', 'Work crew assigned'],
    ),
    Report(
      id: '3',
      title: 'Graffiti Removal',
      location: 'Park Entrance',
      date: 'Dec 12, 2024',
      description: 'Graffiti on park entrance sign needs cleaning.',
      status: 'Review',
      icon: Icons.format_paint,
      iconBgColor: Colors.blue.shade100,
      updates: ['Report submitted', 'Under review'],
    ),
    Report(
      id: '4',
      title: 'Missing Stop Sign',
      location: 'Elm & 3rd Street',
      date: 'Dec 10, 2024',
      description: 'Stop sign was knocked down, creating safety hazard.',
      status: 'Fixed',
      icon: Icons.traffic,
      iconBgColor: Colors.green.shade100,
      updates: ['Report submitted', 'Emergency priority assigned', 'Sign replaced'],
    ),
    Report(
      id: '5',
      title: 'Fallen Tree Branch',
      location: 'Maple Street',
      date: 'Dec 8, 2024',
      description: 'Large branch blocking sidewalk after storm.',
      status: 'Working',
      icon: Icons.park,
      iconBgColor: Colors.orange.shade100,
      updates: ['Report submitted', 'Parks department notified', 'Removal scheduled'],
    ),
  ];

  String _activeFilter = 'All';
  int _selectedIndex = 1; // Default to My Reports tab (index 1)

  List<Report> get _filteredReports {
    switch (_activeFilter) {
      case 'Active':
        return _reports.where((report) => report.status != 'Fixed').toList();
      case 'Resolved':
        return _reports.where((report) => report.status == 'Fixed').toList();
      default:
        return _reports;
    }
  }

  int get _totalReports => _reports.length;
  int get _resolvedReports => _reports.where((report) => report.status == 'Fixed').length;
  int get _inProgressReports => _reports.where((report) => report.status != 'Fixed').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'My Reports',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 26),
            onPressed: () {
              Navigator.pushNamed(context, '/report-issue');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 24),
          _buildFilterButtons(),
          const SizedBox(height: 16),
          ..._filteredReports.map((report) => _buildReportCard(report)).toList(),
          if (_filteredReports.isEmpty) _buildEmptyState(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/report-issue'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      tooltip: label,
    );
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      // Already on My Reports page
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 2) {
      Navigator.pushNamed(context, '/community');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/member');
    }
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryStat(_totalReports.toString(), 'Total Reports'),
          _buildSummaryStat(_resolvedReports.toString(), 'Resolved'),
          _buildSummaryStat(_inProgressReports.toString(), 'In Progress'),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterChip('All ($_totalReports)'),
        _buildFilterChip('Active ($_inProgressReports)'),
        _buildFilterChip('Resolved ($_resolvedReports)'),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final String filterKey = label.split(' ')[0];
    final bool isSelected = _activeFilter == filterKey;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _activeFilter = filterKey;
          });
        }
      },
      selectedColor: Colors.blue.shade800,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontSize: 12,
      ),
      backgroundColor: Colors.grey.shade200,
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? Colors.blue.shade800 : Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No reports found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No reports match the current filter',
              style: GoogleFonts.poppins(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(Report report) {
    Color statusColor = switch (report.status) {
      'Fixed' => Colors.green,
      'Working' => Colors.orange,
      'Review' => Colors.blue,
      _ => Colors.grey,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: report.iconBgColor,
                  child: Icon(report.icon, color: Colors.black54),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${report.location} • ${report.date}',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    report.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              report.description,
              style: GoogleFonts.poppins(),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _showReportDetails(report),
                  child: Text(
                    'View Details',
                    style: GoogleFonts.poppins(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (report.status != 'Fixed') const SizedBox(width: 8),
                if (report.status != 'Fixed')
                  ElevatedButton(
                    onPressed: () => _showAddUpdateDialog(report),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add Update',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showReportDetails(Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: report.iconBgColor,
                      child: Icon(report.icon, color: Colors.black54),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        report.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDetailRow('Location', report.location),
                _buildDetailRow('Date Reported', report.date),
                _buildDetailRow('Status', report.status),
                const SizedBox(height: 16),
                Text(
                  'Description',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  report.description,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Progress Updates',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ...report.updates.asMap().entries.map((entry) {
                  int index = entry.key;
                  String update = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${index + 1}. $update',
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Close',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddUpdateDialog(Report report) {
    final TextEditingController updateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Add Update',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add additional information or updates about this report:',
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: updateController,
                decoration: InputDecoration(
                  hintText: 'Enter your update...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue.shade600),
                  ),
                ),
                maxLines: 3,
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (updateController.text.trim().isNotEmpty) {
                  _addUpdateToReport(report.id, updateController.text.trim());
                  Navigator.of(context).pop();
                  _showUpdateConfirmation();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addUpdateToReport(String reportId, String update) {
    setState(() {
      final reportIndex = _reports.indexWhere((report) => report.id == reportId);
      if (reportIndex != -1) {
        final existingReport = _reports[reportIndex];
        final updatedReport = existingReport.copyWith(
          updates: [...existingReport.updates, update],
        );
        _reports[reportIndex] = updatedReport;
      }
    });
  }

  void _showUpdateConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Update added successfully!',
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
