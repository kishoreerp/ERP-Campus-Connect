import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StaffPendingApprovalScreen extends StatefulWidget {
  const StaffPendingApprovalScreen({super.key});


  @override
  State<StaffPendingApprovalScreen> createState() =>
      _StaffPendingApprovalScreenState();
}


class _StaffPendingApprovalScreenState
    extends State<StaffPendingApprovalScreen> {


  List<Map<String, dynamic>> pendingRequests = [
    {
      "name": "Prof. David Lee",
      "department": "Computer Science",
      "type": "Leave Request",
      "reason": "Sick Leave",
      "date": "2024-01-20",
      "days": "2",
    },
    {
      "name": "Dr. Lisa Wong",
      "department": "Computer Science",
      "type": "OD Request",
      "reason": "Conference attendance",
      "date": "2024-01-22",
      "days": "3",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Pending Approval",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: pendingRequests.isEmpty
            ? const Center(
                child: Text(
                  "No Pending Requests",
                  style: TextStyle(fontSize: 14),
                ),
              )
            : ListView.builder(
                itemCount: pendingRequests.length,
                itemBuilder: (context, index) {
                  final request = pendingRequests[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildRequestCard(request, index),
                  );
                },
              ),
      ),
    );
  }


  // ---------------- REQUEST CARD ----------------


  Widget _buildRequestCard(Map<String, dynamic> request, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFE8F0FE),
                child: Icon(Icons.person_outline,
                    color: Colors.blue, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request["name"],
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    Text(request["department"],
                        style: GoogleFonts.inter(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Pending",
                  style: GoogleFonts.inter(
                    color: Colors.orange,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          _detailRow("Type", request["type"]),
          _detailRow("Reason", request["reason"]),
          _detailRow("Date", request["date"]),
          _detailRow("Days", request["days"]),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      pendingRequests.removeAt(index);
                    });


                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Request Approved"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.check, size: 18,color: Color.fromARGB(255, 243, 243, 243)),
                  label: const Text("Approve",style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),),
                 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showRejectDialog(request, index);
                  },
                  icon: const Icon(Icons.close,
                      size: 18, color: Color.fromARGB(255, 255, 255, 255)),
                  label: const Text(
                    "Reject",
                    style: TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 221, 83, 74),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  // ---------------- MODERN REJECT DIALOG ----------------


  void _showRejectDialog(
      Map<String, dynamic> request, int index) {


    final controller = TextEditingController();


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [


                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: 17,
                  ),
                ),


                const SizedBox(height: 16),


                Text(
                  "Reject Request",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),


                const SizedBox(height: 8),


                Text(
                  "Please enter a reason for rejection",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),


                const SizedBox(height: 20),


                TextField(
                  controller: controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter rejection reason...",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding:
                        const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),


                const SizedBox(height: 24),


                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (controller.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Reason cannot be empty"),
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              ),
                            );
                            return;
                          }


                          setState(() {
                            pendingRequests
                                .removeAt(index);
                          });


                          Navigator.pop(context);


                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Request Rejected"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        child: const Text("Reject"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // ---------------- COMMON ----------------


  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text("$title:",
              style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey)),
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}





