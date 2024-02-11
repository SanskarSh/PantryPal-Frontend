import 'package:clock_loader/clock_loader.dart';
import 'package:flutter/material.dart';
import 'package:hackthisfall/constants/color.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _selectedTime = 0;
  bool timerStarted = false;

  void startTimer(int timer) {
    setState(() {
      timerStarted = true;
      _selectedTime = timer;
    });
    Future.delayed(Duration(minutes: timer), () {
      setState(() {
        _selectedTime = 0;
        timerStarted = false;
      });
    });
  }

  stopTimer() {
    setState(() {
      _selectedTime = 0;
      timerStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Optional, if you don't want a back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            timerStarted
                ? ClockLoader(
                    clockLoaderModel: ClockLoaderModel(
                      shapeOfParticles: ShapeOfParticlesEnum.circle,
                      mainHandleColor: yellow,
                      particlesColor: orange,
                    ),
                  )
                : SizedBox(),
            const SizedBox(height: 20),
            Wrap(
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: _selectedTime == 30 ? yellow : null,
                    ),
                    onPressed: () => _selectedTime == 30
                        ? stopTimer()
                        : startTimer(30), // Fixed onPressed
                    child: const Text('30', style: TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: _selectedTime == 15 ? yellow : null,
                    ),
                    onPressed: () => _selectedTime == 15
                        ? stopTimer()
                        : startTimer(15), // Fixed onPressed
                    child: const Text('15', style: TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: _selectedTime == 10 ? yellow : null,
                    ),
                    onPressed: () => _selectedTime == 10
                        ? stopTimer()
                        : startTimer(10), // Fixed onPressed
                    child: const Text('10',
                        style: TextStyle(fontSize: 20)), // Fixed timer value
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:clock_loader/clock_loader.dart';

// import 'package:hackthisfall/constants/color.dart';

// class TimerScreen extends StatefulWidget {
//   @override
//   _TimerScreenState createState() => _TimerScreenState();
// }

// class _TimerScreenState extends State<TimerScreen> {
//   int _selectedTime = 0;
//   bool timerStarted = false;
//   AudioPlayer audioPlayer = AudioPlayer();

//   void startTimer(int timer) {
//     setState(() {
//       timerStarted = true;
//       _selectedTime = timer;
//     });

//     // Start playing audio
//     playAudio();

//     Future.delayed(Duration(minutes: timer), () {
//       setState(() {
//         _selectedTime = 0;
//         timerStarted = false;
//       });
//       // Stop playing audio
//       stopAudio();
//     });
//   }

//   void stopTimer() {
//     setState(() {
//       _selectedTime = 0;
//       timerStarted = false;
//     });
//     // Stop playing audio
//     stopAudio();
//   }

//   void playAudio() async {
//     int result = await audioPlayer.play('assets/audio/Colorful Flowers.mp3', isLocal: true);
//     if (result != 1) {
//       print('Failed to play audio');
//     }
//   }

//   void stopAudio() {
//     audioPlayer.stop();
//   }

//   @override
//   void dispose() {
//     // Dispose of the audio player when the screen is disposed to prevent memory leaks
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             timerStarted
//                 ? ClockLoader(
//                     clockLoaderModel: ClockLoaderModel(
//                       shapeOfParticles: ShapeOfParticlesEnum.circle,
//                       mainHandleColor: yellow,
//                       particlesColor: orange,
//                     ),
//                   )
//                 : SizedBox(),
//             const SizedBox(height: 20),
//             Wrap(
//               children: [
//                 SizedBox(
//                   height: 75,
//                   width: 75,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       primary: _selectedTime == 30 ? yellow : null,
//                     ),
//                     onPressed: () => _selectedTime == 30 ? stopTimer() : startTimer(30),
//                     child: const Text('30', style: TextStyle(fontSize: 20)),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 SizedBox(
//                   height: 75,
//                   width: 75,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       primary: _selectedTime == 15 ? yellow : null,
//                     ),
//                     onPressed: () => _selectedTime == 15 ? stopTimer() : startTimer(15),
//                     child: const Text('15', style: TextStyle(fontSize: 20)),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 SizedBox(
//                   height: 75,
//                   width: 75,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       primary: _selectedTime == 10 ? yellow : null,
//                     ),
//                     onPressed: () => _selectedTime == 10 ? stopTimer() : startTimer(10),
//                     child: const Text('10', style: TextStyle(fontSize: 20)),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
