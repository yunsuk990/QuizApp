import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/widget/widget_candidate.dart';

import '../model/quiz_dart.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizes;
  QuizScreen(this.quizes);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  //각 문제별 정답
  List<int> _answers = [-1,-1,-1];
  //문제에서 보기를 선택했는지(풀었는지)
  List<bool> _answerState = [false, false, false, false];
  //현재 어떤 문제를 보고 있는지
  int _currentIndex = 0;
  SwiperController _controller = SwiperController();


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple)
          ),
          width: width*0.85,
          height: height*0.5,
          child: Swiper(
            controller: _controller,
            loop: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.quizes.length,
            itemBuilder: (BuildContext context, int index){
              return _buildQuizCard(widget.quizes[index], width, height);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz , double width, double height){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Container(
            padding: EdgeInsets.fromLTRB(0, width*0.024,0,width*0.024),
            child: Text('Q${_currentIndex+1}.', style: TextStyle(fontSize: width*0.06, fontWeight: FontWeight.bold),)),

          Container(
            padding: EdgeInsets.only(top: width*0.012),
            width: width*0.8,
            child: AutoSizeText(quiz.title, textAlign: TextAlign.center, style: TextStyle(fontSize: width*0.048, fontWeight: FontWeight.bold), maxLines: 2,),
          ),

          Expanded(child: Container()),

          Column(
            children: _buildCandidates(width,quiz)
          ),
          
          Container(
            padding: EdgeInsets.all(width*0.024),
            child: Center(child: ButtonTheme(
                minWidth: width*0.5,
                height: height*0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                    textColor: _answers[_currentIndex] == -1 ? Colors.black : Colors.white,
                    disabledColor: Colors.grey,
                    color: Colors.deepPurple,
                    onPressed:
                      (_answers[_currentIndex] == -1) ? null : () {
                        if(_currentIndex == widget.quizes.length-1){}
                        else{
                          _answerState = [false,false,false,false];
                          _currentIndex += 1;
                          _controller.next();
                        }
                    },
                    child: _currentIndex == widget.quizes.length-1 ? Text("결과보기") : Text("다음문제"),
                )
              )
            )
          )

        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for(int i=0; i<4; i++){
      _children.add(
        CandWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for(int j=0 ; j<4; j++){
                if(j==i){
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                }else{
                  _answerState[j] = false;
                }
              }
            });
          }
        )
      );

      _children.add(
        Padding(padding: EdgeInsets.all(width*0.024))
      );
    }
    return _children;
  }
}
