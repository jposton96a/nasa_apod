# nasa_apod

This was a quick weekend project used to explore the Flutter 2 API. The goal of this project was to use Flutter to recreate a past project that had been written in native Android.

Since this is my first app in Flutter 2.0, I'm sure there's plenty I got wrong. Feel free to create an issue or PR to show me how to improve!

The app's functions are simple. The user can scroll through a paginated feed of images about space travel collected from the NASA Astronomical Picture of the Day API. Background text description and a closer look at the image is available on the details page!


## Getting Started

### Building the App
See the [dockerfile](dockerfile) and [compose file](docker-compose.yml) for info on how to build & run the app

```bash
$ git checkout ... && cd nasa_apod
$ docker-compose up
# open webpage to localhost:8080
# NOTE: You must disable CORS in your browser to run this app
```

### 

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Screenshots

**Photo Feed**

![](screenshots\feed.jpg)

**A Closer Look**

![](screenshots\details.jpg)


**Background and Photo Details**

![](screenshots\details_text.jpg)