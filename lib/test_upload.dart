import 'dart:async';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart' as path_provider;
//import '../amplifyconfiguration.dart'; // Adjust the import path as necessary

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin initialization
  await _configureAmplify(); // Correctly configure Amplify
  runApp(MyApp());
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyStorageS3()); // Add the S3 plugin
    //await Amplify.configure(amplifyconfig); // Use the imported amplifyconfig
    print("Successfully configured Amplify 🎉");
  } catch (e) {
    print("Could not configure Amplify: $e");
  }
}

Future<void> uploadTestImage() async {
  try {
    // Load the image from the project's assets
    final byteData = await rootBundle.load('asset/images/clock.jpg');
    final buffer = byteData.buffer;

    // Write the image to a temporary file
    final tempDir = await path_provider.getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/test_image.jpg');
    await tempFile.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    // Upload the temporary file to S3
    final fileName = 'test_upload_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final s3Key = 'test_uploads/$fileName';

    final result = await Amplify.Storage.uploadFile(
      local: tempFile,
      key: s3Key,
    );

    print('Successfully uploaded test image: ${result.key}');
  } catch (e) {
    print('Error uploading test image: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Amplify S3 Upload Test')),
        body: Center(
          child: ElevatedButton(
            onPressed: uploadTestImage,
            child: Text('Upload Test Image'),
          ),
        ),
      ),
    );
  }
}
