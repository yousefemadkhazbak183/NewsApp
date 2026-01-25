# NewsApp 📱

## Overview
NewsApp is a modern, feature-rich Flutter application designed to deliver a seamless news reading experience. It aggregates news from various sources, offering users a personalized and interactive interface.  Built with a clean architecture and responsive design, it ensures a smooth experience across different devices.

## Key Features

### 🔥 Current Features
- **Authentication System**: Secure Login and Registration screens.
- **Onboarding Experience**: Interactive introduction to the app's features.
- **News Browsing**: browse news by categories (Sports, Politics, etc.).
- **Advanced Search**: Search for articles by keywords using a dedicated search controller.
- **Profile Management**: User profile customization.
- **Modern UI**: Polished Material Design with responsive layout using `flutter_screenutil`.
- **Cached Images**: Optimized image loading for offline capabilities.
- **Top News & Headlines**: Stay updated with the latest stories.

### 🚀 Features in Development
- **Bookmarks / Favorites**: Save articles for later reading (Structure in place).
- **Dark Mode**: Toggle between light and dark themes.
- **Push Notifications**: Real-time alerts for breaking news.
- **Social Sharing**: Share articles directly to social media.

## Technologies Used

### 🛠 Framework & Libraries
- **Flutter & Dart**: Core development framework.
- **Provider**: State management.
- **Shared Preferences**: Local data persistence.
- **HTTP**: API communication.
- **Cached Network Image**: Efficient image caching.
- **Flutter ScreenUtil**: Screen adaptation and responsiveness.
- **Shimmer**: Loading effects.
- **Flutter SVG**: Vector asset rendering.

### 🏗 Architecture
The project follows a **Feature-First / Clean Architecture** approach, ensuring scalability and maintainability.

```
lib/
├── core/                # Core layers accessible across the app
│   ├── constants/       # App constants
│   ├── data/            # Data sources (Local/Remote)
│   ├── theme/           # App customization and themes
│   ├── utils/           # Helper functions
│   └── widgets/         # Shared UI components
│
├── features/            # Feature-specific code
│   ├── auth/            # Login & Register logic
│   ├── home/            # Main news feed
│   ├── onboarding/      # App introduction
│   ├── search/          # Search functionality
│   ├── profile/         # User profile
│   └── bookmark/        # Saved articles
│
└── main.dart            # Application entry point
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0 or newer)
- Dart SDK (2.17 or newer)
- Android Studio / VS Code

### Installation
1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flutter_news_app.git
   ```
2. **Navigate to the project directory**
   ```bash
   cd flutter_news_app
   ```
3. **Install dependencies**
   ```bash
   flutter pub get
   ```
4. **Run the app**
   ```bash
   flutter run
   ```

## Development Roadmap

### Phase One ✅ (Completed)
- [x] Project Setup & Architecture
- [x] Authentication (Login/Register)
- [x] Onboarding Flow
- [x] Home & Categories
- [x] Profile Screen

### Phase Two 🔄 (In Progress)
- [x] Search Functionality
- [ ] Bookmarks/Favorites System (UI scaffolding done)
- [ ] Unit & Widget Testing

### Phase Three 📋 (Planned)
- [ ] Dark Mode Implementation
- [ ] Push Notifications
- [ ] Multi-language Support (Localization)

## Author
**Yousef Emad Khazbak**  
Flutter Developer

---
> **Note**: This project is actively maintained. Feel free to contribute by submitting a PR or opening an issue.



