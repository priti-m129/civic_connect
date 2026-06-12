
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default to Community tab (index 2)
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/my-reports');
    // Index 2 is the current page, so do nothing
    // if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'https://images.unsplash.com/photo-1519994999292-5e6f2f5ea25f?q=80&w=2074&auto=format&fit=crop',
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?q=80&w=2070&auto=format&fit=crop',
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://images.unsplash.com/photo-1620155232732-676b5b4a4a5c?q=80&w=2070&auto=format&fit=crop',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comments for ${post.username}\'s post'),
        content: const Text('Comments feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
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

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        // In a real app, you would fetch new data from your backend here
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(), // This method is now defined below
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
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
      tooltip: label,
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTrendingCard(title: 'Road Issues', subtitle: '15 reports in last 2 hours', icon: Icons.remove_road, color: Colors.red.shade400, status: 'HOT'),
        const SizedBox(height: 12),
        _buildTrendingCard(title: 'Streetlights', subtitle: '8 reports today', icon: Icons.lightbulb_outline, color: Colors.orange.shade400, status: 'WARM'),
      ],
    );
  }

  Widget _buildTrendingCard({ required String title, required String subtitle, required IconData icon, required Color color, required String status }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Text(status, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Add category widgets here
        const Text("Category widgets coming soon!")
      ],
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City Impact Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _loadSamplePosts();
              },
              child: Text('Refresh', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({ required IconData icon, required Color iconColor, required Color iconBg, required String title, required String subtitle, required Widget actionWidget, }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            )
        ),
        actionWidget,
      ],
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default to Community tab (index 2)
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/my-reports');
    // Index 2 is the current page, so do nothing
    // if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'https://images.unsplash.com/photo-1519994999292-5e6f2f5ea25f?q=80&w=2074&auto=format&fit=crop',
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?q=80&w=2070&auto=format&fit=crop',
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://images.unsplash.com/photo-1620155232732-676b5b4a4a5c?q=80&w=2070&auto=format&fit=crop',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comments for ${post.username}\'s post'),
        content: const Text('Comments feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
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

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        // In a real app, you would fetch new data from your backend here
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(), // This method is now defined below
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
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
      tooltip: label,
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTrendingCard(
          title: 'Road Issues',
          subtitle: '15 reports in last 2 hours',
          icon: Icons.construction,
          color: Colors.red.shade400,
          status: 'HOT',
          imageUrl: 'https://images.unsplash.com/photo-1609840114563-1de379210cea?q=80&w=400&auto=format&fit=crop', // Pothole image
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Streetlights',
          subtitle: '8 reports today',
          icon: Icons.traffic,
          color: Colors.orange.shade400,
          status: 'WARM',
          imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?q=80&w=400&auto=format&fit=crop', // Broken traffic light image
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Water Issues',
          subtitle: '5 reports today',
          icon: Icons.water_drop,
          color: Colors.blue.shade400,
          status: 'MILD',
          imageUrl: 'https://images.unsplash.com/photo-1581092160562-40aa08e78837?q=80&w=400&auto=format&fit=crop', // Water pipe issue
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String status,
    String? imageUrl,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image with overlay
            if (imageUrl != null)
              Positioned.fill(
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cacheWidth: 400, // Optimize memory usage
                      cacheHeight: 120, // Match container height
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: color,
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Image loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                    // Dark overlay for better text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.6),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Add category widgets here
        const Text("Category widgets coming soon!")
      ],
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City Impact Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _loadSamplePosts();
              },
              child: Text('Refresh', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget actionWidget,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            )
        ),
        actionWidget,
      ],
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default to Community tab (index 2)
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/my-reports');
    // Index 2 is the current page, so do nothing
    // if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'https://images.unsplash.com/photo-1519994999292-5e6f2f5ea25f?q=80&w=2074&auto=format&fit=crop',
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?q=80&w=2070&auto=format&fit=crop',
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://images.unsplash.com/photo-1620155232732-676b5b4a4a5c?q=80&w=2070&auto=format&fit=crop',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comments for ${post.username}\'s post'),
        content: const Text('Comments feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
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

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        // In a real app, you would fetch new data from your backend here
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(), // This method is now defined below
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
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
      tooltip: label,
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTrendingCard(
          title: 'Road Issues',
          subtitle: '15 reports in last 2 hours',
          icon: Icons.construction,
          color: Colors.red.shade400,
          status: 'HOT',
          imageUrl: 'https://images.unsplash.com/photo-1519994999292-5e6f2f5ea25f?q=60&w=200&auto=format&fit=crop', // Pothole damage
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Streetlights',
          subtitle: '8 reports today',
          icon: Icons.lightbulb_outline,
          color: Colors.orange.shade400,
          status: 'WARM',
          imageUrl: 'https://images.unsplash.com/photo-1547036967-23d11aacaee0?q=60&w=200&auto=format&fit=crop', // Broken street light
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Water Issues',
          subtitle: '5 reports today',
          icon: Icons.water_drop,
          color: Colors.blue.shade400,
          status: 'MILD',
          imageUrl: 'https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?q=60&w=200&auto=format&fit=crop', // Water leak/pipe
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Waste Management',
          subtitle: '3 reports today',
          icon: Icons.delete_outline,
          color: Colors.green.shade400,
          status: 'LOW',
          imageUrl: 'https://images.unsplash.com/photo-1586012135770-98d7ad5e2923?q=60&w=200&auto=format&fit=crop', // Garbage/waste
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String status,
    String? imageUrl,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image with overlay
            if (imageUrl != null)
              Positioned.fill(
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cacheWidth: 400, // Optimize memory usage
                      cacheHeight: 120, // Match container height
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: color,
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Image loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                    // Dark overlay for better text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.6),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Add category widgets here
        const Text("Category widgets coming soon!")
      ],
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City Impact Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _loadSamplePosts();
              },
              child: Text('Refresh', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget actionWidget,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            )
        ),
        actionWidget,
      ],
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default to Community tab (index 2)
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/my-reports');
    // Index 2 is the current page, so do nothing
    // if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'https://images.unsplash.com/photo-1519994999292-5e6f2f5ea25f?q=80&w=2074&auto=format&fit=crop',
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?q=80&w=1500&auto=format&fit=crop',
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://images.unsplash.com/photo-1620155232732-676b5b4a4a5c?q=80&w=2070&auto=format&fit=crop',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comments for ${post.username}\'s post'),
        content: const Text('Comments feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
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

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        // In a real app, you would fetch new data from your backend here
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(), // This method is now defined below
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
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
      tooltip: label,
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTrendingCard(
          title: 'Road Issues',
          subtitle: '15 reports in last 2 hours',
          icon: Icons.construction,
          color: Colors.red.shade400,
          status: 'HOT',
          imageUrl: 'https://images.unsplash.com/photo-1519994999292-5e6f2f5ea25f?q=60&w=200&auto=format&fit=crop', // Pothole damage
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Streetlights',
          subtitle: '8 reports today',
          icon: Icons.lightbulb_outline,
          color: Colors.orange.shade400,
          status: 'WARM',
          imageUrl: 'https://images.unsplash.com/photo-1547036967-23d11aacaee0?q=60&w=200&auto=format&fit=crop', // Broken street light
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Water Issues',
          subtitle: '5 reports today',
          icon: Icons.water_drop,
          color: Colors.blue.shade400,
          status: 'MILD',
          imageUrl: 'https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?q=60&w=200&auto=format&fit=crop', // Water leak/pipe
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Waste Management',
          subtitle: '3 reports today',
          icon: Icons.delete_outline,
          color: Colors.green.shade400,
          status: 'LOW',
          imageUrl: 'https://images.unsplash.com/photo-1586012135770-98d7ad5e2923?q=60&w=200&auto=format&fit=crop', // Garbage/waste
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String status,
    String? imageUrl,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image with overlay
            if (imageUrl != null)
              Positioned.fill(
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cacheWidth: 400, // Optimize memory usage
                      cacheHeight: 120, // Match container height
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: color,
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Image loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                    // Dark overlay for better text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.6),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Add category widgets here
        const Text("Category widgets coming soon!")
      ],
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City Impact Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _loadSamplePosts();
              },
              child: Text('Refresh', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget actionWidget,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            )
        ),
        actionWidget,
      ],
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default to Community tab (index 2)
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/my-reports');
    // Index 2 is the current page, so do nothing
    // if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'assets/images/pothole.png', // Using local asset
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'assets/images/streetlight.png', // Using local asset
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://images.unsplash.com/photo-1620155232732-676b5b4a4a5c?q=80&w=2070&auto=format&fit=crop',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comments for ${post.username}\'s post'),
        content: const Text('Comments feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
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

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        // In a real app, you would fetch new data from your backend here
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(), // This method is now defined below
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
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
      tooltip: label,
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTrendingCard(
          title: 'Road Issues',
          subtitle: '15 reports in last 2 hours',
          icon: Icons.construction,
          color: Colors.red.shade400,
          status: 'HOT',
          imageAsset: 'assets/images/pothole.png', // Using local asset
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Streetlights',
          subtitle: '8 reports today',
          icon: Icons.lightbulb_outline,
          color: Colors.orange.shade400,
          status: 'WARM',
          imageUrl: 'https://images.unsplash.com/photo-1547036967-23d11aacaee0?q=60&w=200&auto=format&fit=crop', // Broken street light
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Water Issues',
          subtitle: '5 reports today',
          icon: Icons.water_drop,
          color: Colors.blue.shade400,
          status: 'MILD',
          imageUrl: 'https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?q=60&w=200&auto=format&fit=crop', // Water leak/pipe
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Waste Management',
          subtitle: '3 reports today',
          icon: Icons.delete_outline,
          color: Colors.green.shade400,
          status: 'LOW',
          imageUrl: 'https://images.unsplash.com/photo-1586012135770-98d7ad5e2923?q=60&w=200&auto=format&fit=crop', // Garbage/waste
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String status,
    String? imageUrl,
    String? imageAsset,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image with overlay
            if (imageAsset != null || imageUrl != null)
              Positioned.fill(
                child: Stack(
                  children: [
                    // Use local asset if provided, otherwise use network image
                    imageAsset != null
                        ? Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        print('Asset loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    )
                        : Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cacheWidth: 400, // Optimize memory usage
                      cacheHeight: 120, // Match container height
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: color,
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Image loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                    // Dark overlay for better text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.6),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Add category widgets here
        const Text("Category widgets coming soon!")
      ],
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City Impact Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _loadSamplePosts();
              },
              child: Text('Refresh', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget actionWidget,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            )
        ),
        actionWidget,
      ],
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default to Community tab (index 2)
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/my-reports');
    // Index 2 is the current page, so do nothing
    // if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'assets/images/pothole.png', // Using local asset
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'assets/images/streetlight.png', // Using local streetlight asset
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://images.unsplash.com/photo-1620155232732-676b5b4a4a5c?q=80&w=2070&auto=format&fit=crop',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCommentsBottomSheet(post),
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.add_box, color: Colors.blue.shade700, size: 28),
            const SizedBox(width: 12),
            Text(
              'Create New Post',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: Text('Take Photo', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
                _showMessage('Camera feature coming soon!');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: Text('Choose from Gallery', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
                _showMessage('Gallery feature coming soon!');
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_problem, color: Colors.red),
              title: Text('Report Issue', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/report-issue');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.notifications, color: Colors.blue.shade700, size: 28),
            const SizedBox(width: 12),
            Text(
              'Notification Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNotificationToggle('Push Notifications', true),
            _buildNotificationToggle('Email Notifications', false),
            _buildNotificationToggle('Issue Updates', true),
            _buildNotificationToggle('Community News', true),
            _buildNotificationToggle('Trending Reports', false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Done',
              style: GoogleFonts.poppins(
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(String title, bool initialValue) {
    return StatefulBuilder(
      builder: (context, setState) => SwitchListTile(
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        value: initialValue,
        onChanged: (value) {
          setState(() {
            // Update the value - in a real app, save to preferences
          });
          _showMessage('${title} ${value ? 'enabled' : 'disabled'}');
        },
        activeColor: Colors.blue.shade600,
        dense: true,
      ),
    );
  }

  Widget _buildCommentsBottomSheet(Post post) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Comments',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${post.comments} comments',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Comments list
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 5, // Sample comments
                  itemBuilder: (context, index) => _buildCommentItem(index),
                ),
              ),

              // Comment input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        'You',
                        style: GoogleFonts.poppins(fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        _showMessage('Comment posted!');
                      },
                      icon: Icon(Icons.send, color: Colors.blue.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentItem(int index) {
    final sampleComments = [
      {'user': 'CityFixer', 'comment': 'I reported this too! Needs urgent fixing.', 'time': '2h'},
      {'user': 'SafetyFirst', 'comment': 'Thanks for reporting. This is really dangerous.', 'time': '1h'},
      {'user': 'LocalResident', 'comment': 'Finally someone noticed this issue!', 'time': '45m'},
      {'user': 'CommunityHelper', 'comment': 'I can help coordinate with local authorities.', 'time': '30m'},
      {'user': 'UrbanPlanner', 'comment': 'We need more reports like this. Great work!', 'time': '15m'},
    ];

    final comment = sampleComments[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              comment['user']![0],
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: '${comment['user']} ',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: comment['comment']),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment['time']!,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showMessage('Reply feature coming soon!'),
            icon: Icon(Icons.reply, size: 16, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins()),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _sharePost(Post post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Share Post',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(Icons.message, 'Message', () {
                  Navigator.pop(context);
                  _showMessage('Shared via Message!');
                }),
                _buildShareOption(Icons.copy, 'Copy Link', () {
                  Navigator.pop(context);
                  _showMessage('Link copied to clipboard!');
                }),
                _buildShareOption(Icons.share, 'More', () {
                  Navigator.pop(context);
                  _showMessage('Share options opened!');
                }),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue.shade700),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _savePost(String postId) {
    // In a real app, you would save to a database or local storage
    _showMessage('Post saved to your collection!');

    // You could add visual feedback by changing the bookmark icon
    setState(() {
      // Update saved posts list if you have one
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black, size: 26),
            onPressed: _showCreatePostDialog,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: _showNotificationSettings,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
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

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        // In a real app, you would fetch new data from your backend here
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
            onSharePressed: _sharePost,
            onSavePressed: _savePost,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(), // This method is now defined below
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
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
      tooltip: label,
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTrendingCard(
          title: 'Road Issues',
          subtitle: '15 reports in last 2 hours',
          icon: Icons.construction,
          color: Colors.red.shade400,
          status: 'HOT',
          imageAsset: 'assets/images/pothole.png', // Using local asset
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Streetlights',
          subtitle: '8 reports today',
          icon: Icons.lightbulb_outline,
          color: Colors.orange.shade400,
          status: 'WARM',
          imageUrl: 'https://images.unsplash.com/photo-1547036967-23d11aacaee0?q=60&w=200&auto=format&fit=crop', // Broken street light
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Water Issues',
          subtitle: '5 reports today',
          icon: Icons.water_drop,
          color: Colors.blue.shade400,
          status: 'MILD',
          imageUrl: 'https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?q=60&w=200&auto=format&fit=crop', // Water leak/pipe
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Waste Management',
          subtitle: '3 reports today',
          icon: Icons.delete_outline,
          color: Colors.green.shade400,
          status: 'LOW',
          imageUrl: 'https://images.unsplash.com/photo-1586012135770-98d7ad5e2923?q=60&w=200&auto=format&fit=crop', // Garbage/waste
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String status,
    String? imageUrl,
    String? imageAsset,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image with overlay
            if (imageAsset != null || imageUrl != null)
              Positioned.fill(
                child: Stack(
                  children: [
                    // Use local asset if provided, otherwise use network image
                    imageAsset != null
                        ? Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        print('Asset loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    )
                        : Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cacheWidth: 400, // Optimize memory usage
                      cacheHeight: 120, // Match container height
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: color,
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Image loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                    // Dark overlay for better text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.6),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Add category widgets here
        const Text("Category widgets coming soon!")
      ],
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City Impact Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _loadSamplePosts();
              },
              child: Text('Refresh', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget actionWidget,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            )
        ),
        actionWidget,
      ],
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default to Community tab (index 2)
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else if (index == 2) {
      // Already on Community page
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 3) {
      Navigator.pushNamed(context, '/member');
    }
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'assets/images/pothole.png', // Using local asset
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'assets/images/streetlight.png', // Using local streetlight asset
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://images.unsplash.com/photo-1620155232732-676b5b4a4a5c?q=80&w=2070&auto=format&fit=crop',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCommentsBottomSheet(post),
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.add_box, color: Colors.blue.shade700, size: 28),
            const SizedBox(width: 12),
            Text(
              'Create New Post',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: Text('Take Photo', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
                _showMessage('Camera feature coming soon!');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: Text('Choose from Gallery', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
                _showMessage('Gallery feature coming soon!');
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_problem, color: Colors.red),
              title: Text('Report Issue', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/report-issue');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.notifications, color: Colors.blue.shade700, size: 28),
            const SizedBox(width: 12),
            Text(
              'Notification Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNotificationToggle('Push Notifications', true),
            _buildNotificationToggle('Email Notifications', false),
            _buildNotificationToggle('Issue Updates', true),
            _buildNotificationToggle('Community News', true),
            _buildNotificationToggle('Trending Reports', false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Done',
              style: GoogleFonts.poppins(
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(String title, bool initialValue) {
    return StatefulBuilder(
      builder: (context, setState) => SwitchListTile(
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        value: initialValue,
        onChanged: (value) {
          setState(() {
            // Update the value - in a real app, save to preferences
          });
          _showMessage('${title} ${value ? 'enabled' : 'disabled'}');
        },
        activeColor: Colors.blue.shade600,
        dense: true,
      ),
    );
  }

  Widget _buildCommentsBottomSheet(Post post) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Comments',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${post.comments} comments',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Comments list
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 5, // Sample comments
                  itemBuilder: (context, index) => _buildCommentItem(index),
                ),
              ),

              // Comment input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        'You',
                        style: GoogleFonts.poppins(fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        _showMessage('Comment posted!');
                      },
                      icon: Icon(Icons.send, color: Colors.blue.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentItem(int index) {
    final sampleComments = [
      {'user': 'CityFixer', 'comment': 'I reported this too! Needs urgent fixing.', 'time': '2h'},
      {'user': 'SafetyFirst', 'comment': 'Thanks for reporting. This is really dangerous.', 'time': '1h'},
      {'user': 'LocalResident', 'comment': 'Finally someone noticed this issue!', 'time': '45m'},
      {'user': 'CommunityHelper', 'comment': 'I can help coordinate with local authorities.', 'time': '30m'},
      {'user': 'UrbanPlanner', 'comment': 'We need more reports like this. Great work!', 'time': '15m'},
    ];

    final comment = sampleComments[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              comment['user']![0],
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: '${comment['user']} ',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: comment['comment']),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment['time']!,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showMessage('Reply feature coming soon!'),
            icon: Icon(Icons.reply, size: 16, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins()),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _sharePost(Post post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Share Post',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(Icons.message, 'Message', () {
                  Navigator.pop(context);
                  _showMessage('Shared via Message!');
                }),
                _buildShareOption(Icons.copy, 'Copy Link', () {
                  Navigator.pop(context);
                  _showMessage('Link copied to clipboard!');
                }),
                _buildShareOption(Icons.share, 'More', () {
                  Navigator.pop(context);
                  _showMessage('Share options opened!');
                }),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue.shade700),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _savePost(String postId) {
    // In a real app, you would save to a database or local storage
    _showMessage('Post saved to your collection!');

    // You could add visual feedback by changing the bookmark icon
    setState(() {
      // Update saved posts list if you have one
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black, size: 26),
            onPressed: _showCreatePostDialog,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: _showNotificationSettings,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
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

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        // In a real app, you would fetch new data from your backend here
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
            onSharePressed: _sharePost,
            onSavePressed: _savePost,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
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
      tooltip: label,
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTrendingCard(
          title: 'Road Issues',
          subtitle: '15 reports in last 2 hours',
          icon: Icons.construction,
          color: Colors.red.shade400,
          status: 'HOT',
          imageAsset: 'assets/images/pothole.png', // Using local asset
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Streetlights',
          subtitle: '8 reports today',
          icon: Icons.lightbulb_outline,
          color: Colors.orange.shade400,
          status: 'WARM',
          imageUrl: 'https://images.unsplash.com/photo-1547036967-23d11aacaee0?q=60&w=200&auto=format&fit=crop', // Broken street light
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Water Issues',
          subtitle: '5 reports today',
          icon: Icons.water_drop,
          color: Colors.blue.shade400,
          status: 'MILD',
          imageUrl: 'https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?q=60&w=200&auto=format&fit=crop', // Water leak/pipe
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Waste Management',
          subtitle: '3 reports today',
          icon: Icons.delete_outline,
          color: Colors.green.shade400,
          status: 'LOW',
          imageUrl: 'https://images.unsplash.com/photo-1586012135770-98d7ad5e2923?q=60&w=200&auto=format&fit=crop', // Garbage/waste
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String status,
    String? imageUrl,
    String? imageAsset,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image with overlay
            if (imageAsset != null || imageUrl != null)
              Positioned.fill(
                child: Stack(
                  children: [
                    // Use local asset if provided, otherwise use network image
                    imageAsset != null
                        ? Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        print('Asset loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    )
                        : Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cacheWidth: 400, // Optimize memory usage
                      cacheHeight: 120, // Match container height
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: color,
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Image loading error: $error'); // Debug print
                        return Container(
                          color: color,
                          child: Center(
                            child: Icon(
                              icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                    // Dark overlay for better text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.6),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text("Category widgets coming soon!")
      ],
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City Impact Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _loadSamplePosts();
              },
              child: Text('Refresh', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget actionWidget,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            )
        ),
        actionWidget,
      ],
    );
  }
}