struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let coord: Coord
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}
