import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String searchQuery = "";
  bool isAuthenticated = false;
  String enteredPassword = "";
  String storedPassword = "";

  @override
  void initState() {
    super.initState();
    _fetchAdminPassword();
  }

  Future<void> _fetchAdminPassword() async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('admin')
              .doc('credentials')
              .get();

      if (snapshot.exists) {
        setState(() {
          storedPassword = snapshot['password'];
        });
      }
    } catch (e) {
      print("Error fetching password: $e");
    }
  }

  void _checkPassword() {
    if (enteredPassword == storedPassword) {
      setState(() {
        isAuthenticated = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect password! Access denied.")),
      );
    }
  }

  void _logout() {
    setState(() {
      isAuthenticated = false;
      enteredPassword = "";
    });
  }

  Future<void> generateAndDownloadPDF() async {
    if (await Permission.storage.request().isGranted) {
      final pdf = pw.Document();

      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('contacts').get();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    "Contact Form Submissions",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                ...snapshot.docs.map((doc) {
                  var data = doc.data() as Map<String, dynamic>;
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Name: ${data['name'] ?? 'N/A'}",
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        "District: ${data['district'] ?? 'N/A'}",
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        "Phone: ${data['phone'] ?? 'N/A'}",
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        "Ward: ${data['ward'] ?? 'N/A'}",
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        "Message: ${data['message'] ?? 'N/A'}",
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        "Status: ${data['status'] ?? 'Pending'}",
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          color:
                              data['status'] == "Approved"
                                  ? PdfColors.green
                                  : PdfColors.red,
                        ),
                      ),
                      pw.Divider(),
                    ],
                  );
                }).toList(),
              ],
            );
          },
        ),
      );

      final output = await getExternalStorageDirectory();
      final file = File("${output!.path}/Contact_Form_Data.pdf");
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Download Complete! PDF saved in: ${file.path}"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Permission Denied! Enable storage permission."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      return _buildPasswordPrompt();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF012A4A),
        centerTitle: true,
        title: Text(
          "Admin Panel",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: Colors.black38,
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search by Name or District",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          ElevatedButton.icon(
            onPressed: generateAndDownloadPDF,
            icon: Icon(Icons.download),
            label: Text("Download PDF"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF012A4A),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance
                      .collection('contacts')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var documents =
                    snapshot.data!.docs.where((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      String name = data['name']?.toLowerCase() ?? "";
                      String district = data['district']?.toLowerCase() ?? "";
                      return name.contains(searchQuery) ||
                          district.contains(searchQuery);
                    }).toList();

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var data = documents[index].data() as Map<String, dynamic>;
                    String docId = documents[index].id;

                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(data['name'] ?? "No Name"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("District: ${data['district'] ?? ''}"),
                            Text("Phone: ${data['phone'] ?? ''}"),
                            Text("Ward: ${data['ward'] ?? ''}"),
                            Text("Message: ${data['message'] ?? ''}"),
                            Text(
                              "Status: ${data['status'] ?? 'Pending'}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    data['status'] == "Approved"
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () => _updateStatus(docId, "Approved"),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => _updateStatus(docId, "Rejected"),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('contacts')
                                    .doc(docId)
                                    .delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Entry deleted successfully!",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordPrompt() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 71, 173),
      appBar: AppBar(
        backgroundColor: Color(0xFF012A4A),
        centerTitle: true, // ✅ Centers the title
        title: Text(
          "Admin Panel",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22, // ✅ Slightly larger font
            fontWeight: FontWeight.bold, // ✅ Makes it bold
            letterSpacing: 1.2, // ✅ Adds spacing for better readability
            shadows: [
              Shadow(
                color: Colors.black38, // ✅ Adds subtle shadow for depth
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        elevation: 4, // ✅ Adds slight shadow below AppBar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock, size: 60, color: Colors.white),
            SizedBox(height: 15),
            Text(
              "Enter Admin Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              onChanged: (value) => enteredPassword = value,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(onPressed: _checkPassword, child: Text("Login")),
          ],
        ),
      ),
    );
  }

  void _updateStatus(String docId, String status) {
    FirebaseFirestore.instance.collection('contacts').doc(docId).update({
      'status': status,
    });
  }
}
