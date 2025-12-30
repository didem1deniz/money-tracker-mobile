# 💰 Money Tracker Mobile

A modern Flutter-based expense tracking application with real-time financial management capabilities.

## 🌐 Live Demo

**Frontend**: [money-tracker-mobile.vercel.app](https://money-tracker-mobile.vercel.app)  
**Backend API**: [money-tracker-api-eight.vercel.app](https://money-tracker-api-eight.vercel.app)

## ✨ Features

- 📱 **Cross-platform** - Web, iOS, Android support
- 🔐 **User Authentication** - Secure login/register system
- 💸 **Expense Tracking** - Add, view, and manage expenses
- 📊 **Dashboard Analytics** - Visual spending insights
- 👤 **Profile Management** - Account settings and preferences
- 🌐 **API Integration** - Real-time data synchronization

## 🛠️ Tech Stack

### Frontend
- **Flutter** - Cross-platform framework
- **Dart** - Programming language
- **HTTP** - API communication
- **Material Design** - UI components

### Backend
- **Express.js** - Node.js web framework
- **Vercel** - Serverless deployment
- **REST API** - Data endpoints

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.19.0+)
- Dart SDK
- Node.js (for local API development)

### Installation

```bash
# Clone the repository
git clone https://github.com/didem1deniz/money-tracker-mobile.git
cd money-tracker-mobile

# Install dependencies
flutter pub get

# Run on web
flutter run -d web-server --web-port=3001

# Build for production
flutter build web --release
```

## 📱 App Structure

```
lib/
├── api/                    # API service layer
├── features/
│   ├── auth/              # Authentication features
│   ├── data/              # Data models & repositories
│   └── presentation/      # UI pages & widgets
├── core/                  # Core utilities
└── main.dart              # App entry point
```

## 🔧 Configuration

### API Base URL
The app connects to the live API at:
```dart
static const String baseUrl = 'https://money-tracker-api-eight.vercel.app';
```

For local development, change to:
```dart
static const String baseUrl = 'http://localhost:3000';
```

## 🌐 Deployment

### Vercel (Recommended)
1. Fork this repository
2. Connect to Vercel
3. Deploy automatically on push to `main`

### Manual Build
```bash
# Build for web
flutter build web --release

# Serve locally
cd build/web
python -m http.server 8080
```

## 🧪 Testing

### API Connection Test
The app includes a built-in API test feature:
1. Navigate to Home page
2. Scroll down to "API Status" section
3. Click "Test API Connection"
4. View connection status

### Manual Testing
```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📖 API Endpoints

Base URL: `https://money-tracker-api-eight.vercel.app`

- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `GET /expenses` - Get user expenses
- `POST /expenses` - Add new expense
- `DELETE /expenses/:id` - Delete expense

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Didem Deniz** - [@didem1deniz](https://github.com/didem1deniz)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Vercel for seamless deployment
- Material Design for UI guidelines

---

⭐ **Star this repo** if you find it helpful!
