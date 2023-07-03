class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(
    Question(
      "How are you feeling?",
      [
        Answer("Great!", true),
        Answer("I'm doing well", true),
        Answer("I'm feeling a bit tired", true),
        Answer("I'm not feeling my best today", true),
      ],
    ),
  );

  list.add(
    Question(
      "How often do you engage in physical exercise or activity?",
      [
        Answer("Daily!", true),
        Answer("3-4 times a week", true),
        Answer("1-2 times a week", true),
        Answer("Rarely or never", true),
      ],
    ),
  );

  list.add(
    Question(
      "How often do you experience stress or anxiety?",
      [
        Answer("Rarely or never", true),
        Answer("Occasionally", true),
        Answer("Frequently", true),
        Answer("Constantly", true),
      ],
    ),
  );

  list.add(
    Question(
      "How often do you engage in activities that help you relax and unwind?",
      [
        Answer("Daily", true),
        Answer("Several times a week", true),
        Answer("Occasionally", true),
        Answer("Rarely or never", true),
      ],
    ),
  );

  return list; // Add this return statement
}
