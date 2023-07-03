import 'package:flutter/material.dart';
import 'package:testapp/question_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = [];
  int currentQuestionIndex = 0;
  Answer? selectedAnswer;
  double progressValue = 0.0;
  double incrementValue = 0.0;

  @override
  void initState() {
    super.initState();
    questionList = getQuestions(); // Initialize the question list
    incrementValue = 1.0 / questionList.length; // Calculate the increment value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 238, 220, 1.0),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (currentQuestionIndex > 0) {
                    currentQuestionIndex--;
                    progressValue -= incrementValue;
                    selectedAnswer = null;
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
              ),
              child: const Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestionWidget(),
                  const SizedBox(height: 16),
                  _answerList(),
                  const SizedBox(height: 160),
                  _buildProgressBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionWidget() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        questionList[currentQuestionIndex].questionText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _answerList() {
    return Column(
      children: questionList[currentQuestionIndex].answerList
          .map((e) => _answerButton(e))
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.brown : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() {
            selectedAnswer = answer;
            progressValue += incrementValue;
            if (progressValue >= 1.0) {
              progressValue = 1.0;
              _nextQuestion();
            }
            _nextQuestion();
          });
        },
      ),
    );
  }

  Widget _buildProgressBar() {
    return Stack(
      children: [
        LinearProgressIndicator(
          value: progressValue,
          minHeight: 20,
          backgroundColor: Colors.black,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '${(progressValue * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questionList.length - 1) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          selectedAnswer = null;
          currentQuestionIndex++;
          progressValue = currentQuestionIndex * incrementValue;
        });
      });
    } else {
      _showFinalMessage();
    }
  }

  void _showFinalMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nice to know about you!"),
          content: const Text("Click to proceed to recommended activities"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

