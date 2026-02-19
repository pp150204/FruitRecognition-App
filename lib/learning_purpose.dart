// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
// import 'package:image_picker/image_picker.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   File? imagefile; //imagefile variable can have null value
//   late ImagePicker _imagePicker; //we use late becox we are gonna to inialize later
//   late ImageLabeler labeler;
//
//   @override
//   void initState() {
//     super.initState();
//     _imagePicker = ImagePicker(); //initialized imagepicker
//     ImageLabelerOptions options = ImageLabelerOptions(confidenceThreshold: 0.8);
//     labeler = ImageLabeler(options: options);
//   }
//
//   ChooseImagefromGallery() async {
//     XFile? selectedimage = await _imagePicker.pickImage(
//       source: ImageSource.gallery,
//     ); //this return xfile object
//     if (selectedimage != null) {
//       setState(() {
//         imagefile = File(selectedimage.path);
//       });
//       await performimagelabelling();
//     }
//   }
//
//   OpenCamera() async {
//     XFile? selectedimage = await _imagePicker.pickImage(
//       source: ImageSource.camera,
//     );
//     if (selectedimage != null) {
//       setState(() {
//         imagefile = File(selectedimage.path);
//       });
//       await performimagelabelling();
//     }
//   }
//
//   String result = "";
//   performimagelabelling() async {
//     result = ""; //reseeting value for each new image
//     final inputImage = InputImage.fromFile(
//       imagefile!,
//     ); //imputimage format we want
//     final List<ImageLabel> labels = await labeler.processImage(inputImage);
//
//     for (ImageLabel label in labels) {
//       final String text = label.label;
//       final int index = label.index;
//       final double confidence = label.confidence;
//       //print(text+"  "+confidence.toString());
//       setState(() {
//         result += text + "   " + confidence.toString() + "\n";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.yellow,
//         title: Text("image Reconition app"),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Card(
//                 color: Colors.grey.shade400,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height / 2,
//                   child:
//                   imagefile != null
//                       ? Image.file(imagefile!)
//                       : Icon(
//                     Icons.image_outlined,
//                     size: 100,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               Card(
//                 color: Colors.yellow,
//                 child: Container(
//                   height: 100,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: IconButton(
//                           onPressed: () {
//                             ChooseImagefromGallery();
//                           },
//                           icon: Icon(Icons.image_outlined, size: 50),
//                         ),
//                       ),
//                       Expanded(
//                         child: IconButton(
//                           onPressed: () {
//                             OpenCamera();
//                           },
//                           icon: Icon(Icons.camera_alt, size: 50),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Card(
//                 color: Colors.black,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(child: Text(result, style: TextStyle(color: Colors.white))),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }