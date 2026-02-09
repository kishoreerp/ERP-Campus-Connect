import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StaffAnnouncementSubjectScreen extends StatefulWidget {
  final String subject;
  final String code;
  final String year;


  const StaffAnnouncementSubjectScreen({
    super.key,
    required this.subject,
    required this.code,
    required this.year,
  });


  @override
  State<StaffAnnouncementSubjectScreen> createState() =>
      _StaffAnnouncementSubjectScreenState();
}


class _StaffAnnouncementSubjectScreenState
    extends State<StaffAnnouncementSubjectScreen> {
  String? selectedType;
  final TextEditingController contentController = TextEditingController();


  /// -------- ANNOUNCEMENT LIST (UI ONLY) --------
  final List<Map<String, String>> announcements = [
    {
      'tag': 'Assignment',
      'title': 'Submit assignment on Binary Trees by Friday',
      'date': '2024-01-15',
      'time': '10:00 AM',
    },
    {
      'tag': 'Class Test',
      'title': 'Class test on Linked Lists and Stacks on Monday',
      'date': '2024-01-12',
      'time': '09:30 AM',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.subject,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, color: Colors.black)),
            Text('${widget.code} • ${widget.year}',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            /// ---------- MAKE ANNOUNCEMENT ----------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('+ Make Announcement',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),


                  Text('Announcement Type',
                      style: GoogleFonts.inter(fontSize: 13)),
                  const SizedBox(height: 6),


                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text('Select type'),
                        value: selectedType,
                        items: const [
                          DropdownMenuItem(
                              value: 'Assignment',
                              child: Text('Assignment')),
                          DropdownMenuItem(
                              value: 'Class Test',
                              child: Text('Class Test')),
                          DropdownMenuItem(
                              value: 'CW Work',
                              child: Text('CW Work')),
                          DropdownMenuItem(
                              value: 'HW Work',
                              child: Text('HW Work')),
                          DropdownMenuItem(
                              value: 'Other',
                              child: Text('Other')),
                        ],
                        onChanged: (val) {
                          setState(() => selectedType = val);
                        },
                      ),
                    ),
                  ),


                  const SizedBox(height: 12),


                  Text('Announcement Content',
                      style: GoogleFonts.inter(fontSize: 13)),
                  const SizedBox(height: 6),


                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: contentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Write your announcement here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),


                  const SizedBox(height: 14),


                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Announcement posted (UI only)'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('Make Announcement'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 242, 239, 242),
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 20),


            /// ---------- PREVIOUS ANNOUNCEMENTS ----------
            Text('Previous Announcements',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),


            if (announcements.isEmpty)
              Text('No announcements',
                  style: GoogleFonts.inter(color: Colors.grey)),


            ...announcements.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;


              return _announcementTile(
                tag: item['tag']!,
                title: item['title']!,
                date: item['date']!,
                time: item['time']!,
                onDelete: () {
                  setState(() {
                    announcements.removeAt(index);
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }


  Widget _announcementTile({
    required String tag,
    required String title,
    required String date,
    required String time,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(tag,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: Colors.orange)),
              ),
              InkWell(
                onTap: onDelete,
                child: const Icon(Icons.delete_outline,
                    color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(title,
              style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14),
              const SizedBox(width: 6),
              Text(date, style: GoogleFonts.inter(fontSize: 12)),
              const SizedBox(width: 12),
              const Icon(Icons.access_time, size: 14),
              const SizedBox(width: 6),
              Text(time, style: GoogleFonts.inter(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
