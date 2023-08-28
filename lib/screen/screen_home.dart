import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screen/screen_quiz.dart';
import '../model/quiz_dart.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Quiz> quizes = [
    Quiz.fromMap({
      'title' : 'test',
      'candidates': ['a','b','c','d'],
      'answer' : 0
    }),
    Quiz.fromMap({
      'title' : 'test',
      'candidates': ['a','b','c','d'],
      'answer' : 0
    }),
    Quiz.fromMap({
      'title' : 'test',
      'candidates': ['a','b','c','d'],
      'answer' : 0
    }),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
          appBar: AppBar(
            title: Text('My Quiz App'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset('image/quiz.jpeg', width: width*0.8,)),
              
              Padding(padding: EdgeInsets.all(width * 0.024)),

              Text('플러터 퀴즈 앱', style: TextStyle(fontSize: width*0.065, fontWeight: FontWeight.bold),),
              
              Text('퀴즈를 풀기 전 안내사항입니다.\n꼼꼼히 읽고 퀴즈 풀기를 눌러주세요.', textAlign: TextAlign.center,),
              
              Padding(padding: EdgeInsets.all(width*0.048)),

              _buildStep(width, '1. 랜덤으로 나오는 퀴즈 3개를 풀어보세요.'),
              _buildStep(width, '2. 문제를 잘 읽고 정답을 고른 뒤\n    다음 문제 버튼을 눌러주세요.'),
              _buildStep(width, '3. 만점을 향해 도전해보세요!'),
              
              Padding(padding: EdgeInsets.all(width*0.048)),

              Container(
                padding: EdgeInsets.only(bottom: width*0.036),
                child: Center(
                  child: ButtonTheme(
                    minWidth: width*0.8,
                    height: height*0.05,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                      child: Text('지금 퀴즈 풀기', style: TextStyle(color: Colors.white),),
                      color: Colors.deepPurple,
                      onPressed: () {
                        Navigator.of(context).push( MaterialPageRoute(builder: (context) => QuizScreen(quizes)));
                      },
                    ),
                  ),
                ),

              )
            ],
          ),
        );
  }

  Widget _buildStep(double width, String title){
    return Container(
      padding: EdgeInsets.fromLTRB((width - (width*0.8))/2, width*0.024, width*0.048, width*0.024),
      child: Row(
        children: <Widget>[
          Icon(Icons.check_box, size: width*0.04),
          Padding(padding: EdgeInsets.only(right: width*0.024)),
          Text(title),
        ],
      ),
    );

  }
}
