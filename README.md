# Trash Tornado

Trash Tornado is a Flutter arcade game where players swipe plastic, metal, paper, glass, and food waste into matching bins while avoiding toxic barrels.

## Game Features

- Swipe-and-drag sorting gameplay
- Five bin types: plastic, metal, paper, glass, and food
- Toxic barrel hazards
- Cities, beaches, parks, industrial areas, and ocean maps
- Classic, ocean, fire, robot, galaxy, and toxic tornado skins
- Shop, upgrades, daily rewards, coins, gems, and energy
- Android launcher icons generated from custom game art
- GitHub Actions for analyze, test, APK, App Bundle builds, and Play Store internal-track deployment on merges to `main`

## Run Locally

```bash
flutter pub get
flutter run
```

## Verify

```bash
flutter analyze
flutter test
flutter build apk --release
flutter build appbundle --release
```

## Play Store

See [PLAYSTORE_SETUP.md](PLAYSTORE_SETUP.md) for release signing, Play Console setup, listing metadata, form answers, and the internal-track upload workflow.
