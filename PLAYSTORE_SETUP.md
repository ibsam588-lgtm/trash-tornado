# Trash Tornado Play Store Setup

This repo is prepared to build Android release artifacts, upload Play Store listing metadata, and deploy to the internal Play Store track when changes are merged to `main`.

## 1. Create the Play Console app

Create the app manually in Google Play Console:

- App name: `Trash Tornado`
- Default language: `English (United States)`
- App or game: `Game`
- Free or paid: `Free`
- Package name: `com.ibsam.trash_tornado`

Google Play Console app creation is account-bound, so it cannot be completed from this public repo alone.

## 2. Generate an upload key

Create a private upload keystore locally and never commit it:

```bash
keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias trash-tornado-upload
```

Copy `android/key.properties.example` to `android/key.properties` and fill in the private passwords.

## 3. GitHub Actions secrets

Add these repository secrets before running `Play Store Internal Release`:

- `ANDROID_KEYSTORE_BASE64`: base64-encoded `android/app/upload-keystore.jks`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`: Play Developer API service account JSON

Add these repository variables:

- `PLAY_PRIVACY_URL`: public URL for the hosted privacy policy
- `PLAY_TRACK`: optional, defaults to `internal`
- `PLAY_RELEASE_STATUS`: optional, defaults to `completed`

On macOS or Linux:

```bash
base64 -w 0 android/app/upload-keystore.jks
```

On PowerShell:

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("android/app/upload-keystore.jks"))
```

## 4. Store listing

Play listing metadata, graphics, and screenshots live in:

```text
fastlane/metadata/android/en-US/
```

Play Console form answers live in:

```text
docs/play_console_forms.md
fastlane/play_console_forms.json
```

Replace `privacy_url.txt` or set `PLAY_PRIVACY_URL` before production submission.

## 5. Build locally

```bash
flutter pub get
flutter analyze
flutter test
flutter build appbundle --release
```

## 6. Deploy

The `.github/workflows/playstore-internal.yml` workflow runs automatically on pushes to `main`, which includes PR merges. It signs the Android App Bundle and uploads the release plus listing metadata to the Play Store internal track.

You can also run it manually from GitHub Actions with `workflow_dispatch`.
