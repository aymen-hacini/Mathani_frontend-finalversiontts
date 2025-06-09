import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// A simple app to recognize and compare the recitation of Surah Al-Fatihah
/// using the speech_to_text package.

class SurahHomePage extends StatefulWidget {
  const SurahHomePage({super.key});

  @override
  _SurahHomePageState createState() => _SurahHomePageState();
}

class _SurahHomePageState extends State<SurahHomePage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';
  double _precision = 0.0;
  List<InlineSpan> _highlightedWords = [];

  final List<String> _surahFatihah = [
    "بسم الله الرحمن الرحيم",
    "الحمد لله رب العالمين",
    "الرحمن الرحيم",
    "ملك يوم الدين",
    "اياك نعبد واياك نستعين",
    "اهدنا الصراط المستقيم",
    "صراط الذين انعمت عليهم غير المغضوب عليهم ولا الضالين"
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
        _recognizedText = '';
        _highlightedWords = [];
      });

      _speech.listen(
        localeId: "ar-DZ", // or "ar-SA"
        listenOptions: stt.SpeechListenOptions(
            listenMode: stt.ListenMode.dictation,
            cancelOnError: false,
            partialResults: true),

        listenFor: const Duration(minutes: 5), // stays on for 5 minutes
        pauseFor: const Duration(
            seconds: 10), // waits 40s of silence before auto-stop
        onResult: (val) {
          setState(() {
            print("recognized words : ${val.recognizedWords}");
            _recognizedText = val.recognizedWords;
            _calculatePrecisionAndHighlight(_recognizedText);
          });
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _calculatePrecisionAndHighlight(String input) {
    List<String> spokenWords = input.trim().split(RegExp(r'\s+'));
    List<String> correctWords =
        _surahFatihah.join(' ').trim().split(RegExp(r'\s+'));

    int matched = 0;
    List<InlineSpan> spans = [];

    for (int i = 0; i < spokenWords.length; i++) {
      String spokenWord = spokenWords[i];
      String correctWord = i < correctWords.length ? correctWords[i] : '';

      bool isMatch = spokenWord == correctWord;
      if (isMatch) matched++;

      spans.add(
        TextSpan(
          text: '$spokenWord ',
          style: TextStyle(
            color: isMatch ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
    }

    print("matched words: $matched");
    print("total correct words: ${correctWords.length}");

    setState(() {
      _highlightedWords = spans;
      _precision = (matched / correctWords.length) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حفظ سورة الفاتحة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
                textDirection: TextDirection.rtl,
                "اضغط على الزر بدأ الحفظ و قم بترتيل سورة الفاتحة برواية ورش عن نافع و سيظهر ترتيلك في الاسفل",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: _highlightedWords,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "🎯 الدقة: ${_precision.toStringAsFixed(2)}%",
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isListening ? _stopListening : _startListening,
              child: Text(_isListening ? 'وقف الحفظ' : 'بدأ الحفظ'),
            ),
            const SizedBox(height: 20),
            const Text(
              "الرجاء التأكد من نطق الكلمات بشكل صحيح و واضح.",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 159, 143, 0)),
            ),
            const Text(
              "\nملاحظة: هذا التطبيق لا يزال قيد التطوير وقد لا يكون دقيقًا في بعض الأحيان.",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
