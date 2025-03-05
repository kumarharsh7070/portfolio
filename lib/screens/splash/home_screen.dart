import 'package:flutter/material.dart';
import 'package:portfolio/about_page.dart';
import 'package:portfolio/admin_page.dart';
import 'package:portfolio/contact_page.dart';
import 'package:portfolio/screens/splash/gallery_page.dart';
import 'package:portfolio/screens/splash/home_content.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool isHindi = false; // Language toggle state

  // List of pages for bottom navigation
  final List<Widget> _pages = [
    HomeContentPage(), // Home Page Content
    GalleryPage(), // Gallery Page
    AboutPage(), // About Page
    ContactPage(),
    AdminPage(), // Admin Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "अश्विनी कुमार" : "Ashwani Kumar"),
        backgroundColor: Color(0xFF004AAD), // Matching Splash Theme
        actions: [
          IconButton(
            icon: Icon(Icons.language, color: Colors.white),
            onPressed: () {
              setState(() {
                isHindi = !isHindi; // Toggle Language
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF001F4E), Color(0xFF004AAD)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              accountName: Text(
                isHindi ? "अश्विनी कुमार" : "Ashwani Kumar",
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 20,
                  ), // Email icon
                  SizedBox(width: 5), // Spacing between icon and text
                  Text(
                    "aswanikumarpatna@gmail.com",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/politician.jpg'),
              ),
            ),

            _buildDrawerItem(
              Icons.person,
              isHindi ? "नेता के बारे में" : "About",
              AboutPage(),
            ),
            _buildDrawerItem(
              Icons.image,
              isHindi ? "गैलरी" : "Gallery",
              GalleryPage(),
            ),
            _buildDrawerItem(
              Icons.contact_mail,
              isHindi ? "संपर्क करें" : "Contact",
              ContactPage(),
            ),
            _buildDrawerItem(
              Icons.admin_panel_settings,
              isHindi ? "प्रशासन" : "Admin",
              AdminPage(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(Icons.facebook, Colors.blue),
                  _buildSocialIcon(Icons.email, Colors.red),
                  _buildSocialIcon(Icons.language, Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // Display selected page

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Color(0xFF012A4A), // Matching Splash Screen
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: isHindi ? "होम" : "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: isHindi ? "गैलरी" : "Gallery",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: isHindi ? "बारे में" : "About",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: isHindi ? "संपर्क करें" : "Contact",
          ),
        ],
      ),
    );
  }

  // Helper function for Drawer Items
  Widget _buildDrawerItem(IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF004AAD)),
      title: Text(title),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }

  // Helper function for Social Media Icons
  Widget _buildSocialIcon(IconData icon, Color color) {
    return IconButton(icon: Icon(icon, color: color), onPressed: () {});
  }
}
