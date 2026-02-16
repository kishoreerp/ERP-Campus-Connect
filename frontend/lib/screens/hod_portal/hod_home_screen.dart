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

_buildQuickActions(context),   // 👈 ADD THIS LINE

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

  Widget _buildQuickActions(BuildContext context) {
  return Column(
    children: [

      // First Row
      Row(
        children: [
          Expanded(
            child: _quickAction(
              context,
              Icons.campaign_outlined,
              'Announcement',
              customOnTap: () => showAnnouncementManagementDialog(context),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.event_note,
              'Events',
              screen: HODEventsScreen(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.notifications_outlined,
              'Notifications',
              customOnTap: () => showNotificationsDialog(context),
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      // Second Row
      Row(
        children: [
          Expanded(
            child: _quickAction(
              context,
              Icons.note_alt_outlined,
              'Notes',
              screen: const HODNotesScreen(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.approval,
              'Approvals',
              customOnTap: () => showApprovalsEntryDialog(context),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _quickAction(
              context,
              Icons.calendar_month,
              'Request Leave',
              customOnTap: () => showLeaveManagementDialog(context),
            ),
          ),
        ],
      ),
    ],
  );
}
 Widget _quickAction(
    BuildContext context,
    IconData icon,
    String title, {
    Widget? screen,
    VoidCallback? customOnTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (customOnTap != null) {
          customOnTap();
        } else if (screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.black87, size: 26),
            const SizedBox(height: 6),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ],
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
                    title: 'View Announcements',
subtitle: 'View and delete existing announcements',

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
  "View and delete department announcements",

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

Widget _quickAction(
  BuildContext context,
  IconData icon,
  String title, {
  Widget? screen,
  VoidCallback? customOnTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      if (customOnTap != null) {
        customOnTap();
      } else if (screen != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      }
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.black87, size: 26),
          const SizedBox(height: 6),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
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


