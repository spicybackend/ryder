import 'package:flutter/material.dart';
import 'package:ryder/services/profile_service.dart';

import '../utils/dependency_injection.dart';
import 'introduction_wizard.dart';

final _profileService = injected<ProfileService>();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Nothing to show',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tracks coming soon',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.construction),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Profile coming soon',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.construction),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final userHasProfile = await _profileService.hasProfile();

      if (!userHasProfile) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => IntroductionWizard(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ryder'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pedal_bike),
            label: 'Tracks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
