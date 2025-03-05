import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('contacts').add({
        'name': nameController.text,
        'district': districtController.text,
        'phone': phoneController.text,
        'ward': wardController.text,
        'message': messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      nameController.clear();
      districtController.clear();
      phoneController.clear();
      wardController.clear();
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF012A4A),
        centerTitle: true, // ✅ Centers the title
        title: Text(
          "Contact us",
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildAnimatedTextField(nameController, "Name"),
                _buildAnimatedTextField(districtController, "District"),
                _buildAnimatedTextField(
                  phoneController,
                  "Phone",
                  keyboardType: TextInputType.phone,
                ),
                _buildAnimatedTextField(wardController, "Ward"),
                _buildAnimatedTextField(
                  messageController,
                  "Message",
                  maxLines: 3,
                ),
                SizedBox(height: 2),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF012A4A),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ).animate().scale(delay: 300.ms, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: Icon(Icons.person_outline, color: Color(0xFF012A4A)),
        ),
        validator: (value) => value!.isEmpty ? "Enter your $label" : null,
      ).animate().fade(duration: 400.ms, delay: 200.ms),
    );
  }
}
