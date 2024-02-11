import 'package:flutter/material.dart';
import 'package:hackthisfall/screens/pantary_screen.dart';
import 'package:hackthisfall/screens/receipt_screen.dart';
import 'package:hackthisfall/screens/timer_screen.dart';
import 'package:hackthisfall/widgets/background.dart';

// import 'package:rive/rive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const PantryScreen(),
     ReceiptScreen(),
    TimerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        buildBackgroundGradient(),
        DefaultTabController(
          length: _screens.length,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const TabBar(labelColor: Colors.white, tabs: [
                Tab(icon: Icon(Icons.food_bank), child: Text('Pantry')),
                Tab(
                    icon: Icon(Icons.camera_alt_outlined),
                    child: Text('Receipt')),
                Tab(icon: Icon(Icons.timer), child: Text('Timer')),
              ]),
            ),
            body: TabBarView(
              children: _screens,
            ),
          ),
        ),
        // const RiveAnimation.network(
        //   "https://rive.app/community/5613-11021-404-cat/",
        //   fit: BoxFit.cover,
        // ),
      ],
    );
  }
}
