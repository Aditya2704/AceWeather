
# Ace Weather

Convert your old phone into a weather station.

Use your old phone as an always on display that shows the time, date and live weather updates.


## Features

- Live current weather updates
- 3 day weather forecast
- Digital clock



## Screenshots

![Login Screen](/assets/screenshots/1.jpg?raw=true "Login Scren")

![Home Screen](/assets/screenshots/2.jpg?raw=true "Home Scren")


## Pre-requisites

An API key from https://openweathermap.org is required to run the app.




## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/Aditya2704/AceWeather.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `auto_route` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

**Step 4:**

Make sure you have an emulator running or a device connected. Then go to project root and execute the following command in console to run the application: 

```
flutter run
```