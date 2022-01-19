# road-trips-app
## Description
An application that enables users to browse and browse the best different places around the world, inquire about the current weather for each tourist destination, see the destination’s location on the map, and follow the most explorers to travel around the world.

## User Stories
- Signup: As a user , I want to rigster so that I can save my data .
- Login: As a user , I want to login so that I can use the   
 application.
- Map : As a user, I want to search for city locations, find a city's location, and view the most prominent attractions.
- Cities : As user I can see name and picture of cities so that I select the picture and read description.
- Details :
As a user I can write a comment so that I can add a comment.
AS a user I can press like button so that I can refer to its later.
As a user, I want to see the rating for the city so that I can determine the best destination.
As a user, I want to see reviews about the city so that I can gather more information about the city.
- Explorers Travel :
As a user I can see the famous explorers travel so that I can scan their
 Snap barcode.
 - video
 As a user i want see the video of best places to other pepole so that make me choose the best places.
 - Settings :
 As a user, I want to see my data so that I can edit and save it.
As a user, I want to change the appearance of the application to allow the use of dark mode and light mode.
As a user, I want to change the language from Arabic to English and vice versa to make the application easier to use.
As a user, I want to see information about countries so that I can benefit from them.
As a user, I want to communicate with a tour guide so that it is easier for me to tour and travel.
As a user, I want to see my favorite cities so that I can come back to them later.
As a user, I want to access the best travel and reservation applications in the world so that I can book.
Logout: As a user, I can log out of Application so that no one  can use my data.

| Component        | Permissions | Behavu 
| :---             |     ---   |   :---    |
| Greating page    | public      | Frist page |
| SignupPage       | anon only   | link to login, navigate to creating page after signup.|
| login Page       | anon only   | link to login, navigate to TabBar after longIn.|
| Cities Page       |  user only | Show all cities  ,navigate us to Datails page.|
| Datails page |  user only |show us pictures of the city ,describtion.|
|Travel Explorers    |  user only | Show us travel Explorers , navigate us to Snap code page.|
| Snap code page      | user only   | View user the snap code of Travel Explorers .| 
| Video page | user only | show us the video of places.
| Weather page     | user only   | Searches for the current weather of the city.|
| Map page     | user only   | Searches for the city and its best attractions.|
| SettingPage      |  user only | Change the app language , change between dark or light mode,Countries information, Fovarate places,Contact a travel representative .|

## Components:
* Greating page
* SignupPage
* login Page
* Cities Page 
* Datails page
* Travel Explorer
*  Snap code page
* video page
*  Weather page
*  Map page
*  SettingPage 
## Service
##### Auth Service
auth.login(user)
auth.signup(user)
auth.logout()
##### Weather Service
weather Api. show weather condition
##### Information Service
Service.Country Information
## Models
struct User: Codable {
    private(set) var id: String
    private(set) var name: String
    private(set) var phoneNumber: String?
    private(set) var email: String
    private(set) var avatar: String?
}

## Slides







