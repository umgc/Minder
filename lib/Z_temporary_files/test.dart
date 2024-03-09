import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import '../Config/amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    if (!Amplify.isConfigured) {
      Amplify.addPlugins([AmplifyStorageS3(), AmplifyAuthCognito()]);
      try {
        await Amplify.configure(amplifyconfig);
        print("Successfully configured Amplify 🎉");
      } catch (e) {
        print("Could not configure Amplify: $e");
      }
    }
  }

  Future<void> _uploadImageFromAssets() async {
    final ByteData data = await rootBundle.load('asset/images/profile-grandmother.jpg');
    final List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/my_image.jpg');
    await file.writeAsBytes(bytes);

    try {
      final key = 'uploaded_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: file,
        key: key,
      );
      print('Upload successful: ${result.key}');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Amplify Storage Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _uploadImageFromAssets,
            child: Text('Upload Image From Assets'),
          ),
        ),
      ),
    );
  }
}
