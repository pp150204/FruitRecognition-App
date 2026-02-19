//this is the actuall code for fruits detection
//the model is trained such that it can recodnised only three fruits apple banana and orange



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Recognition',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? imagefile;
  late ImagePicker _imagePicker;
  late ImageLabeler labeler;
  bool _isLabelerReady = false;
  String result = "";

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _initializeLabeler();
  }

  Future<void> _initializeLabeler() async {
    final modelPath = await getModelPath('assets/ml/fruits.tflite');
    final options = LocalLabelerOptions(
      confidenceThreshold: 0.7,
      modelPath: modelPath,
    );
    labeler = ImageLabeler(options: options);
    setState(() {
      _isLabelerReady = true;
    });
  }

  Future<void> ChooseImagefromGallery() async {
    XFile? selectedimage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedimage != null) {
      setState(() {
        imagefile = File(selectedimage.path);
      });
      await performimagelabelling();
    }
  }

  Future<void> OpenCamera() async {
    XFile? selectedimage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (selectedimage != null) {
      setState(() {
        imagefile = File(selectedimage.path);
      });
      await performimagelabelling();
    }
  }

  Future<void> performimagelabelling() async {
    result = "";
    final inputImage = InputImage.fromFile(imagefile!);
    final List<ImageLabel> labels = await labeler.processImage(inputImage);

    for (ImageLabel label in labels) {
      setState(() {
        result += "• ${label.label}   (${(label.confidence * 100).toStringAsFixed(1)}%)\n";
      });
    }
  }

  @override
  void dispose() {
    labeler.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Text(
          "Image Recognition",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6366F1),
                Color(0xFF8B5CF6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: !_isLabelerReady
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.2,
                width: double.infinity,
                child: imagefile != null
                    ? Image.file(imagefile!, fit: BoxFit.cover)
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image_outlined, size: 100, color: Colors.grey),
                    SizedBox(height: 8),
                    Text("No Image Selected", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 4,
                  ),
                  onPressed: _isLabelerReady ? ChooseImagefromGallery : null,
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Gallery"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 4,
                  ),
                  onPressed: _isLabelerReady ? OpenCamera : null,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Results Card
            Card(
              color: Colors.black,
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    result.isNotEmpty ? result : "No results yet. Pick an image!",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer.asUint8List(
          byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }
}
