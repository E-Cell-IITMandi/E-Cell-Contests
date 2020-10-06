# An app to register for events
**This repo is not indicative of any club of IIT Mandi.**

So, do you want to manage the Team Details and Event Details easily? Get started with this project. 
A new Flutter project.

## How to use this?
This Project is based on Flutter and Firestore (Popularly known as FlutterFire). So to run this app on local server, you need flutter to be installed in your system. Remeber to upgarde flutter to channel beta so as to run the webapp. And for android, install the necessary android packages required. Google search get started with flutter.

### Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Creating a copy for your Club
Take care that you have flutter installed and working properly in beta channel. So now we will setup the firestore for this project.

### First setup a firebase project
Create a firebase project and create a firestore database in it. 
Then add this kind of sample structure there
> contests
>> eventCode (set according to you)
>> - minTeamSize: Integer
>> - maxTeamSize: Integer
>> - eventName: "Name of the Event to show"
>> - status: "open" or "close" : Wheather event is going to come or not?
>>> registrations (Will be automatically created as the first user comes, so don't worry)

That's only needed for now! Will tell you later about rules and security.
### Setting the web sdk
Create a WebApp in the firebase console, and copy the firebase config of the app. Change the current config in the `web/index.html` so that it points to your websdk.

That's it for now, now run the app using the flutter run command.
> To run on web
```
flutter run -d chrome
```

> To run on android app, connect the andorid app and then 
```
flutter run
```


### Setting the android
Checkout the officaila docs of flutter fire how to connect to use flutter for android with firebase.

**Will be updated more soon**
For any doubts or queries, contact me.




