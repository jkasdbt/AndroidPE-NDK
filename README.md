# AndroidPE-NDK
This bash script will install NDK to [AndroidPE](https://github.com/jkasdbt/AndroidPE).
<br>
<br>
<br>

### How to install
1. Use this to start the process : _will show all versions (requires making a choice)_.
```bash
rkb install ndk
```

2. Choose your required NDK version from the list by entering the numbers provided and wait for the installation to complete.

3. After installation, edit or set `ndkVersion` in your `build.gradle` or `build.gradle.kts` file as follows:
   - If you choose `r27d`, set `ndkVersion` to `"27.3.13750724"`.
   - If you choose `r28c`, set `ndkVersion` to `"28.2.13676358"`.
<br>
<br>
<br>

You can find the downloaded ndk version names by running:
```bash
cd $HOME/android-sdk/ndk
```
<br>
<br>
<br>

⚠️ Warning: CMake works on Android 10+ Only.

   » example:

```groovy
plugins {
    id 'com.android.application'
}

android {
    compileSdk 36
    buildToolsVersion "35.0.1"
    ndkVersion "28.2.13676358"

    defaultConfig {
        applicationId "com.myapplication"
        minSdk 26
        targetSdk 36
        versionCode 1
        versionName "1.0"
    }
    
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_21
        targetCompatibility JavaVersion.VERSION_21
    }

    externalNativeBuild {
        cmake {
            path file('src/main/cpp/CMakeLists.txt')
        }
    }
}

dependencies {
   // ...
}
```
<br>
<br>
<br>

Thanks to:
- [x] [MrIkso](https://github.com/MrIkso) : Owner ([repo](https://github.com/MrIkso/AndroidIDE-NDK))
- [x] [HomuHomu833](https://github.com/HomuHomu833/android-ndk-custom)
