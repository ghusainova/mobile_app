# Kolesa Manager App

---

### Properties

**Set up in android/gradle.properties**
Replace `{your_ad_login}` with your **AD login** and `{your_ad_password}` with your **AD login**.

```
org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
android.enableJetifier=true
systemProp.https.proxyPassword={your_ad_password}
systemProp.http.proxyHost=proxy-all.hq.bc
systemProp.https.proxyUser={your_ad_login}
systemProp.https.proxyHost=proxy-all.hq.bc
systemProp.https.proxyPort=8080
systemProp.http.proxyPort=8080
systemProp.http.proxyPassword={your_ad_password}
systemProp.https.nonProxyHosts=*.hq.bc;127.0.0.1;localhost;::1
systemProp.http.proxyUser={your_ad_login}
systemProp.http.nonProxyHosts=*.hq.bc;127.0.0.1;localhost;::1
```

**Set up in android/key.properties**
Create a file named _kolesa-resale-app/android/key.properties_ that contains a reference to your keystore. Don't include the angle brackets (< >). They indicate that the text serves as a placeholder for your values.

```
storePassword=<keystore-password>
keyPassword=<keystore-password>
keyAlias=upload
storeFile=<keystore-file-location>
```

**NOTE**: the storeFile might be located at /Users/<user name>/upload-keystore.jks on macOS or C:\\Users\\<user name>\\upload-keystore.jks on Windows.

---

### Local Properties

**API keys path**
Create `api_keys.dart` file in `lib\modules\shared\_data\constants\api_keys.dart` and paste here variables:

```
const sentryDsn = '{SENTRY-DSN-URL}';
```

---

### Trusted Anchors

App uses k8s cert to access some data from web, such as videos and images.
Cert expires in **16.11.2025**. If you are facing with content loading issue, check and update cert at path `android/app/src/main/res/raw/`.

App uses k8sdev cert to access some data from web, such as videos and images.
Cert expires in **5.07.2026**. If you are facing with content loading issue, check and update cert at path `android/app/src/main/res/raw/`.

App uses \*kaspi.kz cert to access sentry.kaspi.kz for logging crash events.
Cert expires in **20.05.2025**. If you are facing with content loading issue, check and update cert at path `android/app/src/main/res/raw/`.

---

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
