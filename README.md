# AJAZ FLOW

A personal Android automation and workflow orchestration app. **Phase 1** is the application foundation: a premium dark UI, local workflow data, and navigation. Workflow execution is intentionally **not** implemented yet.

- Native Android · Kotlin · Jetpack Compose · Material 3
- Application ID `com.ajaz.flow` · minSdk 26 · compile/target SDK 35
- No AI APIs, no API keys, no backend, no analytics, **no Android permissions**

## Screens

| Screen | What it does |
|---|---|
| Dashboard | Branding, welcome card, total / active / draft stats, create button, recently used workflows, quick access tiles |
| Workflows | Workflow cards (name, description, status, last run), status filters, empty states |
| Create / Edit | Name, description, icon picker, live preview, save as draft |
| Details | Workflow info, steps timeline with approval markers, edit, delete, **disabled** Run button |
| Settings | Appearance (true-black toggle), app and version info, privacy summary |

Workflows are seeded with sample data on first launch and saved to a private JSON file in the app's storage, so drafts survive restarts.

## Requirements

- Android Studio Ladybug (2024.2) or newer
- JDK 17 (bundled with Android Studio)
- Android SDK Platform 35

## Open and run

1. Open the `AjazFlow` folder in Android Studio (**File → Open**).
2. Let Gradle sync finish. Android Studio creates `local.properties` with your SDK path.
3. Pick a device or emulator (API 26+) and press **Run**.

## Build the APK from the command line

```bash
./gradlew assembleDebug
```

The APK is written to `app/build/outputs/apk/debug/app-debug.apk`.
On Windows use `gradlew.bat assembleDebug`. `ANDROID_HOME` (or `local.properties`) must point to your Android SDK.

### About the Gradle wrapper JAR

`gradle/wrapper/gradle-wrapper.jar` is **not included** in this ZIP: the environment that produced it had no network access, and a binary cannot be reproduced by hand. `gradlew` and `gradlew.bat` are the standard launchers and stop with a clear message if the JAR is missing. They do not download anything.

Create it once, from the official Gradle 8.10.2 distribution, and commit it:

```bash
gradle wrapper --gradle-version 8.10.2     # any local Gradle install
git add gradle/wrapper/gradle-wrapper.jar gradlew gradlew.bat
```

Android Studio users can instead use a downloaded Gradle 8.10.2 for that one command. The GitHub Actions workflow does the same automatically when the JAR is not committed, then validates it with `gradle/actions/wrapper-validation`.

## GitHub Actions

`.github/workflows/android-build.yml` runs on every push to `main` and on manual **Run workflow**. It sets up JDK 17, installs Android SDK Platform 35 and Build Tools 34.0.0 / 35.0.0 (and checks they are present), sets up Gradle, generates and validates the wrapper JAR if it is missing, runs `./gradlew assembleDebug`, and uploads the APK.

To get the APK: **Actions → Android Build → latest run → Artifacts → `ajaz-flow-debug-apk`**.

## Project structure

```
app/src/main/java/com/ajaz/flow/
├── MainActivity.kt
├── core/          AppContainer, Application class, time formatting, ViewModel helpers
├── data/
│   ├── local/        JSON codec for on-device persistence
│   ├── repository/   FileWorkflowRepository
│   ├── sample/       Seed workflows
│   └── settings/     AppSettings (SharedPreferences)
├── domain/
│   ├── model/        Workflow, WorkflowStep, enums
│   └── repository/   WorkflowRepository interface
├── navigation/    Routes, NavHost, bottom bar scaffold
└── ui/
    ├── theme/        Colours, typography, Material 3 theme
    ├── components/   Shared composables (cards, chips, badges, top bar, empty state, brand mark)
    ├── dashboard/    workflows/    details/    create/    settings/
```

Architecture: MVVM. Each screen has a ViewModel exposing state; ViewModels depend on the `WorkflowRepository` interface; `AppContainer` wires the implementation (no DI framework needed yet).

## Out of scope for Phase 1

Running workflows, controlling other apps, accessibility services, notifications, step editing, import/export. The Run button is a disabled demo control by design.
