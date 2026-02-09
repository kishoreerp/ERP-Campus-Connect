import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MakeAnnouncementDialog extends StatefulWidget {
  const MakeAnnouncementDialog({super.key});

  @override
  State<MakeAnnouncementDialog> createState() => _MakeAnnouncementDialogState();
}

class _MakeAnnouncementDialogState extends State<MakeAnnouncementDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  String? _selectedAudience = 'All Years';
  final TextEditingController _messageCtrl = TextEditingController();

  final List<String> _types = [
    'General',
    'Exam',
    'Meeting',
    'Holiday',
    'Other',
  ];

  final List<String> _audiences = [
    'All Years',
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];

  bool _submitting = false;

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    // simulate network / API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _submitting = false);

    // Return result or show snackbar — here we pop dialog and show a snack
    Navigator.of(context).pop(true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Announcement published', style: GoogleFonts.inter())),
    );

    // TODO: replace the delay above with actual API call to publish announcement
    // using _selectedType, _messageCtrl.text, _selectedAudience
  }

  @override
  Widget build(BuildContext context) {
    // dialog width cap and padding similar to your screenshot
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
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 24, offset: const Offset(0, 8))],
          ),
          child: Stack(
            children: [
              // Content
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top row: back arrow (optional) + title centered
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).maybePop(),
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.arrow_back, color: Colors.grey.shade700, size: 20),
                          ),
                        ),
                        const Expanded(child: SizedBox()), // pushes title to center visually
                      ],
                    ),

                    const SizedBox(height: 2),
                    Text(
                      'Make Announcement',
                      style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Create a new department announcement',
                      style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Form fields with spacing to match screenshot
                    // 1) Title (dropdown)
                    _fieldLabel('Title'),
                    const SizedBox(height: 6),
                    _buildDropdown(
                      value: _selectedType,
                      hint: 'Select announcement type',
                      items: _types,
                      onChanged: (v) => setState(() => _selectedType = v),
                      validator: (v) => (v == null || v.isEmpty) ? 'Please select a type' : null,
                    ),

                    const SizedBox(height: 12),

                    // 2) Message (multiline)
                    _fieldLabel('Message'),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _messageCtrl,
                      maxLines: 4,
                      minLines: 3,
                      style: GoogleFonts.inter(),
                      decoration: InputDecoration(
                        hintText: 'Announcement message',
                        hintStyle: GoogleFonts.inter(color: Colors.grey.shade500),
                        filled: true,
                        fillColor: const Color(0xFFF6F7F9),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a message' : null,
                    ),

                    const SizedBox(height: 12),

                    // 3) Target Audience
                    _fieldLabel('Target Audience'),
                    const SizedBox(height: 6),
                    _buildDropdown(
                      value: _selectedAudience,
                      hint: 'Select audience',
                      items: _audiences,
                      onChanged: (v) => setState(() => _selectedAudience = v),
                      validator: (_) => null,
                    ),

                    const SizedBox(height: 18),

                    // Buttons: Publish (dark) + Cancel (outlined)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _submitting ? null : _submit,
                            icon: const Icon(Icons.send, size: 18),
                            label: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('Publish', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[700], // match screenshot dark grey
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _submitting ? null : () => Navigator.of(context).pop(false),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text('Cancel', style: GoogleFonts.inter(color: Colors.black87)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),

              // Close icon top-right
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
                    child: Icon(Icons.close, size: 18, color: Colors.grey.shade700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // helper: label above fields
  Widget _fieldLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }

  // helper: dropdown styled like screenshot
  Widget _buildDropdown({
    required List<String> items,
    required String? value,
    required String hint,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF6F7F9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
      hint: Text(hint, style: GoogleFonts.inter(color: Colors.grey.shade600)),
      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter()))).toList(),
      onChanged: onChanged,
    );
  }
}
