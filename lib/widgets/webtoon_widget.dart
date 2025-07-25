import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/screens/detail_screen.dart';
import 'package:webtoon/services/api_service.dart';

class Webtoon extends StatelessWidget {
  final String title;
  final String thumb;
  final String id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // 다양한 이미지를 넣은 리스트로 대체
    List<String> images = [
      'https://cdn.pixabay.com/photo/2023/11/24/12/06/duck-8409886_1280.png',
      'https://cdn.pixabay.com/photo/2021/03/02/17/28/pixel-6063274_1280.png',
      'https://cdn.pixabay.com/photo/2025/06/11/13/19/ai-generated-9654480_1280.png',
    ];

    // 랜덤으로 이미지를 선택
    String randomImage = images[Random().nextInt(images.length)];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
          ),
        );
      },
      child: Column(
        children: [
          Container(
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
            child: Image.network(randomImage), // 랜덤 이미지를 표시
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "Today's Webtoons",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(height: 50),
                // 변경된 부분: ListView 대신 SingleChildScrollView로 감싸기
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return SingleChildScrollView(
      // 수평 스크롤이 잘 되도록 SingleChildScrollView 사용
      scrollDirection: Axis.horizontal,
      child: Row(
        children: snapshot.data!.map((webtoon) {
          return Webtoon(
            title: webtoon.title,
            thumb: webtoon.thumb,
            id: webtoon.id,
          );
        }).toList(),
      ),
    );
  }
}
