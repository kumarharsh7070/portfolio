import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF012A4A),
        centerTitle: true,
        title: Text(
          "Gallery",
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
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardHeight = constraints.maxWidth > 600 ? 280 : 230;
          double iconSize = constraints.maxWidth > 600 ? 70 : 50;
          double fontSize = constraints.maxWidth > 600 ? 24 : 18;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Video Card
                  _buildVideoCard(
                    title: "Watch Videos",
                    videoThumbnail: "assets/image5.jpg",
                    url: "https://youtu.be/6Qnelf1Vztc?si=-xp5Hqt0VJKKNP0",
                    icon: Icons.play_circle_fill,
                    buttonText: "Visit Video Gallery",
                    cardHeight: cardHeight,
                    iconSize: iconSize,
                    fontSize: fontSize,
                  ),
                  SizedBox(height: 20),

                  // Image Grid Card
                  _buildImageGridCard(
                    title: "View Images",
                    images: [
                      "assets/image2.jpg",
                      "assets/image1.jpg",
                      "assets/image3.jpg",
                      "assets/image4.jpg",
                    ],
                    url: "https://ashwanikumar.org/",
                    buttonText: "Visit Image Gallery",
                    cardHeight: cardHeight,
                    fontSize: fontSize,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// **Video Card with Thumbnail**
  Widget _buildVideoCard({
    required String title,
    required String videoThumbnail,
    required String url,
    required IconData icon,
    required String buttonText,
    required double cardHeight,
    required double iconSize,
    required double fontSize,
  }) {
    return Container(
      width: double.infinity,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(4, 4),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Stack(
        children: [
          // Video Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              videoThumbnail,
              width: double.infinity,
              height: cardHeight,
              fit: BoxFit.cover,
            ),
          ),

          // Play Button Overlay
          Center(
            child: Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: iconSize * 1.5,
            ),
          ),

          // Gradient Overlay
          Container(
            width: double.infinity,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Card Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: cardHeight * 0.6), // Pushes text down
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                ),
              ),
              SizedBox(height: 10),

              // Button to Visit Website
              _buildButton(url, buttonText),
            ],
          ),
        ],
      ),
    );
  }

  /// **Image Grid Card (Scrollable)**
  Widget _buildImageGridCard({
    required String title,
    required List<String> images,
    required String url,
    required String buttonText,
    required double cardHeight,
    required double fontSize,
  }) {
    return Container(
      width: double.infinity,
      height: cardHeight + 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(4, 4),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),

          // Scrollable Image Grid
          Expanded(
            child: Scrollbar(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(images[index], fit: BoxFit.cover),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 10),

          // Button to Visit Website
          _buildButton(url, buttonText),
        ],
      ),
    );
  }

  /// **Reusable Button**
  Widget _buildButton(String url, String buttonText) {
    return ElevatedButton(
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF012A4A),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
