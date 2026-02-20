# Kolesa Manager App
app for resale
### Mason Bricks

[Mason CLI](https://pub.dev/packages/mason_cli) allows developers to create and consume reusable templates called bricks powered by the mason generator.

[Link to step-by-step implementation guide](https://blog.codemagic.io/mason-cli/)

---

### Install app icons

Android app uses 2 types of icons - _round_ and _square_.
You need icon with png format, 1024x1024 resolution.
Source app icons placed in `assets/app_icon`.

**Generate responsive app icons**

- Upload **square** type icon to [AppIcon](https://www.appicon.co/) and select only Android checkbox. Define output file name `launcher_icon` and click **_Generate_**.
- Paste and merge generate folders with existing items to `android/app/src/main/res`.
- Repeate previous steps with **round** icon and write output file name `round_launcher_icon`.

Note that `launcher_icon` defined in `AndroidManifest.xml`, if you want to change icon file names, make sure to update manifest file.

```
 <application
        ...
        ...
        android:icon="@mipmap/launcher_icon"
        android:roundIcon="@mipmap/round_launcher_icon"
        ...
        ...>
```

- Run `dart pub get` then build app with new app icons.
