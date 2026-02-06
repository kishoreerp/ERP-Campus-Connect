import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagementAnnouncementScreen extends StatefulWidget {
  const ManagementAnnouncementScreen({super.key});

  @override
  State<ManagementAnnouncementScreen> createState() =>
      _ManagementAnnouncementScreenState();
}

class _ManagementAnnouncementScreenState
    extends State<ManagementAnnouncementScreen> {

  String priority = "High";
  String audience = "All Staff and Students";
  String selectedDate = "31 January 2026";

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController contentController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ---------------- HEADER ----------------
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Send Announcement",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("Create official circular",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey)),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Management Admin",
                        style: GoogleFonts.inter(fontSize: 12)),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- BLUE CARD ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.campaign,
                        size: 36, color: Colors.blue),

                    const SizedBox(height: 10),

                    Text("Official Announcement Circular",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600)),

                    const SizedBox(height: 4),

                    Text("ST. Lourdes Engineering College",
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ---------------- DETAILS CARD ----------------
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Announcement Details",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600)),

                    const SizedBox(height: 14),

                    // ---------- TITLE ----------
                    Text("Title / Subject *",
                        style: GoogleFonts.inter(fontSize: 12)),

                    const SizedBox(height: 6),

                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Enter announcement title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ---------- PRIORITY ----------
                    Text("Priority Level *",
                        style: GoogleFonts.inter(fontSize: 12)),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        priorityChip("High", Colors.red),
                        const SizedBox(width: 10),
                        priorityChip("Medium", Colors.orange),
                        const SizedBox(width: 10),
                        priorityChip("Low", Colors.green),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ---------- TARGET ----------
                    Text("Target Audience *",
                        style: GoogleFonts.inter(fontSize: 12)),

                    const SizedBox(height: 8),

                    audienceTile("All Staff and Students"),
                    audienceTile("All Staff Members"),
                    audienceTile("Teaching Staff Only"),
                    audienceTile("Non-Teaching Staff Only"),
                    audienceTile("All Students"),

                    const SizedBox(height: 18),

                    // ---------- CONTENT ----------
                    Text("Content / Message *",
                        style: GoogleFonts.inter(fontSize: 12)),

                    const SizedBox(height: 6),

                    TextField(
                      controller: contentController,
                      maxLines: 4,
                      onChanged: (v) => setState(() {}),
                      decoration: InputDecoration(
                        hintText:
                            "Enter the announcement content here...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "${contentController.text.length} characters",
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.grey),
                    ),

                    const SizedBox(height: 18),

                    // ---------- DATE ----------
                    Text("Date",
                        style: GoogleFonts.inter(fontSize: 12)),

                    const SizedBox(height: 6),

                    GestureDetector(
                      onTap: () async {
                        DateTime? picked =
                            await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2030),
                        );

                        if (picked != null) {
                          setState(() {
                            selectedDate =
                                "${picked.day} ${_monthName(picked.month)} ${picked.year}";
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius:
                              BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month,
                                size: 18),
                            const SizedBox(width: 8),
                            Text(selectedDate),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ---------- BUTTONS ----------
                    Row(
                      children: [

                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton.icon(
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.grey.shade700,
                              padding:
                                  const EdgeInsets.symmetric(
                                      vertical: 14),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                                Icons.remove_red_eye),
                            label:
                                const Text("Preview Circular"),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- PRIORITY CHIP ----------------
  Widget priorityChip(String text, Color color) {
    bool selected = priority == text;

    return GestureDetector(
      onTap: () {
        setState(() => priority = text);
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: selected ? Colors.white : color),
        ),
      ),
    );
  }

  // ---------------- AUDIENCE TILE ----------------
  Widget audienceTile(String text) {
    bool selected = audience == text;

    return GestureDetector(
      onTap: () {
        setState(() => audience = text);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  selected ? Colors.blue : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 8),
            const Icon(Icons.people_outline, size: 18),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}

// ---------------- MONTH HELPER ----------------
String _monthName(int m) {
  const months = [
    "January","February","March","April","May","June",
    "July","August","September","October","November","December"
  ];
  return months[m - 1];
}
