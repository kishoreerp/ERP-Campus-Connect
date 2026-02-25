import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class AddNewAdminScreen extends StatefulWidget {
  const AddNewAdminScreen({super.key});

  @override
  State<AddNewAdminScreen> createState() => _AddNewAdminScreenState();
}
class _AddNewAdminScreenState extends State<AddNewAdminScreen> {


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController responsibilityController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController bankDetailsController = TextEditingController();
  final TextEditingController currentSalaryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  File? degreeCertificateFile;
  File? aadhaarFile;
  File? panCardFile;
  File? resumeFile;

  String? qualification;
  String? designation;

  final List<String> designations = ["Principal"];
  final List<String> qualifications = ["Master", "PhD"];
  
final TextEditingController doorNoCtrl = TextEditingController();
final TextEditingController streetCtrl = TextEditingController();
final TextEditingController villageCtrl = TextEditingController();
final TextEditingController postCtrl = TextEditingController();
final TextEditingController cityCtrl = TextEditingController();
final TextEditingController talukCtrl = TextEditingController();
final TextEditingController districtCtrl = TextEditingController();
final TextEditingController stateCtrl = TextEditingController();
final TextEditingController pincodeCtrl = TextEditingController();

final TextEditingController accountHolderCtrl = TextEditingController();
final TextEditingController accountNumberCtrl = TextEditingController();
final TextEditingController ifscCtrl = TextEditingController();
final TextEditingController bankNameCtrl = TextEditingController();
final TextEditingController branchNameCtrl = TextEditingController();


 Future<void> pickResume() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx'],
  );

  if (result != null && result.files.single.path != null) {
    File file = File(result.files.single.path!);

    int fileSize = file.lengthSync(); // in bytes

    if (fileSize <= 20480) { // 20KB limit
      setState(() {
        resumeFile = file;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("File size must be less than 20KB"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


 Future<void> pickDocument(Function(File) onFilePicked) async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'jpg', 'png'],
  );

  if (result != null && result.files.single.path != null) {
    File file = File(result.files.single.path!);

    int fileSize = file.lengthSync(); // in bytes

    if (fileSize <= 20480) { // 20KB limit
      onFilePicked(file);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("File size must be less than 20KB"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


  InputDecoration greyInput(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget greyUploadBox(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.grey),
            ),
            const Icon(Icons.upload_file,
                color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
                        Row(
  children: [
    IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ),
    const SizedBox(width: 8),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Add New Admin",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2),
        Text(
          "Fill all details carefully",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ],
),
const SizedBox(height: 20),

const Text(
  "Personal Information",
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),

              const SizedBox(height: 4),

            Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(bottom: 16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Text("Full Name *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      TextField(controller: nameController, decoration: greyInput("Enter full name")),

      const SizedBox(height: 16),

      const Text("Designation *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      DropdownButtonFormField<String>(
        value: designation,
        decoration: greyInput("Select Designation"),
        items: designations
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) => setState(() => designation = val),
      ),

      const SizedBox(height: 16),

      const Text("Responsibility *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      TextField(controller: responsibilityController, decoration: greyInput("Enter responsibilities")),

      const SizedBox(height: 16),

      const Text("Role *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      TextField(controller: roleController, decoration: greyInput("Enter role")),

      const SizedBox(height: 16),

      const Text("Phone Number *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      TextField(controller: phoneController, decoration: greyInput("+91 98765 43210")),

      const SizedBox(height: 16),

      const Text("Email Address *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      TextField(controller: emailController, decoration: greyInput("email@slec.edu.in")),
    ],
  ),
),

                    const SizedBox(height: 16),

                    const Text(
  "Address Information",
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 4),
 Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(bottom: 16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Text("Address *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),

      TextField(
        controller: addressController,
        readOnly: true,
        onTap: () {
          setState(() {
            showAddressSection = !showAddressSection;
          });
        },
        decoration: greyInput("Enter full address"),
      ),
        const SizedBox(height: 20),

      if (showAddressSection) ...[
        const SizedBox(height: 16),
        _addressField("Door No *", doorNoCtrl),
        _addressField("Street / Road *", streetCtrl),
        _addressField("Village / Town *", villageCtrl),
        _addressField("Post *", postCtrl),
        _addressField("City *", cityCtrl),
        _addressField("Taluk *", talukCtrl),
        _addressField("District *", districtCtrl),
        _addressField("State *", stateCtrl),
        _addressField("Pincode *", pincodeCtrl),
      ],
   
    Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              showAddressSection = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              addressController.text =
                  "${doorNoCtrl.text}, ${streetCtrl.text}, "
                  "${villageCtrl.text}, ${postCtrl.text}, "
                  "${cityCtrl.text}, ${talukCtrl.text}, "
                  "${districtCtrl.text}, ${stateCtrl.text} - "
                  "${pincodeCtrl.text}";

              showAddressSection = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding:
                const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
   ],
     ),     
 ),
  const SizedBox(height: 16),

 const Text(
  "Bank Information",
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),
  const SizedBox(height: 4),


 Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(bottom: 16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      
      
                    const SizedBox(height: 16),
     const Text("Bank Details *", style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 6),

TextField(
  controller: bankDetailsController,
  readOnly: true,
  onTap: () {
    setState(() {
      showBankSection = !showBankSection;
    });
  },
  decoration: greyInput("Enter bank details"),
),

if (showBankSection) ...[
  const SizedBox(height: 16),

  _bankField("Account Holder Name *", accountHolderCtrl),
  _bankField("Account Number *", accountNumberCtrl),
  _bankField("IFSC Code *", ifscCtrl),
  _bankField("Bank Name *", bankNameCtrl),
  _bankField("Branch Name *", branchNameCtrl),

  const SizedBox(height: 16),

  Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              showBankSection = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              bankDetailsController.text =
                  "${accountHolderCtrl.text}, "
                  "${accountNumberCtrl.text}, "
                  "${ifscCtrl.text}, "
                  "${bankNameCtrl.text}, "
                  "${branchNameCtrl.text}";

              showBankSection = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
 ],
   const SizedBox(height: 16),

      const Text("Aadhaar Card *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      TextField(decoration: greyInput("Enter Aadhaar number")),

      const SizedBox(height: 16),

      const Text("PAN Card *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      TextField(decoration: greyInput("Enter PAN number")),

      const SizedBox(height: 16),
      

                    const Text("Current Salary *",
                        style: TextStyle(
                            fontWeight:
                                FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextField(
                      controller:
                          currentSalaryController,
                      keyboardType:
                          TextInputType.number,
                      decoration: greyInput(
                          "Enter current salary"),
                    ),


    ],
  ),
 ),

  const SizedBox(height: 16),
const Text(
  "Academic Information",
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),

                    const SizedBox(height: 4),
                   Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(bottom: 16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Text("Qualification *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      DropdownButtonFormField<String>(
        value: qualification,
        decoration: greyInput("Select Qualification"),
        items: qualifications
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) => setState(() => qualification = val),
      ),

      const SizedBox(height: 16),

      const Text("Degree Certificate *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      greyUploadBox("Upload Degree Certificate", () {
        pickDocument((file) {
          setState(() => degreeCertificateFile = file);
        });
      }),

      const SizedBox(height: 16),

      const Text("Upload Resume *", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      greyUploadBox("Upload PDF/DOC file", pickResume),
    ],
  ),
),

                     const SizedBox(height: 1),
Row(
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200], // light grey background
          elevation: 0, // remove shadow
          side: BorderSide.none, // remove border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Cancel",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
    const SizedBox(width: 12),
Expanded(
  child: ElevatedButton(
  onPressed: () {
  if (validateForm()) {
    showPreviewDialog();
  }
},

    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      elevation: 0,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: const Text(
      "Preview",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  )
  
 )
  
  ],
      ),
  ],
    ),
  
)


          
        ),
      );
  
  
}


 // 🔹 PUT THIS INSIDE _AddNewAdminScreenState CLASS
bool showAddressSection = false;

void _openAddressSheet() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom:
              MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              const Text(
                "Address Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "Permanent residential address",
                style:
                    TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              _addressField("Door No *", doorNoCtrl),
              _addressField("Street / Road *", streetCtrl),
              _addressField("Village / Town *", villageCtrl),
              _addressField("Post *", postCtrl),
              _addressField("City *", cityCtrl),
              _addressField("Taluk *", talukCtrl),
              _addressField("District *", districtCtrl),
              _addressField("State *", stateCtrl),
              _addressField("Pincode *", pincodeCtrl),

              const SizedBox(height: 20),

             Row(
  children: [
   Expanded(
  child: ElevatedButton(
    onPressed: () {
      Navigator.pop(context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[200], // grey fill
      elevation: 0, // remove shadow
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: const Text(
      "Cancel",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black, // black text
      ),
    ),
  ),
),

    const SizedBox(width: 12),

    Expanded(
      child: ElevatedButton(
        onPressed: () {
          addressController.text =
              "${doorNoCtrl.text}, ${streetCtrl.text}, "
              "${villageCtrl.text}, ${postCtrl.text}, "
              "${cityCtrl.text}, ${talukCtrl.text}, "
              "${districtCtrl.text}, ${stateCtrl.text} - "
              "${pincodeCtrl.text}";

          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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

Widget _addressField(
    String label,
    TextEditingController controller) {
  return Padding(
    padding:
        const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: greyInput(""),
        ),
      ],
    ),
  );
}
bool showBankSection = false;

Widget _bankField(
  String label,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: greyInput(""),
        ),
      ],
    ),
  );
}
Widget _previewRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.isEmpty ? "-" : value,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    ),
  );
}
       void showPreviewDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Preview Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _previewRow("Full Name", nameController.text),
                _previewRow("Designation", designation ?? ""),
                _previewRow("Responsibility", responsibilityController.text),
                _previewRow("Role", roleController.text),
                _previewRow("Phone", phoneController.text),
                _previewRow("Email", emailController.text),

                const Divider(),

                _previewRow("Address", addressController.text),

                const Divider(),

                _previewRow("Bank Details", bankDetailsController.text),

                const Divider(),

                _previewRow("Qualification", qualification ?? ""),
                _previewRow("Salary", currentSalaryController.text),

              ],
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // go back
            },
            child: const Text(
              "Go Back",
              style: TextStyle(color: Colors.black),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // close preview
             void addadmin() {
 
}
 // call your existing function
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const Text(
              "Add Admin",
              style: TextStyle(color: Colors.white),
              
            ),
            
          ),
        ],
      );
    },
  );
}
bool validateForm() {
  if (nameController.text.isEmpty ||
      emailController.text.isEmpty ||
      phoneController.text.isEmpty ||
      responsibilityController.text.isEmpty ||
      roleController.text.isEmpty ||
      addressController.text.isEmpty ||
      bankDetailsController.text.isEmpty ||
      currentSalaryController.text.isEmpty ||
      qualification == null ||
      designation == null ||
      degreeCertificateFile == null ||
      resumeFile == null) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please complete all details"),
        backgroundColor: Colors.red,
      ),
    );
    
    return false;
  }
  return true;
}


}