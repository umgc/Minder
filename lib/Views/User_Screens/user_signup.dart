import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:minder/Views/Caregiver_Screens/care_giver_setting.dart'; 

class SetupFaceIDScreen extends StatefulWidget {
  const SetupFaceIDScreen({Key? key}) : super(key: key);

  @override
  _SetupFaceIDScreenState createState() => _SetupFaceIDScreenState();
}

class _SetupFaceIDScreenState extends State<SetupFaceIDScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isBiometricSetUp = false;

  @override
  void initState() {
    super.initState();
    _promptBiometricSetup();
  }

  Future<void> _promptBiometricSetup() async {
    await _checkBiometrics();
    if (!_isBiometricSetUp) {
      // Show the dialog only if biometrics are not set up
      _showEnableBiometricsDialog();
    }
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    if (canCheckBiometrics && availableBiometrics.isNotEmpty) {
      setState(() {
        _isBiometricSetUp = true;
      });
      _showCongratulationsDialog();
    }
  }

  void _showEnableBiometricsDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enable Biometrics"),
        content: Text(
          "Your device's biometric authentication is not set up. Please set it up in your device's settings for enhanced security."
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Done"),
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog
              await _checkBiometrics(); // Re-check biometrics setup
            },
          ),
          TextButton(
            child: const Text("Retry"),
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog and retry immediately
              _promptBiometricSetup(); // Attempt to prompt biometric setup again
            },
          ),
        ],
      );
    },
  );
}


  void _showCongratulationsDialog() {
    if (_isBiometricSetUp) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Biometrics Set Up"),
            content: Text(
              "Congratulations! Your device's biometric authentication is set up. You can now use it for faster and more secure access."
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Continue"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Settings()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build method remains largely the same, focusing on layout and design
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Setup Biometrics', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Flexible(
              flex: 3,
              child: Image.network(
                'https://assets.api.uizard.io/api/cdn/stream/a855b4aa-8e5c-4ff0-8966-a696cb7818d5.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Secure your account by enabling biometric authentication.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
