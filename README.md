# WeatherForecast

## How To Run
- Update your cocoapods
- Open a terminal window, and `$ cd` into this project directory.
- In the terminal, run `pod install` command.
- Open the `MyApp.xcworkspace`
- Put your `API Key` to the `APIKey.swift` file in the **Resource** folder.
- Add your Apple developer account or bundle to test on real device.
- In the simulator, please make sure you added custom location before running the app.

## Description

**Architecture**
- Using MVVM design pattern.
- Implementing a network layer by using dependency injection in order to better testability and usage.
- Create router for network requests.
- Asynchronously API requests.
- Using mock session and json data to test APIs.
- Using a json file that containts a complete list of cities for searching. I don't use Google api because it's need to make a project and get a specific Google Map API_Key and I just want keep project simple for better reviewing.

**User Interface**
1. Home Screen: All weather data are here
   - Current weather block
   - Hourly weather list
   - Daily weather list
   - Today detail block
   - pull to refresh views data
2. Search Screen: Searching new city and add it to the favorite list
3. Favorite Screen: Show favorite cities
   - Simply search and add new city from favorite.
   - Show current city at the first of list.
   - Tap on one item to set as current location and fetch it's data
 
**Libraries**
- SDWebImage: To load and cache Images and icons
- Disk: To cache favorite cities list
- Lottie: To have a better user experience when I get data from internet 
