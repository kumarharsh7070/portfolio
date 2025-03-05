import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeContentPage extends StatefulWidget {
  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  // ignore: unused_field
  int _currentIndex = 0;
  final List<String> imagePaths = [
    'assets/home1.jpg',
    'assets/home2.jpg',
    'assets/home3.jpg',
  ];

  final List<Map<String, String>> helpItems = [
    {
      "image": "assets/sup1.jpg",
      "title": "Healthcare Support",
      "description": "Ensuring accessible medical care for everyone.",
    },
    {
      "image": "assets/sup2.jpg",
      "title": "Disaster Relief",
      "description": "Providing quick and effective aid in crises.",
    },
    {
      "image": "assets/sup3.jpg",
      "title": "Youth Empowerment",
      "description": "Creating opportunities for the next generation.",
    },
    {
      "image": "assets/help4.jpg",
      "title": "Employment Growth",
      "description": "Boosting job creation and economic development.",
    },
  ];

  void _showPopup(BuildContext context, Map<String, String> item) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.white.withOpacity(0.95),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(item["image"]!, fit: BoxFit.cover),
                ),
                SizedBox(height: 10),
                Text(
                  item["title"]!,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF012A4A),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  item["description"]!,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF012A4A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.white),
                  label: Text("Close", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Image Carousel Section
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  items:
                      imagePaths.map((imagePath) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            imagePath,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                  options: CarouselOptions(
                    height: screenWidth * 0.55,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 🔹 Politician Name & Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    'Welcome to My Official Page',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF012A4A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Committed to bringing change and serving the people.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 NEW "How I Help" Section with Glassmorphism
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'How I Help the Community',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF012A4A),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Working towards a better tomorrow for everyone.',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Grid Layout for Help Cards
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 600 ? 2 : 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: helpItems.length,
                    itemBuilder: (context, index) {
                      var item = helpItems[index];
                      return GestureDetector(
                        onTap: () => _showPopup(context, item),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          transform: Matrix4.identity()..scale(1.0),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueAccent.withOpacity(0.9),
                                Colors.lightBlueAccent.withOpacity(0.9),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item["title"]!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: () => _showPopup(context, item),
                                icon: Icon(
                                  Icons.touch_app,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Tap to Expand",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
