# Road Trip Planner - Project README
# Back-End API
[Front-End Repo](https://github.com/garussell/road-trip-planner)

![Screenshot 2023-12-17 at 6 36 22 AM](https://github.com/garussell/road_trip_planner_be/assets/125214565/73a6bac3-9c97-4244-aed7-84279fe7da2d)
![Screenshot 2023-12-17 at 6 36 09 AM](https://github.com/garussell/road_trip_planner_be/assets/125214565/f2c947db-a6bb-469d-a847-46752aa0a9f5)

## Table of Contents

1. [Learning Goals](#learning-goals)
2. [Project Description](#project-description)
3. [Example Code](#example-code)
4. [Setup](#setup)
5. [Data Structure](#data-structure)
6. [End Points](#end-points)
7. [Suggestions for Use](#suggestions-for-use)
8. [Contributors](#contributors)

## Learning Goals
- Expose API with integration of multiple APIs, including requiring an authentication token.
- Utilize ErrorSerializer and JSONAPI formatting.
- Impliment `caching` to speed up process when search query includes location / city & state or latitude & longitude.
- Complete application based on criteria from other developers.
- Practice robust testing for poros, services, facades, and requests using mocking tool VCR.

## Project Description
**Road Trip Planner BE** is a back-end project that exposes multiple API endpoints to make data available from [MapQuest API](https://developer.mapquest.com/documentation/geocoding-api/), [Unspash API](https://unsplash.com/documentation), [Open Library API](https://openlibrary.org/developers), and [Weather API](https://www.weatherapi.com/).  It allows the front-end to obtain JSON data that contains weather forecast information for a city, where the city and state are passed in the URL body as a location param.  This API also utilizes [OpenLibrary API](https://openlibrary.org/developers) to search for books about the destination location.  Additionally, there is an endpoint that retrieves a background image from [Unsplash API](https://unsplash.com/developers).

## Example Code
![Screenshot 2023-09-26 at 9 41 02 AM](https://github.com/garussell/whether_sweater/assets/125214565/022fd3f7-fa08-4689-95db-96ae4ee8306a)
![Screenshot 2023-09-26 at 9 43 01 AM](https://github.com/garussell/whether_sweater/assets/125214565/dedb6d11-6371-49dc-b57c-1b8ef6617a83)
![Screenshot 2023-09-26 at 9 44 00 AM](https://github.com/garussell/whether_sweater/assets/125214565/533c7700-6a52-434b-839d-8418255ac356)
![Screenshot 2023-09-26 at 9 44 18 AM](https://github.com/garussell/whether_sweater/assets/125214565/a0691cf6-88ef-434c-b7c7-bc9f4c0b63a5)

## Setup
- Ruby 3.2.2
- Rails 7.0.7.2
- [Faraday](https://github.com/lostisland/faraday) gem to interact with APIs
- [JSONAPI Serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) gem for formatting JSON responses
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem for code coverage tracking
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) gem for testing assertions
- [VCR](https://github.com/vcr/vcr) / [Webmock](https://github.com/bblimke/webmock) to stub HTTP requests in tests to simulate API interactions

## How to Use
- Fork/Clone the BE repo
- `bundle install`
- `rails s` to start server at `localhost:3000`
- Hit the endpoints with Postman or your front-end
- Optionally: visit the front-end repo, fork/clone,
-   `npm install` then `nmp start` - select `Y` to run on `localhost:3001` for React

## Data Structure
- `data` attribute contains `id=null`, `type="forecast"`, and `attributes`.
- `attributes` is an object that contains weather information: `current_weather`
- `current_weather` holds the weather data as `last_updated` (format "2023-04-07 16:30"), `temperature` (float / Fahrenheit), `feels_like` (float / Fahrenheit), `humidity` (int or float), `uvi` (int or float), `visibility` (int or float), `condition` (string), `icon` (png string for current weather condition) 
- `daily_weather` holds array of next 5 days of weather data: `date` (format "2023-04-07"), `sunrise` (format "07:13 AM"), `sunset` (format "08:07 PM"), `max_temp` (float / Fahrenheit), `min_temp` (float / Fahrenheit), `condition` (string), `icon` (png string for weather condition)
- `hourly_weather` holds array of 24 hours data for current day‘‘‘: `time` (format "22:00"), `temperature` (float / Fahrenheit), `conditions` (string / per hour), `icon` (png string for weather condition per hour)

## End-Points
- Get data as one endpoint: `GET /api/v1/data` - takes in 'location' as a param.
- Get weather for a city: `GET /api/v0/forecast?location=cincinatti,oh` - data can be sent as params, `units` are optional ("imperial" or "metric") - Units default to imperial.
- User Registration: `POST /api/v0/users` - raw data needs to be sent in the body of the request
- Login: `POST /api/v0/sessions` - raw data needs to be sent in the body of the request
- Create Roadtrip: `POST /api/v0/road_trip` - raw data needs to be sent in the body of the request, `units` are optional but can be passed as params ("imperial" or "metric") - Units default to imperial.
- Search Books: `GET /api/v0/book_search?location=#{location}&quantity=#{quantity}` - data can be sent as params (location); `quantity`: optional, `units`: optional ("imperial" or "metric").  Units default to imperial.
- Backgrounds: `GET api/v0/backgrounds?location=#{location}` - will return a photo of that location

## Suggestions for Use

1. Clone the application: Create a clone of this repository
2. Obtain an API key: Sign-up with email, password, and confirmation password to receive a response with your unique API key (currently no limits)


## Contributors
- [Allen Russell](allenrusselldev@gmail.com) - GitHub: [@garussell](https://github.com/garussell)



