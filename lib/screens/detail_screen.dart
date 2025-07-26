import 'dart:math';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://cdn.pixabay.com/photo/2023/11/24/12/06/duck-8409886_1280.png',
      'https://cdn.pixabay.com/photo/2021/03/02/17/28/pixel-6063274_1280.png',
      'https://cdn.pixabay.com/photo/2025/06/11/13/19/ai-generated-9654480_1280.png',
    ];

    String randomImage = images[Random().nextInt(images.length)];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: Offset(10, 10),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Image.network(randomImage),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//detail