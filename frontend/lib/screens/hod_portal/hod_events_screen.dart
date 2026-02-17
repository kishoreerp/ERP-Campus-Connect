import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HODEventsScreen extends StatefulWidget {
  const HODEventsScreen({super.key});


  @override
  State<HODEventsScreen> createState() =>
      _HODEventsScreenState();
}


class _HODEventsScreenState extends State<HODEventsScreen> {

List<String> selectedDepartments = [];
List<String> selectedTargets = [];


final List<String> departments = [
  "All Departments",
  "Computer Science and Engineering",
  "Cybersecurity",
  "Artificial Intelligence and Data Science",
  "Information Technology",
  "Electronics and Communication Engineering",
];

final List<String> targets = [
  "Staff",
  "All Years",
  "1st Year",
  "2nd Year",
  "3rd Year",
  "4th Year",
];

  List<Map<String, String>> events = [
    {
      "title": "Department Review Meeting",
      "date": "2024-01-22 • 10:00 AM",
      "tag": "event"
    },
    {
      "title": "Mid-term Exam Starts",
      "date": "2024-01-25 • Full Day",
      "tag": "exam"
    },
    {
      "title": "Republic Day Holiday",
      "date": "2024-01-26 • Closed",
      "tag": "holiday"
    },
  ];

Future<List<String>?> _showMultiSelectDialog(
  BuildContext context, {
  required String title,
  required List<String> items,
  required List<String> selectedItems,
}) {
  List<String> tempSelected = List.from(selectedItems);

  return showDialog<List<String>>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: items.map((item) {
                  final isSelected = tempSelected.contains(item);

                  return CheckboxListTile(
                    value: isSelected,
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      setStateDialog(() {
                        if (value == true) {
                          tempSelected.add(item);
                        } else {
                          tempSelected.remove(item);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, tempSelected),
                child: const Text("Done"),
              ),
            ],
          );
        },
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [


              /// HEADER
              Row(
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.arrow_back),
                    onPressed: () =>
                        Navigator.pop(context),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text("Events",
                          style:
                              GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.w700)),
                      Text(
                          "View calendar and manage events",
                          style:
                              GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Colors.grey)),
                    ],
                  )
                ],
              ),


              const SizedBox(height: 16),


              /// CALENDAR
              Container(
                padding:
                    const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          Colors.grey.shade200),
                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),
                child:
                    CalendarDatePicker(
                  initialDate:
                      DateTime.now(),
                  firstDate:
                      DateTime(2020),
                  lastDate:
                      DateTime(2030),
                  onDateChanged:
                      (selectedDate) {},
                ),
              ),


              const SizedBox(height: 24),


              /// UPCOMING HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  Text("Upcoming Events",
                      style:
                          GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.w700)),
                  ElevatedButton.icon(
  onPressed: () => _showMakeEventDialog(context),
  icon: const Icon(
    Icons.add,
    size: 16,
    color: Colors.white, // ✅ icon white
  ),
  label: const Text(
    "Make Event",
    style: TextStyle(
      color: Colors.white, // ✅ text white
      fontWeight: FontWeight.w500,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
  ),
),


                ],
              ),


              const SizedBox(height: 12),


              /// EVENTS LIST
              ListView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder:
                    (context, index) {
                  final event =
                      events[index];
                  return _eventTile(
                      event["title"]!,
                      event["date"]!,
                      event["tag"]!,
                      index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  /// EVENT TILE WITH DELETE
  Widget _eventTile(
      String title,
      String date,
      String tag,
      int index) {
    return Container(
      margin:
          const EdgeInsets.only(top: 12),
      padding:
          const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(12),
        border: Border.all(
            color:
                Colors.grey.shade200),
      ),
      child: Row(
        children: [


          Container(
            padding:
                const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors
                  .purple.shade50,
              borderRadius:
                  BorderRadius.circular(
                      10),
            ),
            child: Icon(
                Icons
                    .calendar_today_outlined,
                color: const Color.fromARGB(255, 195, 116, 211)),
          ),


          const SizedBox(width: 12),


          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(title,
                    style: GoogleFonts
                        .inter(
                            fontWeight:
                                FontWeight
                                    .w600)),
                const SizedBox(
                    height: 4),
                Text(date,
                    style: GoogleFonts
                        .inter(
                            fontSize: 12,
                            color: Colors
                                .grey)),
                const SizedBox(
                    height: 6),
                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                              horizontal:
                                  8,
                              vertical:
                                  4),
                  decoration:
                      BoxDecoration(
                    color: Colors
                        .grey.shade100,
                    borderRadius:
                        BorderRadius
                            .circular(
                                6),
                  ),
                  child: Text(tag,
                      style: GoogleFonts
                          .inter(
                              fontSize:
                                  11)),
                )
              ],
            ),
          ),


          IconButton(
            icon: const Icon(
                Icons.delete_outline,
                color: Colors.red),
            onPressed: () {
              setState(() {
                events.removeAt(
                    index);
              });
            },
          ),
        ],
      ),
    );
  }


  /// MAKE EVENT POPUP
  void _showMakeEventDialog(
      BuildContext context) {


    TextEditingController
        reasonController =
        TextEditingController();
    TextEditingController
        locationController =
        TextEditingController();
    TextEditingController
        descriptionController =
        TextEditingController();


    DateTime? selectedDate;
    TimeOfDay? selectedTime;


    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (context, setStateDialog) {
            return Dialog(
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        20),
              ),
              child: Container(
                padding:
                    const EdgeInsets
                        .all(20),
                child:
                    SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [


                      const Text(
                          "Make Event",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight:
                                  FontWeight
                                      .w600)),


                      const SizedBox(
                          height: 10),

/// DEPARTMENT MULTI SELECT
const Text(
  "Department",
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
),
const SizedBox(height: 6),

SizedBox(
  width: double.infinity,
  child: GestureDetector(
    onTap: () async {
      final result = await _showMultiSelectDialog(
        context,
        title: "Select Departments",
        items: departments,
        selectedItems: selectedDepartments,
      );

      if (result != null) {
        setStateDialog(() {
          selectedDepartments = result;
        });
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              selectedDepartments.isEmpty
                  ? "Select Departments"
                  : selectedDepartments.join(", "),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    ),
  ),
),

const SizedBox(height: 16),

/// TARGET MULTI SELECT
const Text(
  "Target",
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
),
const SizedBox(height: 6),

SizedBox(
  width: double.infinity,
  child: GestureDetector(
    onTap: () async {
      final result = await _showMultiSelectDialog(
        context,
        title: "Select Targets",
        items: targets,
        selectedItems: selectedTargets,
      );

      if (result != null) {
        setStateDialog(() {
          selectedTargets = result;
        });
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              selectedTargets.isEmpty
                  ? "Select Targets"
                  : selectedTargets.join(", "),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    ),
  ),
),

const SizedBox(height: 16),
                  
/// TITLE
const Text(
  "Title",
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
),
const SizedBox(height: 6),


Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 4,
  ),
  decoration: BoxDecoration(
    color: Colors.grey.shade200, // ✅ same as date/time
    borderRadius: BorderRadius.circular(12),
  ),
  child: TextField(
    controller: reasonController,
    decoration: const InputDecoration(
      hintText: "Enter event title",
      border: InputBorder.none,
    ),
  ),
),
const SizedBox(height: 16),






                      /// DATE
                      const Text("Date"),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () async {
                          DateTime? picked =
                              await showDatePicker(
                            context:
                                context,
                            initialDate:
                                selectedDate ??
                                    DateTime
                                        .now(),
                            firstDate:
                                DateTime(
                                    2024),
                            lastDate:
                                DateTime(
                                    2050),
                          );


                          if (picked !=
                              null) {
                            setStateDialog(
                                () {
                              selectedDate =
                                  picked;
                            });
                          }
                        },
                        child: Container(
                          width: double
                              .infinity,
                          padding:
                              const EdgeInsets
                                  .symmetric(
                                      horizontal:
                                          14,
                                      vertical:
                                          16),
                          decoration:
                              BoxDecoration(
                            color: Colors
                                .grey
                                .shade200,
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        12),
                          ),
                          child: Text(
                            selectedDate ==
                                    null
                                ? "dd-mm-yyyy"
                                : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                          ),
                        ),
                      ),


                      const SizedBox(height: 16),


                      /// TIME
                      const Text("Time"),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () async {
                          TimeOfDay? picked =
                              await showTimePicker(
                            context:
                                context,
                            initialTime:
                                selectedTime ??
                                    TimeOfDay
                                        .now(),
                          );


                          if (picked !=
                              null) {
                            setStateDialog(
                                () {
                              selectedTime =
                                  picked;
                            });
                          }
                        },
                        child: Container(
                          width: double
                              .infinity,
                          padding:
                              const EdgeInsets
                                  .symmetric(
                                      horizontal:
                                          14,
                                      vertical:
                                          16),
                          decoration:
                              BoxDecoration(
                            color: Colors
                                .grey
                                .shade200,
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        12),
                          ),
                          child: Text(
                            selectedTime ==
                                    null
                                ? "--:-- --"
                                : selectedTime!
                                    .format(
                                        context),
                          ),
                        ),
                      ),


                      const SizedBox(height: 16),


                      /// LOCATION (OUTER BORDER)
                     /// LOCATION
/// LOCATION
const Text(
  "Location",
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
),
const SizedBox(height: 6),


Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 4,
  ),
  decoration: BoxDecoration(
    color: Colors.grey.shade200, // ✅ same style
    borderRadius: BorderRadius.circular(12),
  ),
  child: TextField(
    controller: locationController,
    decoration: const InputDecoration(
      hintText: "Enter location",
      border: InputBorder.none,
    ),
  ),
),
const SizedBox(height: 16),




                   /// DESCRIPTION
/// DESCRIPTION
const Text(
  "Description",
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
),
const SizedBox(height: 6),


Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 8,
  ),
  decoration: BoxDecoration(
    color: Colors.grey.shade200, // ✅ same style
    borderRadius: BorderRadius.circular(12),
  ),
  child: TextField(
    controller: descriptionController,
    maxLines: 3,
    decoration: const InputDecoration(
      hintText: "Enter description",
      border: InputBorder.none,
    ),
  ),
),
const SizedBox(height: 20),






                      Row(
  children: [


    /// CANCEL BUTTON
    Expanded(
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),


    const SizedBox(width: 12),


    /// CREATE EVENT BUTTON
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Create Event",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ],
),


                     
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
