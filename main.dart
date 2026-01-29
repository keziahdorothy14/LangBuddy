import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LangBuddyApp());
}

/* ================= APP ROOT ================= */

class LangBuddyApp extends StatelessWidget {
  const LangBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LangBuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

/* ================= DATA ================= */

final List<Map<String, dynamic>> vocabularyData = [
  {
    "word": "Apple",
    "translations": {
      "English": "Apple",
      "French": "Pomme",
      "Spanish": "Manzana",
      "Hindi": "सेब",
      "German": "Apfel",
      "Italian": "Mela",
      "Japanese": "リンゴ",
      "Chinese": "苹果",
      "Arabic": "تفاح",
      "Russian": "Яблоко"
    },
    "tts": {
      "English": "en-US",
      "French": "fr-FR",
      "Spanish": "es-ES",
      "Hindi": "hi-IN",
      "German": "de-DE",
      "Italian": "it-IT",
      "Japanese": "ja-JP",
      "Chinese": "zh-CN",
      "Arabic": "ar-SA",
      "Russian": "ru-RU"
    }
  },
  {
    "word": "Water",
    "translations": {
      "English": "Water",
      "French": "Eau",
      "Spanish": "Agua",
      "Hindi": "पानी",
      "German": "Wasser",
      "Italian": "Acqua",
      "Japanese": "水",
      "Chinese": "水",
      "Arabic": "ماء",
      "Russian": "Вода"
    },
    "tts": {
      "English": "en-US",
      "French": "fr-FR",
      "Spanish": "es-ES",
      "Hindi": "hi-IN",
      "German": "de-DE",
      "Italian": "it-IT",
      "Japanese": "ja-JP",
      "Chinese": "zh-CN",
      "Arabic": "ar-SA",
      "Russian": "ru-RU"
    }
  },
  {
    "word": "Thank you",
    "translations": {
      "English": "Thank you",
      "French": "Merci",
      "Spanish": "Gracias",
      "Hindi": "धन्यवाद",
      "German": "Danke",
      "Italian": "Grazie",
      "Japanese": "ありがとう",
      "Chinese": "谢谢",
      "Arabic": "شكرا",
      "Russian": "Спасибо"
    },
    "tts": {
      "English": "en-US",
      "French": "fr-FR",
      "Spanish": "es-ES",
      "Hindi": "hi-IN",
      "German": "de-DE",
      "Italian": "it-IT",
      "Japanese": "ja-JP",
      "Chinese": "zh-CN",
      "Arabic": "ar-SA",
      "Russian": "ru-RU"
    }
  },
  {
    "word": "Hello",
    "translations": {
      "English": "Hello",
      "French": "Bonjour",
      "Spanish": "Hola",
      "Hindi": "नमस्ते",
      "German": "Hallo",
      "Italian": "Ciao",
      "Japanese": "こんにちは",
      "Chinese": "你好",
      "Arabic": "مرحبا",
      "Russian": "Привет"
    },
    "tts": {
      "English": "en-US",
      "French": "fr-FR",
      "Spanish": "es-ES",
      "Hindi": "hi-IN",
      "German": "de-DE",
      "Italian": "it-IT",
      "Japanese": "ja-JP",
      "Chinese": "zh-CN",
      "Arabic": "ar-SA",
      "Russian": "ru-RU"
    }
  },
];

/* ================= HOME SCREEN ================= */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LangBuddy")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A5CF0), Color(0xFF6A7BFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Choose Language",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    items: [
                      "English",
                      "French",
                      "Spanish",
                      "Hindi",
                      "German",
                      "Italian",
                      "Japanese",
                      "Chinese",
                      "Arabic",
                      "Russian"
                    ]
                        .map((l) =>
                        DropdownMenuItem(value: l, child: Text(l)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedLanguage = v!),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    card(Icons.search, "Search",
                            () => open(context, const SearchScreen())),
                    card(Icons.book, "Vocabulary",
                            () => open(
                            context,
                            VocabularyScreen(
                                language: selectedLanguage))),
                    card(Icons.chat, "Phrases",
                            () => open(context,
                            PhraseScreen(language: selectedLanguage))),
                    card(Icons.volume_up, "Pronunciation",
                            () => open(
                            context,
                            PronunciationScreen(
                                language: selectedLanguage))),
                    card(Icons.quiz, "Quiz",
                            () => open(
                            context, QuizScreen(language: selectedLanguage))),
                    card(Icons.bar_chart, "Progress",
                            () => open(context, const ProgressScreen())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ================= UI HELPERS ================= */

Widget card(IconData icon, String title, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.indigo),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

void open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

/* ================= SEARCH SCREEN ================= */

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final FlutterTts tts = FlutterTts();
  late stt.SpeechToText speech;

  Map<String, dynamic>? result;

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  void search(String query) {
    setState(() {
      result = vocabularyData.firstWhere(
            (w) => w.values.any((v) =>
        v is String && v.toLowerCase() == query.toLowerCase()),
        orElse: () => {},
      );
      if (result!.isEmpty) result = null;
    });
  }

  void voiceSearch() async {
    bool available = await speech.initialize();
    if (available) {
      speech.listen(onResult: (res) {
        controller.text = res.recognizedWords;
        search(controller.text);
      });
    }
  }

  Widget translationRow(String lang, String word, String locale) {
    return Card(
      child: ListTile(
        title: Text("$lang: $word"),
        trailing: IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () async {
            await tts.setLanguage(locale);
            await tts.speak(word);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Word")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Search word...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: voiceSearch,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onSubmitted: search,
            ),
            const SizedBox(height: 20),
            if (result != null)
              Expanded(
                child: ListView(
                  children: (result!["translations"] as Map<String, String>)
                      .entries
                      .map((e) => translationRow(
                      e.key, e.value, result!["tts"][e.key]!))
                      .toList(),
                ),
              )
            else
              const Text("No result found"),
          ],
        ),
      ),
    );
  }
}

/* ================= VOCABULARY SCREEN ================= */

class VocabularyScreen extends StatelessWidget {
  final String language;
  VocabularyScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vocabulary")),
      body: ListView(
        children: vocabularyData
            .map((w) => Card(
          child: ListTile(
            title: Text("${w['word']} → ${w['translations'][language]}"),
          ),
        ))
            .toList(),
      ),
    );
  }
}

/* ================= PHRASES SCREEN ================= */

class PhraseScreen extends StatefulWidget {
  final String language;
  PhraseScreen({super.key, required this.language});

  @override
  State<PhraseScreen> createState() => _PhraseScreenState();
}

class _PhraseScreenState extends State<PhraseScreen> {
  late FlutterTts tts;
  final List<String> phrases = ["Hello", "How are you?", "Thank you", "Goodbye"];

  @override
  void initState() {
    super.initState();
    tts = FlutterTts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Phrases")),
      body: ListView(
        children: phrases
            .map(
              (p) => Card(
            child: ListTile(
              title: Text(p),
              trailing: const Icon(Icons.volume_up),
              onTap: () => tts.speak(p),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}

/* ================= PRONUNCIATION SCREEN ================= */

class PronunciationScreen extends StatefulWidget {
  final String language;
  PronunciationScreen({super.key, required this.language});

  @override
  State<PronunciationScreen> createState() => _PronunciationScreenState();
}

class _PronunciationScreenState extends State<PronunciationScreen> {
  late FlutterTts tts;
  final List<String> words = ["Apple", "Water", "Thank you", "Hello"];

  @override
  void initState() {
    super.initState();
    tts = FlutterTts();
  }

  String getTTSLocale(String word) {
    final entry = vocabularyData.firstWhere((e) => e["word"] == word);
    return entry["tts"][widget.language]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pronunciation")),
      body: ListView(
        children: words
            .map(
              (w) => Card(
            child: ListTile(
              title: Text("$w (${widget.language})"),
              trailing: const Icon(Icons.volume_up),
              onTap: () async {
                await tts.setLanguage(getTTSLocale(w));
                await tts.speak(vocabularyData
                    .firstWhere((e) => e["word"] == w)["translations"]
                [widget.language]!);
              },
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}

/* ================= QUIZ SCREEN ================= */

class QuizScreen extends StatefulWidget {
  final String language;
  QuizScreen({super.key, required this.language});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "q": "Apple in French?",
      "options": ["Pomme", "Eau", "Merci"],
      "answer": "Pomme"
    },
    {
      "q": "Thank you in French?",
      "options": ["Bonjour", "Merci", "Au revoir"],
      "answer": "Merci"
    },
  ];

  void answer(String selected) async {
    if (selected == questions[index]["answer"]) score++;
    if (index < questions.length - 1) {
      setState(() => index++);
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt("score", score);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Quiz Completed"),
          content: Text("Your Score: $score"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: const Text("OK"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(questions[index]["q"], style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...questions[index]["options"]
                .map<Widget>((o) => ElevatedButton(
                onPressed: () => answer(o), child: Text(o)))
          ],
        ),
      ),
    );
  }
}

/* ================= PROGRESS SCREEN ================= */

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int score = 0;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => score = prefs.getInt("score") ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: Center(
          child: Text("Last Quiz Score: $score",
              style: const TextStyle(fontSize: 22))),
    );
  }
}
