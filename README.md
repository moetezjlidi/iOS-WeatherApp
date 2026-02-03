# MyWeatherApp 🌤️

A modern iOS weather application built with SwiftUI and SwiftData that allows users to track weather conditions for multiple cities in real-time.

## Features ✨

- **Multi-City Tracking**: Add and monitor weather for multiple cities simultaneously
- **Real-Time Weather Data**: Fetches current weather information from OpenWeatherMap API
- **Beautiful UI**: Clean, intuitive interface with weather-based gradient backgrounds
- **Persistent Storage**: Uses SwiftData to save your cities locally
- **Pull to Refresh**: Update all cities' weather data with a simple pull-down gesture
- **Detailed Weather Information**: View temperature, weather conditions, wind speed, and coordinates
- **Smart Rate Limiting**: Prevents excessive API calls with 1-minute cooldown between refreshes

## Screenshots 📱

The app features:
- **Home Screen**: List view of all your saved cities with current temperature and weather
- **Empty State**: Helpful guidance when no cities are added
- **Add City Modal**: Simple popup to add new cities
- **City Detail View**: Full weather details with dynamic gradient backgrounds

## Requirements 📋

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- OpenWeatherMap API Key

## Installation 🚀

1. Clone the repository:
```bash
git clone https://github.com/moetezjlidi/iOS-WeatherApp.git
cd iOS-WeatherApp
```

2. Open the project in Xcode:
```bash
open MyWeatherApp/MyWeatherApp.xcodeproj
```
(If there's no .xcodeproj file, open the folder directly in Xcode)

3. Configure your OpenWeatherMap API Key:
   - Sign up for a free API key at [OpenWeatherMap](https://openweathermap.org/api)
   - Replace the API key in the following files:
     - `HomeScreen.swift` (line 11)
     - `AddCity.swift` (line 8)
   - Replace `"c27baf976fb40bb27b2b0fea6b55928a"` with your own API key

4. Build and run the project (⌘R)

## API Configuration 🔑

This app uses the [OpenWeatherMap API](https://openweathermap.org/api) to fetch weather data. 

### Getting an API Key:
1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Create a free account
3. Navigate to API Keys section
4. Copy your API key
5. Replace the hardcoded API key in the source code

**Important**: For production apps, never hardcode API keys. Consider using:
- Environment variables
- Configuration files (not tracked in git)
- Secure key management services

## Architecture 🏗️

The app follows a clean SwiftUI architecture with the following components:

### Core Components

- **`MyWeatherApp.swift`**: Main app entry point with SwiftData model container setup
- **`City.swift`**: SwiftData model representing a city with weather information
- **`WeatherResponse.swift`**: Decodable models for parsing OpenWeatherMap API responses

### Views

- **`HomeScreen.swift`**: Main screen displaying list of cities with navigation and refresh capabilities
- **`DisplayCity.swift`**: Detailed view for a single city with weather information and dynamic gradients
- **`AddCity.swift`**: Modal popup for adding new cities with API validation
- **`WeatherDisplay.swift`**: Compact city weather display used in the list view
- **`EmptyView.swift`**: Empty state view shown when no cities are added

### Key Technologies

- **SwiftUI**: Modern declarative UI framework
- **SwiftData**: Apple's new data persistence framework (iOS 17+)
- **URLSession**: Networking for API calls
- **AsyncImage**: Async image loading for weather icons

## Usage 📖

1. **Adding a City**:
   - Tap the "+" button in the top-right corner
   - Enter the city name (e.g., "Marseille", "Paris", "London")
   - Tap "Valider" to add the city
   - The app will fetch and display current weather data

2. **Viewing Weather Details**:
   - Tap any city in the list to view detailed weather information
   - Details include temperature, weather condition, wind speed, and coordinates

3. **Refreshing Weather Data**:
   - Pull down on the city list to refresh all cities
   - Note: Refreshes are limited to once per minute to prevent excessive API calls

4. **Deleting a City**:
   - Swipe left on any city in the list
   - Tap the delete button to remove the city

## Data Models 📊

### City
```swift
@Model
class City {
    var id: UUID
    var name: String
    var icon: String?
    var temperature: Int?
    var weather: String?
    var desc: String?
    var speed: Double?
    var lon: Double?
    var lat: Double?
}
```

### WeatherResponse (API)
- `main.temp`: Temperature in Celsius
- `weather[].main`: Weather condition (e.g., "Sunny", "Cloudy")
- `weather[].description`: Detailed description
- `weather[].icon`: Icon code for weather visualization
- `wind.speed`: Wind speed in m/s
- `coord.lat/lon`: Geographic coordinates

## API Endpoints 🌐

The app uses the OpenWeatherMap Current Weather Data API:

```
GET https://api.openweathermap.org/data/2.5/weather
```

Parameters:
- `q`: City name
- `appid`: Your API key
- `units`: Metric (for Celsius)

## Known Limitations ⚠️

- The API key is currently hardcoded in the source code (should be moved to a secure configuration)
- Refresh rate is limited to once per minute
- No error handling for invalid city names
- No offline mode - requires internet connection to fetch weather data
- Only supports metric units (Celsius)

## Future Enhancements 🚧

Potential improvements:
- Add proper error handling and user feedback
- Implement search with city suggestions
- Add weather forecasts (hourly/daily)
- Support for imperial units
- Offline mode with cached data
- Widget support
- Dark mode optimization
- Localization support
- Better API key management

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📄

This project is open source and available for educational purposes.

## Author 👨‍💻

Created by Master IDL - January 2026

## Acknowledgments 🙏

- Weather data provided by [OpenWeatherMap](https://openweathermap.org/)
- Weather icons from OpenWeatherMap
- Built with Apple's SwiftUI and SwiftData frameworks

---

**Note**: Remember to replace the hardcoded API key with your own before running the app!
