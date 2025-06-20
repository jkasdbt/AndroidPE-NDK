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
   - If you choose `r24`, set `ndkVersion` to `"24.0.8215888"`.
   - If you choose `r28b`, set `ndkVersion` to `"28.1.13356709"`.
   - If you choose `r29-beta1`, set `ndkVersion` to `"29.0.13113456"`.
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
    compileSdk 34
    buildToolsVersion "34.0.0"
    ndkVersion "28.1.13356709"

    defaultConfig {
        applicationId "com.myapplication"
        minSdk 26
        targetSdk 34
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
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
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
- [x] [jzinferno](https://github.com/jzinferno/termux-ndk)
- [x] [lzhiyong](https://github.com/lzhiyong/termux-ndk)
- [x] [HomuHomu833](https://github.com/HomuHomu833/android-ndk-custom)
