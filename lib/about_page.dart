import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  Map<int, bool> expandedCards = {};
  int hoveredIndex = -1; // For hover animation on Core Value Boxes

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF012A4A),
        centerTitle: true, // ✅ Centers the title
        title: Text(
          "Political Journey",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Attractive Circle Avatar with Border, Shadow, and Glow
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Glow Effect
                      Container(
                        width: screenWidth * 0.18,
                        height: screenWidth * 0.18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.blue.withOpacity(0.4),
                              Colors.transparent,
                            ],
                            stops: [0.6, 1.0],
                          ),
                        ),
                      ),
                      // Border & Shadow around Avatar
                      Container(
                        padding: EdgeInsets.all(5), // Border width
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF012A4A),
                            width: 3,
                          ), // Dark Blue Border
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: screenWidth * 0.15,
                          backgroundImage: AssetImage('assets/politician.jpg'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Politician Name & Designation
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

                  // Info Cards Section
                  ..._buildInfoCards(),

                  const SizedBox(height: 30),

                  // Core Values Section
                  Text(
                    'Core Values',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF012A4A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: _buildCoreValues(screenWidth),
                  ),
                ],
              ),
            ),

            // ✅ Add Footer Section Here
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // Info Cards Section with Expandable Details
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
            'On November 17, 2009, he married Mrs. Abhilasa Sinha at Malslami, Patna City. He has two children:...',
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
      String content = cardData[index]['content']!;
      String previewText =
          content.substring(0, min(50, content.length)) +
          (content.length > 50 ? "..." : "");

      return GestureDetector(
        onTap: () {
          setState(() {
            expandedCards[index] = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          width: double.infinity,
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
                  previewText,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                secondChild: Text(
                  content,
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

  // Core Values Cards with Hover Animation
  List<Widget> _buildCoreValues(double screenWidth) {
    List<Map<String, String>> coreValues = [
      {
        'title': 'Integrity',
        'content': 'Maintaining honesty and transparency in public service.',
      },
      {
        'title': 'Development',
        'content': 'Focused on sustainable and inclusive growth for all.',
      },
      {
        'title': 'Kumhrar First',
        'content': 'Prioritizing the needs of the common people.',
      },
    ];

    return List.generate(coreValues.length, (index) {
      return MouseRegion(
        onEnter: (_) {
          setState(() {
            hoveredIndex = index;
          });
        },
        onExit: (_) {
          setState(() {
            hoveredIndex = -1;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: screenWidth > 600 ? 250 : double.infinity,
          padding: EdgeInsets.all(16),
          transform:
              hoveredIndex == index
                  ? Matrix4.diagonal3Values(1.05, 1.05, 1.05)
                  : Matrix4.identity(),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF012A4A), width: 1),
            boxShadow: [
              BoxShadow(
                color:
                    hoveredIndex == index
                        ? Colors.blue.withOpacity(0.5)
                        : Colors.grey.withOpacity(0.3),
                blurRadius: hoveredIndex == index ? 10 : 5,
                spreadRadius: hoveredIndex == index ? 3 : 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                coreValues[index]['title']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                coreValues[index]['content']!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget _buildFooter() {
  return Container(
    color: Color(0xFF012A4A),
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 20,
          children: [
            _buildFooterColumn(
              'About Ashwani Kumar',
              'Dedicated to serving the people and working towards the development and prosperity of our nation through effective leadership and community engagement.',
            ),
            _buildFooterColumn(
              'Quick Links',
              'Home\nJourney\nGallery\nImpact\nEvents\nContact',
            ),
            _buildFooterColumn(
              'Contact',
              '📍 Address: Pashuram Colony, Sandalpur more, Kumhrar, Patna 800007\n📞 Phone: 6123587207\n✉️ Email: pankajsinha@ashwanikumar.org',
            ),
            _buildSocialMediaLinks(),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            '© 2025 Ashwani Kumar. All rights reserved.',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooterColumn(String title, String content) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxWidth: 300),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(content, style: TextStyle(color: Colors.white70)),
      ],
    ),
  );
}

Widget _buildSocialMediaLinks() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Connect With Us',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _socialIcon(
            FontAwesomeIcons.facebook,
            'https://www.facebook.com/YourPage',
          ),
          SizedBox(width: 10),
          _socialIcon(
            FontAwesomeIcons.twitter,
            'https://twitter.com/YourProfile',
          ),
          SizedBox(width: 10),
          _socialIcon(
            FontAwesomeIcons.instagram,
            'https://www.instagram.com/YourProfile',
          ),
          SizedBox(width: 10),
          _socialIcon(
            FontAwesomeIcons.youtube,
            'https://www.youtube.com/c/YourChannel',
          ),
        ],
      ),
    ],
  );
}

Widget _socialIcon(IconData icon, String url) {
  return GestureDetector(
    onTap: () async {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $url');
      }
    },
    child: Icon(icon, color: Colors.white),
  );
}
