import 'package:flutter/material.dart';

void main() {
  runApp(const DailyRewardsQuizApp());
}

class DailyRewardsQuizApp extends StatelessWidget {
  const DailyRewardsQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Rewards Quiz AK")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => QuizPage()));
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int coins = 0;
  int questionIndex = 0;

  final List<Map<String, Object>> questions = [
    {
      "question": "2 + 2 = ?",
      "options": ["3", "4", "5"],
      "answer": "4"
    },
    {
      "question": "Capital of India?",
      "options": ["Mumbai", "Delhi", "Kolkata"],
      "answer": "Delhi"
    },
  ];

  void answerQuestion(String selected) {
    if (selected == questions[questionIndex]["answer"]) {
      coins += 10; // 10 coins per correct answer
    }
    setState(() {
      questionIndex = (questionIndex + 1) % questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQ = questions[questionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text("Coins: $coins"),
        actions: [
          IconButton(
            icon: const Icon(Icons.card_giftcard),
            onPressed: () {
              if (coins >= 1000) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Redeem Request"),
                    content: const Text("You can redeem ₹10 now! Manual payment will be processed."),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You need at least 1000 coins to redeem.")),
                );
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentQ["question"] as String, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...(currentQ["options"] as List<String>).map((option) {
              return ElevatedButton(
                onPressed: () => answerQuestion(option),
                child: Text(option),
              );
            }),
          ],
        ),
      ),
    );
  }
}
