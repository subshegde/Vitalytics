# 🌿 Vitalytics – AI-Powered Skin Disease Detection & Wellness App

Vitalytics is an intelligent Flutter-based mobile application designed to detect skin diseases using image analysis and provide users with personalized medical, homeopathy, and home-based remedies.  
The app also includes skincare tips, nutrition guides, and disease progress tracking through timelines and interactive graphs.

---

## 📌 **Project Scope**

Vitalytics focuses on three major areas:

### 🔍 **1. Skin Disease Detection**
- Upload images from **camera** or **gallery**
- AI-based detection of various skin conditions
- Displays:
  - Medical recommendations  
  - Suggested medicines  
  - Homeopathy guidance  
  - Home solutions / remedies  

---

### 🏠 **2. Home Section**
Includes:
- Daily Skin Care Tips  
- Discover More (learn about skin health, hygiene, prevention)
- Image upload entry point  
- Recommended routines based on detected conditions  

---

### 🍎 **3. Nutrition & Wellness**
Suggestions based on skin health:
- Fruits  
- Vegetables  
- Healthy proteins  
- Healthy drinks  
- Recommended vitamins & hydration routines  

---

### 📈 **4. Disease Progress Tracking**
- Timeline view of each detection
- Graph-based progress tracking (powered by **fl_chart**)
- Shows improvement or worsening over time  

---

## 🧩 **Tech Stack**

### **Frontend:**  
- Flutter SDK 3.9.2  
- Dart  
- BLoC State Management (`flutter_bloc`)  
- Material UI  

### **System Features:**  
- Image Picker  
- API integration via Dio  
- JSON serialization with `freezed` and `json_serializable`

---

These are the Flutter packages used in the project:

| Package | Purpose |
|--------|----------|
| `dotted_border` | UI decoration |
| `flutter_bloc` | State management |
| `intl` | Date/time formatting |
| `fl_chart` | Graphs for progress tracking |
| `freezed_annotation` | Data models |
| `json_annotation` | JSON parsing |
| `flutter_launcher_icons` | Change app icon |
| `dio` | API calls |
| `logger` | Logging |
| `image_picker` | Camera / gallery image selection |
| `build_runner` | Code generation |
| `freezed` | Model generation |
| `json_serializable` | JSON convertor |

---

## 🚀 **How to Run the Project**

### 1️⃣ Install Dependencies
```bash
flutter pub get
```

### 2️⃣ Generate Data Models
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3️⃣ Run the App
```
flutter run
```

### 🎨 Change App Logo
```
flutter pub run flutter_launcher_icons
```
