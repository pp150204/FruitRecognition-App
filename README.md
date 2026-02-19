# 🍎 Fruit Recognition App (Flutter + Teachable Machine)

A simple and smart Fruit Recognition mobile app built using Flutter and a TensorFlow Lite model trained with Google Teachable Machine.
The app can detect fruits from gallery images or camera in real-time.

Currently, the model is trained to recognize:

* 🍎 Apple
* 🍌 Banana
* 🍊 Orange

---

## 🚀 Features

* 📷 Detect fruit using Camera
* 🖼️ Select image from Gallery
* 🤖 AI-based image classification
* ⚡ Fast and lightweight TensorFlow Lite model
* 🎯 Confidence score display
* 🎨 Clean and modern UI

---

## 🧠 Model Information

The machine learning model was trained using **Google Teachable Machine** with image classification.

### Model Details:

* Model Type: Image Classification
* Export Format: TensorFlow Lite (.tflite)
* Classes: Apple, Banana, Orange
* Input Size: 224 x 224 (recommended)

---

## 🛠️ Tech Stack

* Flutter (Dart)
* TensorFlow Lite (TFLite)
* Teachable Machine (Model Training)
* Image Picker (Camera & Gallery)
* Material UI

---

## 📸 How It Works

1. User selects an image from Gallery or Camera
2. Image is resized to match model input size
3. TensorFlow Lite model processes the image
4. App displays the predicted fruit with confidence percentage

Example Output:

```
• 1 banana (100.0%)
```

---

## 🧪 Model Training Steps (Teachable Machine)

1. Go to Teachable Machine
2. Create Image Classification Project
3. Add classes (Apple, Banana, Orange)
4. Upload 100+ images per class
5. Train the model
6. Export as TensorFlow Lite
7. Add `.tflite` and `labels.txt` to Flutter assets

---

## ⚙️ Installation & Setup

### Prerequisites

* Flutter SDK
* Android Studio / VS Code
* Dart installed

### Steps to Run

```bash
git clone https://github.com/your-username/fruit-recognition-app.git
cd fruit-recognition-app
flutter pub get
flutter run
```

---

## 🔮 Future Improvements

* Support for more fruit classes (Mango, Grapes, Pineapple)
* Real-time camera detection (Live Detection)
* Better accuracy with larger dataset
* Offline model optimization
* Multi-object detection

---

## ⚠️ Limitations

* Model currently detects only 3 fruits (Apple, Banana, Orange)
* May misclassify unknown objects due to limited training classes
* Accuracy depends on image quality and lighting

---

## 👨‍💻 Developer

**Prathamesh Pimpare**
Flutter Developer | AI Enthusiast

---

## ⭐ If you like this project

Give it a star on GitHub and support the project!
