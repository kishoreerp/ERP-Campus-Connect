import 'package:flutter/material.dart';

class ExportResultsDialog extends StatefulWidget {
  const ExportResultsDialog({super.key});

  @override
  State<ExportResultsDialog> createState() => _ExportResultsDialogState();
}

class _ExportResultsDialogState extends State<ExportResultsDialog> {
  String? selectedFormat;
  String? selectedExam;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Export Results',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              'Export exam results to various formats',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            const Text('Select Export Format'),
            const SizedBox(height: 6),
            _dropdown(
              value: selectedFormat,
              hint: 'Choose format',
              items: const ['CSV', 'Excel (.xlsx)', 'JSON'],
              onChanged: (val) => setState(() => selectedFormat = val),
            ),

            const SizedBox(height: 12),
            const Text('Select Exam'),
            const SizedBox(height: 6),
            _dropdown(
              value: selectedExam,
              hint: 'Choose exam',
              items: const ['Database Systems', 'Data Structures', 'Algorithms'],
              onChanged: (val) => setState(() => selectedExam = val),
            ),

            const SizedBox(height: 12),

            // ---------- INFO ----------
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb, color: Colors.orange, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'The exported file will include student names, IDs, scores, grades, and status information.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------- ACTIONS ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Download'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint),
          isExpanded: true,
          items: items
              .map(
                (e) => DropdownMenuItem(value: e, child: Text(e)),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
