import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:webtu_v2/features/cards/components/content.dart';

class StudentCard extends StatefulWidget {
  const StudentCard({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -math.pi / 2)
            .chain(CurveTween(curve: Curves.easeInBack)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: math.pi / 2, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_isFrontVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _isFrontVisible = !_isFrontVisible;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate card dimensions based on screen size
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Define card aspect ratio (ID cards are typically 85.6 x 54 mm)
        const cardAspectRatio = (85.6) / 54.0;

        // Calculate card dimensions while maintaining aspect ratio
        double cardWidth = screenWidth * 1.3; // 120% of screen width
        double cardHeight = cardWidth / cardAspectRatio;

        // Ensure card isn't too large for the screen
        if (cardHeight > screenHeight * 0.7) {
          cardHeight = screenHeight * 0.7;
          cardWidth = cardHeight * cardAspectRatio;
        }

        return Center(
          child: GestureDetector(
            onTap: _toggleCard,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(_animation
                        .value), // Changed to rotateX for vertical flip
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: _isFrontVisible
                        ? _buildFrontCard(cardWidth, cardHeight)
                        : _buildBackCard(cardWidth, cardHeight),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFrontCard(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/card/card_student_empty_front.webp',
                fit: BoxFit.cover,
              ),
            ),
            // Card content
            CardContent()
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/card/card_student_back.webp',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
