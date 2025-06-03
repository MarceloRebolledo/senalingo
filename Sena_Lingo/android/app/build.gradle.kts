plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.sena_lingo"
    compileSdk = flutter.compileSdkVersion
    // --> Forzamos aquí la versión mínima de NDK que piden los plugins Firebase:
    ndkVersion = "27.0.12077973"

    ndkVersion = flutter.ndkVersion  // Opcional: esta línea puedes dejarla o reemplazarla si flutter.ndkVersion no apunta a 27.0.12077973

    defaultConfig {
        applicationId = "com.example.sena_lingo"
        minSdk = 23
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Aquí van tus dependencias, por ejemplo:
    implementation(platform("com.google.firebase:firebase-bom:33.14.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")

    // … si necesitas agregar la dependencia de Facebook manualmente, corrige la versión:
    // (más adelante veremos el porqué)
    implementation("com.facebook.android:facebook-android-sdk:8.2.0")
}
