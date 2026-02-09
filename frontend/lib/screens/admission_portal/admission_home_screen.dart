import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AdmissionHomeScreen extends StatelessWidget {
  const AdmissionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

     

      // ================= BODY =================
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _welcomeCard(),
            const SizedBox(height: 16),
            _statCard(
              title: 'Student Strength',
              value: '26',
              bgColor: const Color(0xFFEFF6FF),
              valueColor: const Color(0xFF2563EB),
              borderColor: const Color(0xFFBFDBFE),
            ),
            const SizedBox(height: 12),
            _statCard(
              title: 'Total Applications',
              value: '6',
              bgColor: const Color(0xFFF0FDF4),
              valueColor: const Color(0xFF16A34A),
              borderColor: const Color(0xFFBBF7D0),
            ),
          ],
        ),
      ),
    );
  }

  // ================= WELCOME CARD =================
  Widget _welcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2563EB),
            Color(0xFF1D4ED8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Admission Admin Portal',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Manage student admissions and\napplications efficiently',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 14, color: Colors.white70),
              const SizedBox(width: 6),
              Text(
                DateFormat('EEEE, MMMM d, yyyy')
                    .format(DateTime.now()),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= STAT CARD =================
  Widget _statCard({
    required String title,
    required String value,
    required Color bgColor,
    required Color valueColor,
    required Color borderColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
