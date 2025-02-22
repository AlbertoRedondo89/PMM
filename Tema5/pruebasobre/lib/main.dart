import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _flapAnimation;
  late Animation<double> _messageOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: Offset(2.0, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _flapAnimation = Tween<double>(begin: 0, end: -0.5).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.8, curve: Curves.easeInOut)));

    _messageOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.7, 1.0, curve: Curves.easeIn)));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Animado")),
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              FadeTransition(
                opacity: _messageOpacity,
                child: Container(
                  width: 150,
                  height: 100,
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Text("Hola! Este es un mensaje.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RotationTransition(
                    turns: _flapAnimation,
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 160,
                      height: 40,
                      color: Colors.brown,
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 100,
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
