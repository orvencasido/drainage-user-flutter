import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportItem {
  final String title;
  final String location;
  final String dateTime;
  final String status; // 'In Progress', 'Resolved', 'Rejected'

  ReportItem({
    required this.title,
    required this.location,
    required this.dateTime,
    required this.status,
  });
}

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({super.key});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  String _selectedTab = 'All';

  final List<ReportItem> _reports = [
    ReportItem(
      title: 'Clogged Drain',
      location: 'Purok 2',
      dateTime: 'May 20, 2026  •  10:30 AM',
      status: 'In Progress',
    ),
    ReportItem(
      title: 'Flooded Street',
      location: 'Purok 1',
      dateTime: 'May 20, 2026  •  10:30 AM',
      status: 'Resolved',
    ),
    ReportItem(
      title: 'Broken Drain Cover',
      location: 'Purok 3',
      dateTime: 'May 20, 2026  •  10:30 AM',
      status: 'In Progress',
    ),
    ReportItem(
      title: 'Waste on Canal',
      location: 'Purok 4',
      dateTime: 'May 20, 2026  •  10:30 AM',
      status: 'Rejected',
    ),
    ReportItem(
      title: 'Clogged Drain',
      location: 'Purok 5',
      dateTime: 'May 20, 2026  •  10:30 AM',
      status: 'In Progress',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredReports = _selectedTab == 'All'
        ? _reports
        : _reports.where((r) => r.status == _selectedTab).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF38B6FF), // Blue top background
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: [
                  // Back Button (Black circle with white arrow)
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'My Reports',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),

            // White Content Body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F7FA), // Soft light background
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    // Tabs/Filters Row
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: ['All', 'In Progress', 'Resolved', 'Rejected']
                              .map((tab) => _buildTabItem(tab))
                              .toList(),
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: Colors.black12),

                    // Reports List
                    Expanded(
                      child: filteredReports.isEmpty
                          ? Center(
                              child: Text(
                                'No reports found for this filter.',
                                style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(20.0),
                              itemCount: filteredReports.length,
                              itemBuilder: (context, index) {
                                final report = filteredReports[index];
                                return _buildReportCard(report);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String tabName) {
    final isSelected = _selectedTab == tabName;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = tabName;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0066FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tabName,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Underline bar for selected tab
          Container(
            height: 3,
            width: 40,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0066FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(ReportItem report) {
    Color badgeBgColor;
    Color badgeTextColor;

    switch (report.status) {
      case 'Resolved':
        badgeBgColor = const Color(0xFFE2FBE9);
        badgeTextColor = const Color(0xFF10B981);
        break;
      case 'Rejected':
        badgeBgColor = const Color(0xFFFCE8E6);
        badgeTextColor = const Color(0xFFEF4444);
        break;
      case 'In Progress':
      default:
        badgeBgColor = const Color(0xFFFFEAD6);
        badgeTextColor = const Color(0xFFE67E22);
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image reused as requested
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/clogged_drain.png',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 14),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  report.location,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  report.dateTime,
                  style: GoogleFonts.poppins(
                    color: Colors.black38,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    report.status,
                    style: GoogleFonts.poppins(
                      color: badgeTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Colors.black54,
            size: 28,
          ),
        ],
      ),
    );
  }
}
