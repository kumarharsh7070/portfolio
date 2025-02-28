import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String searchQuery = "";

  void _updateStatus(String docId, String status) {
    FirebaseFirestore.instance.collection('contacts').doc(docId).update({
      'status': status,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        backgroundColor: Color(0xFF012A4A),
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
                                    .collection('contact')
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
}
