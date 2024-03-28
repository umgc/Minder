//work on progress 
  //Drafted by: Elsa Bushen
 
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// A service wrapper around the speech_to_text package for handling voice input.
class VoiceService {
  /// Instance of SpeechToText used for speech recognition.
  stt.SpeechToText _speech = stt.SpeechToText();

  /// Flag to indicate whether the service is currently listening.
  bool isListening = false;

  /// The last piece of text that was recognized by the speech recognition service.
  String text = '';

  // Implements the Singleton pattern to ensure only one instance of the service is used.
  static final VoiceService _instance = VoiceService._internal();
  factory VoiceService() => _instance;

  /// Private constructor for the singleton pattern.
  VoiceService._internal();

  /// Initializes the SpeechToText service.
  ///
  /// Returns `true` if the speech recognition is available and initialized successfully, `false` otherwise.
  Future<bool> initializeService() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'), // Callback for speech status updates.
      onError: (val) => print('onError: $val'),   // Callback for speech recognition errors.
    );
    return available;
  }

  /// Starts listening to voice input and uses the provided callback to return the recognized text.
  ///
  /// The [onResult] callback is invoked with the recognized text whenever speech is detected.
  void startListening(void Function(String text) onResult) {
    if (!isListening) { // Only start listening if it is not already doing so.
      _speech.listen(
        onResult: (val) {
          text = val.recognizedWords; // Update the text with recognized words.
          onResult(val.recognizedWords); // Invoke the callback with the recognized text.
        },
      );
      isListening = true; // Set the flag to indicate that the service is listening.
    }
  }

  /// Stops listening to voice input.
  ///
  /// This method should be called to stop the speech recognition service from listening for further input.
  void stopListening() {
    if (isListening) { // Only stop listening if the service is currently listening.
      _speech.stop(); // Stop the speech recognition.
      isListening = false; // Reset the listening flag.
    }
  }
}
