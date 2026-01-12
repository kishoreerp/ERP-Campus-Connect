import 'package:flutter/material.dart';

class TermsConditionsDialog extends StatelessWidget {
  const TermsConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // ---------- HEADER ----------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Terms and Conditions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Last updated: December 18, 2025',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ---------- CONTENT ----------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Section(
                    title: '1. Acceptance of Terms',
                    content:
                        'By accessing and using the SLEC Exam Cell Admin Portal, '
                        'you accept and agree to be bound by the terms and provision '
                        'of this agreement.',
                  ),
                  _Section(
                    title: '2. Professional Conduct',
                    content:
                        'As an exam cell administrator, you agree to maintain '
                        'confidentiality and use the portal for official examination '
                        'purposes only.',
                  ),
                  _Section(
                    title: '3. Data Security',
                    content:
                        'You are responsible for maintaining the security of your '
                        'account credentials and all examination data accessed '
                        'through this portal.',
                  ),
                  _Section(
                    title: '4. Result Confidentiality',
                    content:
                        'All examination results and student data must be handled '
                        'with strict confidentiality until official publication.',
                  ),
                  _Section(
                    title: '5. Intellectual Property',
                    content:
                        'All content and data within this portal are the intellectual '
                        'property of SLEC and may not be reproduced without permission.',
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= SECTION WIDGET =================
class _Section extends StatelessWidget {
  final String title;
  final String content;

  const _Section({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }
}
