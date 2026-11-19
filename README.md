# JOMNITTAKU Arena — Live Table Tennis Arena & Telemetry App

A championship-grade Flutter application for JOMNITTAKU Table Tennis Arena featuring real-time venue radar, IoT scoreboard integration, automated match queuing, 55" stadium TV broadcast mode, and interactive dual themes.

---

## 🌟 Key Features

- **Dual Reactive Theme Engine:** Instant 1-tap switching between **Midnight Stadium Slate** (Dark Mode) and **Olympic Day Arena** (Light Mode).
- **Arena Table Radar (T1–T10):** Real-time table occupancy status, IoT sensor heartbeats, and check-in workflows.
- **League Leaderboards & Matchmaking:** Dynamic podium standings, player stats, and 1v1 challenge matchmaking.
- **55" Venue TV Arena Broadcast:** Dedicated 1920×1080 stadium spectator display mode with responsive mobile inspection.
- **IoT & Turnstile Access:** Dynamic DuitNow QR checkout, gate pass generation, and automated hardware controller.
- **Play The Champion Live Auction:** Live bidding interface with dial countdown clock and ladder presets.
- **Duolingo-Inspired Gamification:** Progression path, daily quests, streak tracking, and XP economy.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.24+ recommended)
- Chrome / Edge for Web preview

### Run the App

```bash
# Clone the repository
git clone https://github.com/NR-aisa/Tsport_NomanShow.git
cd Tsport_NomanShow

# Install dependencies
flutter pub get

# Run on Web Server
flutter run -d chrome
# or
flutter run -d web-server --web-port 8080 --web-hostname localhost
```

---

## 🧪 Testing

Run the full end-to-end test suite across all 17 screens in both Dark and Light modes:

```bash
flutter test
```

Run code analysis:

```bash
flutter analyze
```

---

## 📱 Supported Platforms

- Flutter Web (Desktop, Tablet, Mobile browsers)
- Android & iOS
- 55" Stadium TV Displays (1080p / 4K)
