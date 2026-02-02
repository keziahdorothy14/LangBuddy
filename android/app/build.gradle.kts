plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

        android {
            namespace = "com.yourcompany.langbuddy"
            compileSdk = 34  // or use flutter.compileSdkVersion if you prefer

            defaultConfig {
                applicationId = "com.yourcompany.langbuddy"
                minSdk = flutter.minSdkVersion
                targetSdk = 34
                versionCode = 1
                versionName = "1.0.0"
            }

            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_11
                targetCompatibility = JavaVersion.VERSION_11
            }

            kotlinOptions {
                jvmTarget = JavaVersion.VERSION_11.toString()
            }

            signingConfigs {
                create("release") {
                    val keystorePropertiesFile = rootProject.file("android/key.properties")
                    val keystoreProperties = Properties().apply {
                        load(keystorePropertiesFile.inputStream())
                    }

                    keyAlias = keystoreProperties["keyAlias"] as String
                    keyPassword = keystoreProperties["keyPassword"] as String
                    storeFile = file(keystoreProperties["storeFile"] as String)
                    storePassword = keystoreProperties["storePassword"] as String
                }
            }

            buildTypes {
                getByName("release") {
                    signingConfig = signingConfigs.getByName("release")
                    isMinifyEnabled = false
                    isShrinkResources = false
                }
                getByName("debug") {
                    // optional: you can also sign debug builds
                }
            }
        }

flutter {
    source = "../.."
}
