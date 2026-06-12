import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _selectedTab = 'All';
  List<NotificationItem> _notifications = [
    NotificationItem(
      icon: Icons.check_circle,
      iconColor: Colors.green,
      iconBg: Colors.green.shade100,
      title: 'Issue Status Updated',
      subtitle: 'Pothole on Main Street moved to "In Progress"',
      time: '2 hours ago',
      isUnread: true,
      category: 'Updates',
    ),
    NotificationItem(
      icon: Icons.favorite,
      iconColor: Colors.red,
      iconBg: Colors.red.shade100,
      title: 'New Support Received',
      subtitle: '5 more members supported your streetlight request',
      time: '4 hours ago',
      isUnread: true,
      category: 'Community',
    ),
    NotificationItem(
      icon: Icons.star,
      iconColor: Colors.orange,
      iconBg: Colors.yellow.shade100,
      title: 'Achievement Unlocked!',
      subtitle: '🏆 "Community Champion" - 10 issues reported!',
      time: '6 hours ago',
      isUnread: false,
      isNew: true,
      category: 'Updates',
    ),
    NotificationItem(
      icon: Icons.comment,
      iconColor: Colors.blue,
      iconBg: Colors.blue.shade100,
      title: 'Official Response',
      subtitle: 'City Public Works updated your streetlight report',
      time: 'Yesterday, 3:30 PM',
      isUnread: true,
      category: 'Updates',
    ),
    NotificationItem(
      icon: null,
      iconColor: Colors.blue,
      iconBg: Colors.blue.shade100,
      title: 'New Comment',
      subtitle: 'Community User commented on sidewalk crack',
      time: 'Yesterday, 11:15 AM',
      isUnread: false,
      customIcon: 'CU',
      category: 'Community',
    ),
    NotificationItem(
      icon: Icons.check_circle,
      iconColor: Colors.green,
      iconBg: Colors.green.shade100,
      title: 'Issue Resolved',
      subtitle: 'Park bench repair completed successfully',
      time: '3 days ago',
      isUnread: false,
      category: 'Updates',
    ),
    NotificationItem(
      icon: Icons.bar_chart,
      iconColor: Colors.blue,
      iconBg: Colors.blue.shade100,
      title: 'Weekly Impact Summary',
      subtitle: '3 reports, 12 supports, 2 resolved issues',
      time: '5 days ago',
      isUnread: false,
      category: 'Updates',
    ),
    NotificationItem(
      icon: Icons.verified,
      iconColor: Colors.green,
      iconBg: Colors.green.shade100,
      title: 'Resolution Certificate',
      subtitle: '🏅 Your park bench repair certificate is ready',
      time: 'Tap to view and download',
      isUnread: false,
      hasAction: true,
      actionText: 'View',
      category: 'Updates',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              'Notifications',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              'Mark all read',
              style: GoogleFonts.poppins(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Activity',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._getFilteredNotifications().map((notification) =>
                        _buildNotificationItem(notification)).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem('All'),
          _buildTabItem('Updates'),
          _buildTabItem('Community'),
        ],
      ),
    );
  }

  Widget _buildTabItem(String tab) {
    final bool isSelected = _selectedTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = tab;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)]
                : null,
          ),
          child: Text(
            tab,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return GestureDetector(
      onTap: () => _handleNotificationTap(notification),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isNew ? Colors.yellow.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: notification.isNew
              ? Border.all(color: Colors.yellow.shade300, width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon or Avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: notification.iconBg,
                shape: BoxShape.circle,
              ),
              child: notification.customIcon != null
                  ? Center(
                child: Text(
                  notification.customIcon!,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: notification.iconColor,
                  ),
                ),
              )
                  : Icon(
                notification.icon,
                color: notification.iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.time,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            // Right side indicators
            Column(
              children: [
                if (notification.isUnread)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                if (notification.isNew)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'New',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (notification.hasAction)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notification.actionText!,
                      style: GoogleFonts.poppins(
                        color: Colors.green.shade700,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
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

  List<NotificationItem> _getFilteredNotifications() {
    if (_selectedTab == 'All') {
      return _notifications;
    }
    return _notifications.where((n) => n.category == _selectedTab).toList();
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isUnread = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read')),
    );
  }

  void _handleNotificationTap(NotificationItem notification) {
    setState(() {
      notification.isUnread = false;
    });

    if (notification.hasAction) {
      if (notification.title.contains('Certificate')) {
        _showCertificateDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opened: ${notification.title}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Viewing: ${notification.title}')),
      );
    }
  }

  void _showCertificateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Resolution Certificate',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                'Your park bench repair certificate is ready for download.',
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Certificate downloaded!')),
                );
              },
              child: Text('Download', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }
}

class NotificationItem {
  final IconData? icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String time;
  bool isUnread;
  final bool isNew;
  final bool hasAction;
  final String? actionText;
  final String? customIcon;
  final String category;

  NotificationItem({
    this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isUnread = false,
    this.isNew = false,
    this.hasAction = false,
    this.actionText,
    this.customIcon,
    required this.category,
  });
}