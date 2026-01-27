import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffEventsScreen extends StatelessWidget {
  const StaffEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Events',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              'View calendar and upcoming events',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- CALENDAR ----------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.chevron_left),
                      Text(
                        'January 2026',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  const SizedBox(height: 12),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 31,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      final day = index + 1;
                      final isSelected = day == 10;

                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$day',
                          style: GoogleFonts.inter(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ---------------- LEGEND ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendDot(Colors.blue, 'Event'),
                const SizedBox(width: 16),
                _legendDot(Colors.red, 'Exam'),
                const SizedBox(width: 16),
                _legendDot(Colors.green, 'Holiday'),
              ],
            ),

            const SizedBox(height: 24),

            // ---------------- UPCOMING EVENTS ----------------
            Text(
              'Upcoming Events',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            _eventTile(
              color: Colors.blue,
              title: 'Faculty Development Program',
              date: '2024-01-22',
              time: '10:00 AM',
              tag: 'Event',
            ),
            _eventTile(
              color: Colors.red,
              title: 'Mid-term Exam Starts',
              date: '2024-01-25',
              time: 'Full Day',
              tag: 'Exam',
            ),
            _eventTile(
              color: Colors.green,
              title: 'Republic Day Holiday',
              date: '2024-01-26',
              time: 'Closed',
              tag: 'Holiday',
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.inter(fontSize: 12)),
      ],
    );
  }

  Widget _eventTile({
    required Color color,
    required String title,
    required String date,
    required String time,
    required String tag,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.access_time,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              tag,
              style: GoogleFonts.inter(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
