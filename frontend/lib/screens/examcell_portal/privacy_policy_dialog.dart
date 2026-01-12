import 'package:flutter/material.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            // ---------- HEADER ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // ---------- CONTENT ----------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Last updated: December 18, 2025',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 16),

                    _SectionTitle('1. Information Collection'),
                    _SectionText(
                      'We collect examination data, student information, and administrative records '
                      'necessary for the operation of the examination cell.',
                    ),

                    SizedBox(height: 16),
                    _SectionTitle('2. Data Usage'),
                    _SectionText(
                      'Your personal information and examination data are used solely for '
                      'administrative and examination management purposes.',
                    ),

                    SizedBox(height: 16),
                    _SectionTitle('3. Data Protection'),
                    _SectionText(
                      'We implement industry-standard security measures to protect all examination '
                      'data and personal information from unauthorized access.',
                    ),

                    SizedBox(height: 16),
                    _SectionTitle('4. Information Sharing'),
                    _SectionText(
                      'Examination data is shared only with authorized personnel and is never '
                      'disclosed to third parties without proper authorization.',
                    ),

                    SizedBox(height: 16),
                    _SectionTitle('5. Your Rights'),
                    _SectionText(
                      'You have the right to access, correct, or delete your personal data in '
                      'accordance with institutional policies.',
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
}

// ---------- SECTION TITLE ----------
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }
}

// ---------- SECTION TEXT ----------
class _SectionText extends StatelessWidget {
  final String text;
  const _SectionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        height: 1.5,
        color: Colors.black87,
      ),
    );
  }
}
