// lib/screens/hod_portal/hod_home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'make_announcement_dialog.dart';
import 'hod_events_screen.dart';
import 'notification_dialog.dart';
import 'hod_notes_screen.dart';
import 'approvals_entry_dialog.dart';
import 'leave_dialogs.dart';
class HODHomeScreen extends StatelessWidget {
  final String username;
  const HODHomeScreen({super.key, required this.username});

  static const Color _gradStart = Color(0xFF8A2BE2);
  static const Color _gradEnd = Color(0xFF4A90E2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body starts at top (no AppBar to match screenshot)
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top gradient profile card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_gradStart, _gradEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, $username',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'HOD12345 • Head of Department',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.92),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Quick Actions title
              Text(
                'Quick Actions',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // 2x3 grid where each tile has icon centered above the label.
              // Icon and label remain black (as in your screenshot).
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.15,
                children: [
                  _quickTileCentered(
                    context,
                    icon: Icons.campaign_outlined,
                    label: 'Announcements',
                    onTap: () => showAnnouncementManagementDialog(context),
                  ),
                  _quickTileCentered(
                    context,
                    icon: Icons.event_note,
                    label: 'Events',
                    onTap: () {
                       Navigator.push(
                                   context,
                             MaterialPageRoute(
                             builder: (_) => HODEventsScreen(),
                            ),
                                 );
                    },
                  ),
                  _quickTileCentered(
                    context,
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () {
                       showNotificationsDialog(context);
                    },
                  ),
                  _quickTileCentered(
                    context,
                    icon: Icons.note_alt_outlined,
                    label: 'Notes',
                    onTap: () {
                     Navigator.push(
                      context,
                        MaterialPageRoute(
                       builder: (_) => const HODNotesScreen(),
                      ),
                       );
                    },
                  ),
                  _quickTileCentered(
                    context,
                    icon: Icons.approval,
                    label: 'Approvals',
                    onTap: () {
                     showApprovalsEntryDialog(context);
                    },
                  ),
                  _quickTileCentered(
                    context,
                    icon: Icons.calendar_month,
                    label: 'Request Leave',
                    onTap: () {  
                       showLeaveManagementDialog(context);
                     
                    },
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Recent Announcements header
              Text(
                'Recent Announcements',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Announcement cards (sample)
              _announcementCard(
                title: 'Department Meeting',
                subtitle: 'HOD meeting with all faculty on Friday at 3 PM',
                date: '2024-01-14',
                onTap: () {
                  // TODO: open announcement detail
                },
              ),
              const SizedBox(height: 12),
              _announcementCard(
                title: 'Exam Schedule',
                subtitle: 'Mid-term exam schedule has been published',
                date: '2024-01-13',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _announcementCard(
                title: 'Faculty Workshop',
                subtitle: 'Faculty development workshop next week',
                date: '2024-01-12',
                onTap: () {},
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  // centered small tile (icon above label)
  Widget _quickTileCentered(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade50, blurRadius: 6, offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon container white (icon itself black)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.black87, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // announcement card
  Widget _announcementCard({
    required String title,
    required String subtitle,
    required String date,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [BoxShadow(color: Colors.grey.shade50, blurRadius: 6, offset: const Offset(0, 3))],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title,
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
                  const SizedBox(height: 6),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700])),
                  const SizedBox(height: 8),
                  Text(date, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                ]),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade600),
            ],
          ),
        ),
      ),
    );
  }
}

/// Announcement Management dialog — matches your screenshot's popup appearance
Future<void> showAnnouncementManagementDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 24, offset: const Offset(0, 8)),
              ],
            ),
            child: Stack(
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 6),
                  Text('Announcement Management',
                      style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('Choose an option to manage department announcements.',
                      style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700]),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 18),

                  // Option 1
                  _announcementOptionTile(
                    icon: Icons.post_add_outlined,
                    iconColor: Colors.blue.shade700,
                    title: 'Make Announcement',
                    subtitle: 'Create a new announcement',
                    onTap: () {
                      Navigator.of(context).pop();
                       showDialog(context: context, builder: (_) => const MakeAnnouncementDialog());
                      // TODO: open Make Announcement screen/dialog here
                    },
                  ),

                  const SizedBox(height: 12),

                  // Option 2
                  _announcementOptionTile(
                    icon: Icons.edit_outlined,
                    iconColor: Colors.green.shade700,
                    title: 'Edit Announcements',
                    subtitle: 'View and edit existing announcements',
                    onTap: () {
                     Navigator.of(context).pop();
                      showManageAnnouncementsDialog(context);

                      // TODO: open Edit Announcements screen
                    },
                  ),

                  const SizedBox(height: 8),
                ]),

                // Close button (X) top-right
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2))],
                      ),
                      child: Icon(Icons.close, size: 18, color: Colors.grey[700]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// one option tile inside the announcement dialog
Widget _announcementOptionTile({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.grey.shade50, blurRadius: 6, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700])),
              ]),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    ),
  );
}
Future<void> showManageAnnouncementsDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => const _ManageAnnouncementsDialog(),
  );
}

class _ManageAnnouncementsDialog extends StatelessWidget {
  const _ManageAnnouncementsDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 520),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // HEADER
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.arrow_back, size: 20),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "Manage Announcements",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "View and edit department announcements",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _announcementCard(
                    context,
                    title: "Department Meeting",
                    subtitle:
                        "HOD meeting with all faculty on Friday at 3 PM",
                    date: "2024-01-14",
                  ),

                  const SizedBox(height: 12),

                  _announcementCard(
                    context,
                    title: "Exam Schedule",
                    subtitle:
                        "Mid-term exam schedule has been published",
                    date: "2024-01-13",
                  ),

                  const SizedBox(height: 12),

                  _announcementCard(
                    context,
                    title: "Faculty Workshop",
                    subtitle:
                        "Faculty development workshop next week",
                    date: "2024-01-12",
                  ),
                ],
              ),

              // CLOSE ICON
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Icon(Icons.close,
                        size: 18, color: Colors.grey[700]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _announcementCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 14, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(
                date,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),

              // EDIT
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  showEditAnnouncementDialog(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined,
                        size: 16, color: Colors.black87),
                    const SizedBox(width: 4),
                    Text(
                      "Edit",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // DELETE
              InkWell(
                onTap: () {
                  // TODO: delete confirmation popup
                },
                child: Row(
                  children: [
                    Icon(Icons.delete_outline,
                        size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(
                      "Delete",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
Future<void> showEditAnnouncementDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => _EditAnnouncementDialog(),
  );
}

class _EditAnnouncementDialog extends StatefulWidget {
  @override
  State<_EditAnnouncementDialog> createState() =>
      _EditAnnouncementDialogState();
}

class _EditAnnouncementDialogState extends State<_EditAnnouncementDialog> {
  String _selectedType = 'Others';
  String _selectedAudience = 'All Years';

  final TextEditingController _customTitleCtrl =
      TextEditingController(text: 'Department Meeting');

  final TextEditingController _messageCtrl =
      TextEditingController(
        text: 'HOD meeting with all faculty on Friday at 3 PM',
      );

  final List<String> _types = [
    'General',
    'Exam',
    'Meeting',
    'Others',
  ];

  final List<String> _audiences = [
    'All Years',
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];

  @override
  void dispose() {
    _customTitleCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 520),
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.arrow_back, size: 20),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),

                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Edit Announcement",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Update announcement details",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _label("Title"),
                  const SizedBox(height: 6),
                  _dropdown(
                    value: _selectedType,
                    items: _types,
                    onChanged: (v) =>
                        setState(() => _selectedType = v!),
                  ),

                  const SizedBox(height: 12),

                  _label("Custom Title"),
                  const SizedBox(height: 6),
                  _textField(
                    controller: _customTitleCtrl,
                    hint: "Custom title",
                  ),

                  const SizedBox(height: 12),

                  _label("Message"),
                  const SizedBox(height: 6),
                  _textField(
                    controller: _messageCtrl,
                    hint: "Announcement message",
                    maxLines: 4,
                  ),

                  const SizedBox(height: 12),

                  _label("Target Audience"),
                  const SizedBox(height: 6),
                  _dropdown(
                    value: _selectedAudience,
                    items: _audiences,
                    onChanged: (v) =>
                        setState(() => _selectedAudience = v!),
                  ),

                  const SizedBox(height: 18),

                  // SAVE CHANGES
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: update API call
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.check_circle_outline,
                          size: 18),
                      label: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "Save Changes",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // CANCEL
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side:
                            BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // CLOSE ICON
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(Icons.close,
                        size: 18, color: Colors.grey[700]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.inter(),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF6F7F9),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF6F7F9),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      icon: Icon(Icons.keyboard_arrow_down,
          color: Colors.grey[700]),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e, style: GoogleFonts.inter()),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
