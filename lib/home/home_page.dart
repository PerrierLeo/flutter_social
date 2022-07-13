import 'package:flutter/material.dart';
import 'package:kosmos_app/home/components/feed_section.dart';
import 'package:kosmos_app/home/components/top_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [TopSection(), FeedSection()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.pentagon_outlined), label: 'ok'),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profil');
                },
                icon: const Icon(Icons.hexagon_outlined),
              ),
              label: 'profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(38, 41, 43, 1),
        unselectedItemColor: const Color.fromRGBO(188, 189, 190, 1),
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_post');
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }
}
