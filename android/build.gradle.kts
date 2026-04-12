plugins {
    id("com.android.library")
}

// AGP 9+ has built-in Kotlin support; older versions need the plugin explicitly
val agpMajor = com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION.split(".")[0].toInt()
if (agpMajor < 9) {
    apply(plugin = "kotlin-android")
}

android {
    namespace = "com.tranglequynh.flutter_upgrade_version"
    compileSdk = 34

    defaultConfig {
        minSdk = 21
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

dependencies {
    implementation("com.google.android.play:app-update:2.1.0")
    implementation("com.google.android.play:app-update-ktx:2.1.0")
}
