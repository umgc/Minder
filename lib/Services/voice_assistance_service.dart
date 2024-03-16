import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  String text = '';

  // Singleton pattern
  static final VoiceService _instance = VoiceService._internal();
  factory VoiceService() => _instance;
  VoiceService._internal();

  // Asynchronous initialization of the SpeechToText instance
  Future<bool> initializeService() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    return available;
  }

  // Start listening to voice input
  void startListening(void Function(String text) onResult) {
    if (!isListening) {
      _speech.listen(onResult: (val) {
        text = val.recognizedWords;
        onResult(val.recognizedWords);
      });
      isListening = true;
    }
  }

  // Stop listening to voice input
  void stopListening() {
    if (isListening) {
      _speech.stop();
      isListening = false;
    }
  }
}
