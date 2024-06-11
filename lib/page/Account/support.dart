import 'package:flutter/material.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupportPage> {
  final List<ExpandableQuestion> questions = [
    ExpandableQuestion(
      question: "What is MediMate?",
      answer:
          "MediMate is a comprehensive health application designed to assist users in managing their healthcare needs efficiently. It provides features such as appointment scheduling, medication reminders, health tracking, and access to medical resources.",
    ),
    ExpandableQuestion(
      question: "Is MediMate free to use?",
      answer: "Yes, MediMate is free to use.",
    ),
    ExpandableQuestion(
      question: "How do I create an account on MediMate?",
      answer:
          "To create an account on MediMate, follow these steps: [provide steps]",
    ),
    ExpandableQuestion(
      question: "How can I view my medical records on MediMate?",
      answer:
          "You can view your medical records on MediMate by navigating to the Records section in the app.",
    ),
    ExpandableQuestion(
      question: "Is my personal health information secure on MediMate?",
      answer:
          "Yes, your personal health information is secure on MediMate. We use advanced security measures to protect your data.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Account Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Help and Support',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Color(0xFF202157),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Row(
                  children: [
                    Text(
                      "Urgent problem?\nContact us now",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202157),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGradientContainer(Icons.phone_outlined, "Call"),
                      _buildGradientContainer(Icons.email_outlined, "Email"),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "Popular Questions",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202157),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Color(0xFF9799DF).withOpacity(0.5),
                  thickness: 1,
                ),
                Column(
                  children: questions
                      .map((question) => ExpandableQuestionWidget(question))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientContainer(IconData iconData, String text) {
    return Container(
      width: 130,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Color(0xFF7173BD), Color(0xFF51539B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableQuestion {
  final String question;
  final String answer;

  ExpandableQuestion({required this.question, required this.answer});
}

class ExpandableQuestionWidget extends StatefulWidget {
  final ExpandableQuestion question;

  const ExpandableQuestionWidget(this.question);

  @override
  _ExpandableQuestionWidgetState createState() =>
      _ExpandableQuestionWidgetState();
}

class _ExpandableQuestionWidgetState extends State<ExpandableQuestionWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF9799DF).withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.question.question,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202157),
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  size: 30,
                  color: Color(0xFF202157),
                ),
              ],
            ),
            if (isExpanded) ...[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text(
                  widget.question.answer,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF202157),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
