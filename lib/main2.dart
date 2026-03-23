import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber.shade800),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Courier New',
          ),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//Aggiunta controller
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _sadController;
  late AnimationController _happyController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    //  tristezza
    _sadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _rotationAnimation =
        Tween<double>(begin: -0.3, end: 0.3).animate(
          CurvedAnimation(parent: _sadController, curve: Curves.easeInOut),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _sadController.reverse();
          }
        });

    //  gioia
    _happyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.5).animate(
          CurvedAnimation(parent: _happyController, curve: Curves.elasticOut),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _happyController.reverse();
          }
        });
  }

  @override
  void dispose() {
    _sadController.dispose();
    _happyController.dispose();
    super.dispose();
  }

  void _onThumbDown() {
    _sadController.forward(from: 0);
  }

  void _onThumbUp() {
    _happyController.forward(from: 0);
  }

  //Struttura
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animazioni icone")),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  triste
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: IconButton(
                  icon: const Icon(Icons.thumb_down, size: 50),
                  onPressed: _onThumbDown,
                ),
              );
            },
          ),

          const SizedBox(width: 40),

          //  felice
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: IconButton(
                  icon: const Icon(Icons.thumb_up, size: 50),
                  onPressed: _onThumbUp,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
