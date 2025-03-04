import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Map<int, bool> expandedCards = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Political Journey'),
        backgroundColor: Color(0xFF012A4A),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(height: 10),
            Text(
              'Ashwani Kumar',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Serving Since 2002',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            ..._buildInfoCards(), // ✅ Fixed spread operator issue
            const SizedBox(height: 30),
            _buildFooter(), // ✅ Added attractive footer
          ],
        ),
      ),
    );
  }

  /// 🔹 **Fixed: `_buildInfoCards()` now returns `List<Widget>`**
  List<Widget> _buildInfoCards() {
    List<Map<String, String>> cardData = [
      {
        'title': 'Introduction',
        'content':
            'Ashwani Kumar, also known as Pankaj Sinha, is the Youth President of Akhil Bharatiya Kayastha Mahasabha...',
      },
      {
        'title': 'Married Life and Family',
        'content':
            'On November 17, 2009, he married Mrs. Abhilasa Sinha at Malslami, Patna City. He has two children...',
      },
      {
        'title': 'Education and Early Life',
        'content':
            'Ashwani Kumar spent his childhood in Patna City, where he completed his early education at St. Anne’s High School...',
      },
      {
        'title': 'Leadership and Social Work',
        'content':
            'Ashwani Kumar’s leadership skills were evident from a young age. In 2002, he was elected Student Union President...',
      },
    ];

    return List.generate(cardData.length, (index) {
      bool isExpanded = expandedCards[index] ?? false;

      return GestureDetector(
        onTap: () {
          setState(() {
            expandedCards[index] = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData[index]['title']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              AnimatedCrossFade(
                duration: Duration(milliseconds: 300),
                firstChild: Text(
                  '${cardData[index]['content']!.substring(0, 50)}...',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                secondChild: Text(
                  cardData[index]['content']!,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                crossFadeState:
                    isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
              ),
            ],
          ),
        ),
      );
    });
  }

  /// 🔹 **Footer with Social Media & Contact Details**
  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Color(0xFF012A4A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '📍 Address: Pashuram Colony, Sandalpur more, Kumhrar, Patna 800007',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            '📞 Phone: 6123587207',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            '✉️ Email: pankajsinha@ashwanikumar.org',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialButton(FontAwesomeIcons.twitter, 'https://twitter.com'),
              _socialButton(
                FontAwesomeIcons.instagram,
                'https://instagram.com',
              ),
              _socialButton(FontAwesomeIcons.youtube, 'https://youtube.com'),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.white54),
          const SizedBox(height: 10),
          Text(
            '© 2025 Ashwani Kumar. All rights reserved.',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// 🔹 **Reusable Social Media Button**
  Widget _socialButton(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 24),
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}
