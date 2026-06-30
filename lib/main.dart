import 'dart:async';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';

class GameArt {
  const GameArt._();

  static const String homeBackground = 'assets/images/mockup_home_clean_bg.png';
  static const String gameplayBackground =
      'assets/images/mockup_home_clean_bg.png';
  static const String worldMapBackground =
      'assets/images/mockup_world_map_bg.png';
  static const String levelCompleteBackground =
      'assets/images/mockup_level_complete_bg.png';
  static const String iconBoost = 'assets/images/mockup_icon_boost.png';
  static const String iconMagnet = 'assets/images/mockup_icon_magnet.png';
  static const String iconFreeze = 'assets/images/mockup_icon_freeze.png';
  static const String iconEnergy = 'assets/images/mockup_icon_energy.png';
  static const String iconBinFood = 'assets/images/mockup_icon_bin_food.png';
  static const String iconBinRecycleBlue =
      'assets/images/mockup_icon_bin_recycle_blue.png';
  static const String iconBinRecycleGreen =
      'assets/images/mockup_icon_bin_recycle_green.png';
  static const String iconBinPaper = 'assets/images/mockup_icon_bin_paper.png';
  static const String iconBinHazard =
      'assets/images/mockup_icon_bin_hazard.png';
  static const String iconCoin = 'assets/images/mockup_icon_coin.png';
  static const String iconGem = 'assets/images/mockup_icon_gem.png';
  static const String iconHeart = 'assets/images/mockup_icon_heart.png';
  static const String trashGlassBottle = 'assets/images/trash_glass_bottle.png';
  static const String trashPlasticBottleBlue =
      'assets/images/trash_plastic_bottle_blue.png';
  static const String trashRedSodaCan = 'assets/images/trash_red_soda_can.png';
  static const String trashCrushedCan = 'assets/images/trash_crushed_can.png';
  static const String trashCardboardBox =
      'assets/images/trash_cardboard_box.png';
  static const String trashNewspaperStack =
      'assets/images/trash_newspaper_stack.png';
  static const String trashBananaPeel = 'assets/images/trash_banana_peel.png';
  static const String trashRedCup = 'assets/images/trash_red_cup.png';
  static const String trashRustyFoodCan =
      'assets/images/trash_rusty_food_can.png';
  static const String trashYellowBottle =
      'assets/images/trash_yellow_bottle.png';
  static const String trashToxicBarrel = 'assets/images/trash_toxic_barrel.png';
  static const String trashCrumpledPaper =
      'assets/images/trash_crumpled_paper.png';
  static const String binSpriteOrganic = 'assets/images/bin_sprite_organic.png';
  static const String binSpriteRecycle = 'assets/images/bin_sprite_recycle.png';
  static const String binSpritePaper = 'assets/images/bin_sprite_paper.png';
  static const String binSpriteHazard = 'assets/images/bin_sprite_hazard.png';
  static const String sideIconDaily = 'assets/images/side_icon_daily.png';
  static const String sideIconMissions = 'assets/images/side_icon_missions.png';
  static const String sideIconLeaderboard =
      'assets/images/side_icon_leaderboard.png';
  static const String sideIconSettings = 'assets/images/side_icon_settings.png';
  static const String skinClassic = 'assets/images/tornado_skin_classic.png';
  static const String skinOcean = 'assets/images/tornado_skin_ocean.png';
  static const String skinFire = 'assets/images/tornado_skin_fire.png';
  static const String skinRobot = 'assets/images/tornado_skin_robot.png';
  static const String skinGalaxy = 'assets/images/tornado_skin_galaxy.png';
  static const String skinToxic = 'assets/images/tornado_skin_toxic.png';
  static const String musicMenu = 'audio/music_menu_loop.wav';
  static const String musicGame = 'audio/music_game_loop.wav';
  static const String musicArcadeMenu = 'audio/music_arcade_menu_loop.wav';
  static const String musicArcadeGame = 'audio/music_arcade_game_loop.wav';
  static const String musicChillMenu = 'audio/music_chill_menu_loop.wav';
  static const String musicChillGame = 'audio/music_chill_game_loop.wav';
  static const String sfxTap = 'audio/sfx_tap.wav';
  static const String sfxToggle = 'audio/sfx_toggle.wav';
  static const String sfxStart = 'audio/sfx_start.wav';
  static const String sfxSort = 'audio/sfx_sort.wav';
  static const String sfxCombo = 'audio/sfx_combo.wav';
  static const String sfxMiss = 'audio/sfx_miss.wav';
  static const String sfxBarrel = 'audio/sfx_barrel.wav';
  static const String sfxComplete = 'audio/sfx_complete.wav';
}

void main() {
  final String? shot = Uri.base.queryParameters['shot'];
  runApp(
    TrashTornadoApp(
      initialView: _viewFromShot(shot),
      screenshotMode: shot != null,
    ),
  );
}

GameView _viewFromShot(String? shot) {
  return switch (shot) {
    'game' || 'gameplay' => GameView.game,
    'map' || 'world-map' => GameView.map,
    'skins' => GameView.skins,
    'complete' || 'level-complete' => GameView.complete,
    'shop' => GameView.shop,
    'upgrades' => GameView.upgrades,
    'rewards' => GameView.rewards,
    'settings' => GameView.settings,
    _ => GameView.menu,
  };
}

class TrashTornadoApp extends StatelessWidget {
  const TrashTornadoApp({
    this.initialView = GameView.menu,
    this.screenshotMode = false,
    super.key,
  });

  final GameView initialView;
  final bool screenshotMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trash Tornado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff24c45a),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      builder: (BuildContext context, Widget? child) =>
          ArcadeViewport(child: child ?? const SizedBox.shrink()),
      home: ForcedUpdateGate(
        enabled: kReleaseMode && !screenshotMode,
        child: GameShell(
          initialView: initialView,
          screenshotMode: screenshotMode,
        ),
      ),
    );
  }
}

class ForcedUpdateGate extends StatefulWidget {
  const ForcedUpdateGate({
    required this.child,
    required this.enabled,
    super.key,
  });

  final Widget child;
  final bool enabled;

  @override
  State<ForcedUpdateGate> createState() => _ForcedUpdateGateState();
}

class _ForcedUpdateGateState extends State<ForcedUpdateGate>
    with WidgetsBindingObserver {
  bool _checking = true;
  bool _blocked = false;
  bool _updateFlowActive = false;
  String _message = 'Checking for the latest version...';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_enforceLatestVersion());
  }

  @override
  void didUpdateWidget(ForcedUpdateGate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled && widget.enabled) {
      unawaited(_enforceLatestVersion());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _blocked) {
      unawaited(_enforceLatestVersion());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _enforceLatestVersion() async {
    if (_updateFlowActive) {
      return;
    }
    if (!widget.enabled ||
        kIsWeb ||
        defaultTargetPlatform != TargetPlatform.android) {
      if (mounted) {
        setState(() {
          _checking = false;
          _blocked = false;
        });
      }
      return;
    }

    setState(() {
      _checking = true;
      _message = 'Checking for the latest version...';
    });

    bool foundRequiredUpdate = false;
    try {
      final AppUpdateInfo info = await InAppUpdate.checkForUpdate();
      final bool updateAvailable =
          info.updateAvailability == UpdateAvailability.updateAvailable ||
          info.updateAvailability ==
              UpdateAvailability.developerTriggeredUpdateInProgress;

      if (!updateAvailable) {
        if (mounted) {
          setState(() {
            _checking = false;
            _blocked = false;
          });
        }
        return;
      }
      foundRequiredUpdate = true;

      if (!info.immediateUpdateAllowed &&
          info.updateAvailability !=
              UpdateAvailability.developerTriggeredUpdateInProgress) {
        _blockForUpdate(
          'Update required. Open Google Play, install the latest Trash Tornado, then return here.',
        );
        return;
      }

      _updateFlowActive = true;
      final AppUpdateResult result = await InAppUpdate.performImmediateUpdate();
      _updateFlowActive = false;
      if (!mounted) {
        return;
      }
      if (result == AppUpdateResult.success) {
        setState(() {
          _checking = false;
          _blocked = false;
        });
      } else {
        _blockForUpdate(
          'Update required. Please complete the Google Play update to keep playing.',
        );
      }
    } on PlatformException {
      _updateFlowActive = false;
      if (mounted) {
        if (foundRequiredUpdate) {
          _blockForUpdate(
            'Update required. Please update Trash Tornado from Google Play to keep playing.',
          );
        } else {
          setState(() {
            _checking = false;
            _blocked = false;
          });
        }
      }
    }
  }

  void _blockForUpdate(String message) {
    if (!mounted) {
      return;
    }
    setState(() {
      _checking = false;
      _blocked = true;
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checking || _blocked) {
      return UpdateRequiredScreen(
        checking: _checking,
        message: _message,
        onRetry: _enforceLatestVersion,
      );
    }
    return widget.child;
  }
}

class UpdateRequiredScreen extends StatelessWidget {
  const UpdateRequiredScreen({
    required this.checking,
    required this.message,
    required this.onRetry,
    super.key,
  });

  final bool checking;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff0b4fa2),
              Color(0xff062f60),
              Color(0xff071423),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              width: 320,
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff0d3760), Color(0xff041321)],
                ),
                border: Border.all(color: const Color(0xff78c7ff), width: 1.4),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 18,
                    offset: Offset(0, 9),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    checking
                        ? Icons.system_update_alt_rounded
                        : Icons.lock_clock_rounded,
                    color: const Color(0xffbaff3d),
                    size: 54,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    checking ? 'Checking Update' : 'Update Required',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (checking)
                    const CircularProgressIndicator(color: Color(0xffbaff3d))
                  else
                    ArcadeButton(
                      label: 'Update Now',
                      icon: Icons.system_update_rounded,
                      compact: true,
                      color: const Color(0xff62c90c),
                      onPressed: onRetry,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArcadeViewport extends StatelessWidget {
  const ArcadeViewport({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final view = View.of(context);
        final double viewWidth =
            view.physicalSize.width / view.devicePixelRatio;
        final double viewHeight =
            view.physicalSize.height / view.devicePixelRatio;
        final double availableWidth = math.min(constraints.maxWidth, viewWidth);
        final double availableHeight = math.min(
          constraints.maxHeight,
          viewHeight,
        );
        final bool phoneWidth = availableWidth <= 520;
        final double maxPanelWidth = phoneWidth
            ? availableWidth
            : math.min(390, availableHeight * 0.58);

        if (phoneWidth) {
          return ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: availableWidth,
                height: availableHeight,
                child: child,
              ),
            ),
          );
        }

        return ColoredBox(
          color: Colors.black,
          child: Center(
            child: Container(
              width: maxPanelWidth,
              height: availableHeight,
              decoration: BoxDecoration(
                color: const Color(0xff061423),
                border: Border.all(color: const Color(0xff1d3e65), width: 2),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: child,
            ),
          ),
        );
      },
    );
  }
}

enum GameView {
  menu,
  game,
  complete,
  map,
  shop,
  upgrades,
  rewards,
  skins,
  settings,
  modes,
  tutorial,
}

enum WasteType { plastic, metal, paper, glass, food, toxic }

enum BinType { organic, recycle, paper, hazard }

enum DropKind { waste, ecoBlast }

extension WasteInfo on WasteType {
  String get label {
    switch (this) {
      case WasteType.plastic:
        return 'Plastic';
      case WasteType.metal:
        return 'Metal';
      case WasteType.paper:
        return 'Paper';
      case WasteType.glass:
        return 'Glass';
      case WasteType.food:
        return 'Food';
      case WasteType.toxic:
        return 'Toxic';
    }
  }

  BinType get bin {
    switch (this) {
      case WasteType.plastic:
      case WasteType.metal:
      case WasteType.glass:
        return BinType.recycle;
      case WasteType.paper:
        return BinType.paper;
      case WasteType.food:
        return BinType.organic;
      case WasteType.toxic:
        return BinType.hazard;
    }
  }

  IconData get icon {
    switch (this) {
      case WasteType.plastic:
        return Icons.local_drink_rounded;
      case WasteType.metal:
        return Icons.soup_kitchen_rounded;
      case WasteType.paper:
        return Icons.description_rounded;
      case WasteType.glass:
        return Icons.wine_bar_rounded;
      case WasteType.food:
        return Icons.restaurant_rounded;
      case WasteType.toxic:
        return Icons.warning_amber_rounded;
    }
  }

  Color get color {
    switch (this) {
      case WasteType.plastic:
        return const Color(0xff1c8cff);
      case WasteType.metal:
        return const Color(0xff95a7b7);
      case WasteType.paper:
        return const Color(0xffe0b34f);
      case WasteType.glass:
        return const Color(0xff37d86e);
      case WasteType.food:
        return const Color(0xff8ee05f);
      case WasteType.toxic:
        return const Color(0xffff3b4f);
    }
  }
}

extension BinInfo on BinType {
  String get label {
    switch (this) {
      case BinType.organic:
        return 'Organic';
      case BinType.recycle:
        return 'Recycle';
      case BinType.paper:
        return 'Paper';
      case BinType.hazard:
        return 'Hazard';
    }
  }

  Color get color {
    switch (this) {
      case BinType.organic:
        return const Color(0xff45c94f);
      case BinType.recycle:
        return const Color(0xff1c8cff);
      case BinType.paper:
        return const Color(0xffe0b34f);
      case BinType.hazard:
        return const Color(0xffff3b4f);
    }
  }

  String get asset {
    switch (this) {
      case BinType.organic:
        return GameArt.binSpriteOrganic;
      case BinType.recycle:
        return GameArt.binSpriteRecycle;
      case BinType.paper:
        return GameArt.binSpritePaper;
      case BinType.hazard:
        return GameArt.binSpriteHazard;
    }
  }
}

class WasteItem {
  WasteItem({
    required this.id,
    required this.type,
    required this.asset,
    required this.position,
    required this.velocity,
    required this.size,
    required this.spin,
    this.kind = DropKind.waste,
  });

  final int id;
  final WasteType type;
  final String asset;
  final DropKind kind;
  Offset position;
  Offset velocity;
  double size;
  double spin;
  bool held = false;
  final List<Offset> trail = <Offset>[];
}

class SortBurst {
  SortBurst({
    required this.position,
    required this.label,
    required this.color,
    this.age = 0,
  });

  Offset position;
  String label;
  Color color;
  double age;
}

class TornadoSkin {
  const TornadoSkin({
    required this.name,
    required this.tagline,
    required this.colors,
    required this.asset,
    required this.price,
    required this.icon,
  });

  final String name;
  final String tagline;
  final List<Color> colors;
  final String asset;
  final int price;
  final IconData icon;
}

class CityMap {
  const CityMap({
    required this.name,
    required this.caption,
    required this.unlockScore,
    required this.colors,
    required this.icon,
  });

  final String name;
  final String caption;
  final int unlockScore;
  final List<Color> colors;
  final IconData icon;
}

class GameModeOption {
  const GameModeOption({
    required this.name,
    required this.caption,
    required this.icon,
    required this.seconds,
    required this.rewardBoost,
  });

  final String name;
  final String caption;
  final IconData icon;
  final int seconds;
  final double rewardBoost;
}

class MusicTrackOption {
  const MusicTrackOption({
    required this.name,
    required this.caption,
    required this.menuAsset,
    required this.gameAsset,
    required this.icon,
    required this.color,
  });

  final String name;
  final String caption;
  final String menuAsset;
  final String gameAsset;
  final IconData icon;
  final Color color;
}

class UpgradeSpec {
  const UpgradeSpec({
    required this.key,
    required this.name,
    required this.icon,
    required this.baseCost,
    required this.color,
  });

  final String key;
  final String name;
  final IconData icon;
  final int baseCost;
  final Color color;
}

const List<TornadoSkin> _skins = <TornadoSkin>[
  TornadoSkin(
    name: 'Classic',
    tagline: 'Balanced cleanup power',
    colors: <Color>[Color(0xff2bd95c), Color(0xff0d7c38), Color(0xffb8ff2f)],
    asset: GameArt.skinClassic,
    price: 0,
    icon: Icons.recycling_rounded,
  ),
  TornadoSkin(
    name: 'Ocean',
    tagline: 'Cool beach sweep speed',
    colors: <Color>[Color(0xff40d5ff), Color(0xff0767bd), Color(0xffb9f3ff)],
    asset: GameArt.skinOcean,
    price: 500,
    icon: Icons.water_drop_rounded,
  ),
  TornadoSkin(
    name: 'Fire',
    tagline: 'Hot combo starter',
    colors: <Color>[Color(0xffffa62d), Color(0xffe24412), Color(0xffffe45f)],
    asset: GameArt.skinFire,
    price: 500,
    icon: Icons.local_fire_department_rounded,
  ),
  TornadoSkin(
    name: 'Robot',
    tagline: 'Magnetic sorting focus',
    colors: <Color>[Color(0xffd7e3f1), Color(0xff5d7088), Color(0xff38ffe5)],
    asset: GameArt.skinRobot,
    price: 700,
    icon: Icons.smart_toy_rounded,
  ),
  TornadoSkin(
    name: 'Galaxy',
    tagline: 'Cosmic score trails',
    colors: <Color>[Color(0xffbb67ff), Color(0xff3f168f), Color(0xff19ffe8)],
    asset: GameArt.skinGalaxy,
    price: 700,
    icon: Icons.auto_awesome_rounded,
  ),
  TornadoSkin(
    name: 'Toxic',
    tagline: 'Hazard-proof attitude',
    colors: <Color>[Color(0xffb9ff00), Color(0xff151f16), Color(0xff00ff9d)],
    asset: GameArt.skinToxic,
    price: 700,
    icon: Icons.science_rounded,
  ),
];

const List<MusicTrackOption> _musicTracks = <MusicTrackOption>[
  MusicTrackOption(
    name: 'Ocean Breeze',
    caption: 'Soft watery cleanup groove',
    menuAsset: GameArt.musicMenu,
    gameAsset: GameArt.musicGame,
    icon: Icons.water_drop_rounded,
    color: Color(0xff36d6ff),
  ),
  MusicTrackOption(
    name: 'Arcade Rush',
    caption: 'Fast bright recycling energy',
    menuAsset: GameArt.musicArcadeMenu,
    gameAsset: GameArt.musicArcadeGame,
    icon: Icons.bolt_rounded,
    color: Color(0xffffd83f),
  ),
  MusicTrackOption(
    name: 'Chill Cleanup',
    caption: 'Mellow city sweep beat',
    menuAsset: GameArt.musicChillMenu,
    gameAsset: GameArt.musicChillGame,
    icon: Icons.nightlight_round,
    color: Color(0xffb56dff),
  ),
];

const List<CityMap> _maps = <CityMap>[
  CityMap(
    name: 'Green Park',
    caption: 'Clean trails and picnic lawns',
    unlockScore: 0,
    colors: <Color>[Color(0xff67ce55), Color(0xff17653f), Color(0xff61d6ff)],
    icon: Icons.park_rounded,
  ),
  CityMap(
    name: 'Beach Cleanup',
    caption: 'Sweep sand, surf, and boardwalks',
    unlockScore: 2200,
    colors: <Color>[Color(0xffffca66), Color(0xff139fc4), Color(0xffe8f8ff)],
    icon: Icons.beach_access_rounded,
  ),
  CityMap(
    name: 'City Street',
    caption: 'Rescue blocks from litter storms',
    unlockScore: 5200,
    colors: <Color>[Color(0xff4b8bd6), Color(0xff253859), Color(0xffffd75d)],
    icon: Icons.location_city_rounded,
  ),
  CityMap(
    name: 'Industrial Area',
    caption: 'Keep barrels out of the stream',
    unlockScore: 9400,
    colors: <Color>[Color(0xffff9944), Color(0xff473829), Color(0xff86e35b)],
    icon: Icons.factory_rounded,
  ),
  CityMap(
    name: 'Ocean Depths',
    caption: 'Pull plastic from deep blue lanes',
    unlockScore: 14500,
    colors: <Color>[Color(0xff22c3ff), Color(0xff053870), Color(0xff9cf7ff)],
    icon: Icons.waves_rounded,
  ),
];

const List<GameModeOption> _modes = <GameModeOption>[
  GameModeOption(
    name: 'Classic Mode',
    caption: 'Complete levels and clean the city',
    icon: Icons.recycling_rounded,
    seconds: 45,
    rewardBoost: 1,
  ),
  GameModeOption(
    name: 'Time Attack',
    caption: 'Clean as much as you can',
    icon: Icons.timer_rounded,
    seconds: 30,
    rewardBoost: 1.25,
  ),
  GameModeOption(
    name: 'Endless Mode',
    caption: 'How long can you survive?',
    icon: Icons.all_inclusive_rounded,
    seconds: 60,
    rewardBoost: 1.4,
  ),
  GameModeOption(
    name: 'Challenge Mode',
    caption: 'Unique challenges every day',
    icon: Icons.emoji_events_rounded,
    seconds: 40,
    rewardBoost: 1.6,
  ),
];

const List<UpgradeSpec> _upgrades = <UpgradeSpec>[
  UpgradeSpec(
    key: 'power',
    name: 'Tornado Power',
    icon: Icons.cyclone_rounded,
    baseCost: 1200,
    color: Color(0xff2ad45e),
  ),
  UpgradeSpec(
    key: 'speed',
    name: 'Tornado Speed',
    icon: Icons.speed_rounded,
    baseCost: 900,
    color: Color(0xff30d3ff),
  ),
  UpgradeSpec(
    key: 'capacity',
    name: 'Capacity',
    icon: Icons.delete_rounded,
    baseCost: 700,
    color: Color(0xfff5c34f),
  ),
  UpgradeSpec(
    key: 'time',
    name: 'Starting Time',
    icon: Icons.more_time_rounded,
    baseCost: 900,
    color: Color(0xff82e35f),
  ),
  UpgradeSpec(
    key: 'offline',
    name: 'Offline Earnings',
    icon: Icons.paid_rounded,
    baseCost: 500,
    color: Color(0xffffb12f),
  ),
];

class GameShell extends StatefulWidget {
  const GameShell({
    this.initialView = GameView.menu,
    this.screenshotMode = false,
    super.key,
  });

  final GameView initialView;
  final bool screenshotMode;

  @override
  State<GameShell> createState() => _GameShellState();
}

class _GameShellState extends State<GameShell>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final math.Random _random = math.Random();
  final List<WasteItem> _items = <WasteItem>[];
  final List<SortBurst> _bursts = <SortBurst>[];
  final Set<int> _unlockedSkins = <int>{0};
  final Set<int> _unlockedMaps = <int>{0};
  final Map<String, int> _upgradeLevels = <String, int>{
    'power': 5,
    'speed': 4,
    'capacity': 3,
    'time': 4,
    'offline': 2,
  };
  final Set<int> _claimedRewardDays = <int>{1, 2, 3};
  final Map<String, int> _inventory = <String, int>{
    'Boost': 1,
    'Magnet': 1,
    'Freeze': 0,
    'Energy': 2,
    'Eco Blast': 1,
  };

  Timer? _timer;
  late final AnimationController _ambientController;
  late final AnimationController _celebrationController;
  late final AudioPlayer _musicPlayer;
  late final AudioPlayer _sfxPlayer;
  late final AudioPlayer _uiPlayer;
  DateTime? _lastTick;
  String? _activeMusicAsset;
  GameView _view = GameView.menu;
  WasteItem? _tutorialItem;
  Size _tutorialSize = Size.zero;
  double _tutorialDockInset = 0;
  BinType? _tutorialHoverBin;
  BinType? _tutorialSuccessBin;
  double _tutorialSuccessPulse = 0;
  int _tutorialStep = 0;
  bool _tutorialSeen = false;
  Size _playSize = Size.zero;
  double _playDockInset = 0;
  int _nextItemId = 1;
  int _selectedSkin = 0;
  int _selectedMap = 0;
  int _selectedMode = 0;
  int _selectedMusicTrack = 0;
  int _shopTab = 0;
  int _score = 0;
  int _bestScore = 0;
  int _lastCoinsEarned = 0;
  int _lastGemsEarned = 0;
  int _lastEnergyEarned = 0;
  int _lastEarnedStars = 0;
  bool _lastNewRecord = false;
  int _combo = 0;
  int _hearts = 5;
  int _coins = 8450;
  int _gems = 320;
  int _energy = 5;
  int _level = 12;
  int _xp = 1250;
  double _timeLeft = 45;
  double _spawnIn = 0;
  double _powerUpDropIn = 4.5;
  double _successPulse = 0;
  BinType? _hoverBin;
  BinType? _successBin;
  bool _paused = false;
  bool _music = true;
  bool _sfx = true;
  bool _vibration = true;
  bool _powerSaver = false;
  bool _appInForeground = true;
  bool _quitDialogOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.screenshotMode) {
      _applyScreenshotSeed();
    }
    _musicPlayer = AudioPlayer(playerId: 'trash_tornado_music');
    _sfxPlayer = AudioPlayer(playerId: 'trash_tornado_sfx');
    _uiPlayer = AudioPlayer(playerId: 'trash_tornado_ui');
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat();
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1750),
    );
    if (widget.screenshotMode && _view == GameView.complete) {
      _celebrationController.value = 1;
    }
    unawaited(_configureAudio());
    _timer = Timer.periodic(const Duration(milliseconds: 33), _tick);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    unawaited(_musicPlayer.stop());
    unawaited(_sfxPlayer.stop());
    unawaited(_uiPlayer.stop());
    unawaited(_musicPlayer.dispose());
    unawaited(_sfxPlayer.dispose());
    unawaited(_uiPlayer.dispose());
    _ambientController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _appInForeground = true;
        _syncMusic();
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _appInForeground = false;
        unawaited(_stopAllAudio());
    }
  }

  Future<void> _configureAudio() async {
    try {
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.setVolume(0.24);
      await _sfxPlayer.setReleaseMode(ReleaseMode.stop);
      await _uiPlayer.setReleaseMode(ReleaseMode.stop);
      _syncMusic();
    } catch (_) {
      _activeMusicAsset = null;
    }
  }

  void _syncMusic() {
    unawaited(_syncMusicNow());
  }

  Future<void> _syncMusicNow() async {
    try {
      if (!_music || !_appInForeground) {
        _activeMusicAsset = null;
        await _musicPlayer.stop();
        return;
      }

      final MusicTrackOption track = _musicTracks[_selectedMusicTrack];
      final String asset = _view == GameView.game
          ? track.gameAsset
          : track.menuAsset;
      if (_activeMusicAsset == asset) {
        await _musicPlayer.resume();
        return;
      }

      await _musicPlayer.stop();
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.play(
        AssetSource(asset),
        volume: _view == GameView.game ? 0.24 : 0.2,
      );
      _activeMusicAsset = asset;
    } catch (_) {
      _activeMusicAsset = null;
    }
  }

  Future<void> _stopAllAudio() async {
    try {
      _activeMusicAsset = null;
      await _musicPlayer.stop();
      await _sfxPlayer.stop();
      await _uiPlayer.stop();
    } catch (_) {}
  }

  void _playSfx(String asset, {double volume = 0.72}) {
    if (!_sfx) {
      return;
    }
    unawaited(_playOneShot(_sfxPlayer, asset, volume));
  }

  void _playUiSfx(String asset, {double volume = 0.48}) {
    if (!_sfx) {
      return;
    }
    unawaited(_playOneShot(_uiPlayer, asset, volume));
  }

  Future<void> _playOneShot(
    AudioPlayer player,
    String asset,
    double volume,
  ) async {
    try {
      await player.stop();
      await player.setReleaseMode(ReleaseMode.stop);
      await player.play(AssetSource(asset), volume: volume);
    } catch (_) {}
  }

  void _hapticLight() {
    if (_vibration) {
      unawaited(HapticFeedback.lightImpact().catchError((_) {}));
    }
  }

  void _hapticMedium() {
    if (_vibration) {
      unawaited(HapticFeedback.mediumImpact().catchError((_) {}));
    }
  }

  void _hapticHeavy() {
    if (_vibration) {
      unawaited(HapticFeedback.heavyImpact().catchError((_) {}));
    }
  }

  void _hapticSelection() {
    if (_vibration) {
      unawaited(HapticFeedback.selectionClick().catchError((_) {}));
    }
  }

  void _tick(Timer timer) {
    final DateTime now = DateTime.now();
    if (widget.screenshotMode) {
      _lastTick = now;
      return;
    }
    final double dt = _lastTick == null
        ? 0.033
        : math.min(now.difference(_lastTick!).inMilliseconds / 1000, 0.06);
    _lastTick = now;

    if (_view != GameView.game || _paused || _playSize == Size.zero) {
      return;
    }

    setState(() {
      _timeLeft = math.max(0, _timeLeft - dt);
      _spawnIn -= dt;
      if (_spawnIn <= 0) {
        _spawnItem();
        final int speedLevel = _upgradeLevels['speed'] ?? 1;
        _spawnIn = math.max(0.34, 0.9 - speedLevel * 0.04 - _score / 50000);
      }
      _powerUpDropIn -= dt;
      if (_powerUpDropIn <= 0 &&
          !_items.any((WasteItem item) => item.kind == DropKind.ecoBlast)) {
        _spawnEcoBlastDrop();
        _powerUpDropIn = 8 + _random.nextDouble() * 6;
      }

      final List<WasteItem> removed = <WasteItem>[];
      final Offset tornadoCenter = Offset(
        _playSize.width / 2,
        _playSize.height * 0.55,
      );
      for (final WasteItem item in _items) {
        if (!item.held) {
          _rememberTrailPoint(item);
          item.position += item.velocity * dt;
          item.spin += dt * (item.type == WasteType.toxic ? 5 : 3);
        }

        if (item.kind == DropKind.waste &&
            item.type == WasteType.toxic &&
            (item.position - tornadoCenter).distance < item.size * 0.85) {
          removed.add(item);
          _damagePlayer(position: item.position, toxic: true);
        } else if (item.position.dy > _playSize.height + 70) {
          removed.add(item);
          if (item.kind == DropKind.waste && item.type != WasteType.toxic) {
            _damagePlayer(position: item.position);
          }
        }
      }
      _items.removeWhere(removed.contains);
      for (final SortBurst burst in _bursts) {
        burst.age += dt;
        burst.position += Offset(0, -34 * dt);
      }
      _bursts.removeWhere((SortBurst burst) => burst.age > 0.95);
      if (_successPulse > 0) {
        _successPulse = math.max(0, _successPulse - dt * 1.5);
        if (_successPulse == 0) {
          _successBin = null;
        }
      }

      if (_timeLeft <= 0 || _hearts <= 0) {
        _finishRun();
      }
    });
  }

  void _spawnItem() {
    if (_playSize.width < 120 || _playSize.height < 240) {
      return;
    }
    final double hazardChance = math.max(
      0.12,
      0.2 - (_upgradeLevels['capacity'] ?? 1) * 0.008,
    );
    final bool toxic = _random.nextDouble() < hazardChance;
    final List<WasteType> cleanTypes = _cleanWasteTypes;
    final WasteType type = toxic
        ? WasteType.toxic
        : cleanTypes[_random.nextInt(cleanTypes.length)];
    final List<String> sprites = _spriteOptions(type);
    final double x = 36 + _random.nextDouble() * (_playSize.width - 72);
    final double wind = (_random.nextDouble() - 0.5) * 46;
    final double fallSpeed = 72 + _random.nextDouble() * 56 + _score / 800;
    _items.add(
      WasteItem(
        id: _nextItemId++,
        type: type,
        asset: sprites[_random.nextInt(sprites.length)],
        position: Offset(x, -44),
        velocity: Offset(wind, fallSpeed),
        size: (type == WasteType.toxic ? 72 : 58) + _random.nextDouble() * 18,
        spin: _random.nextDouble() * math.pi,
      ),
    );
  }

  void _spawnEcoBlastDrop() {
    if (_playSize.width < 120 || _playSize.height < 240) {
      return;
    }
    final double x = 48 + _random.nextDouble() * (_playSize.width - 96);
    _items.add(
      WasteItem(
        id: _nextItemId++,
        type: WasteType.food,
        kind: DropKind.ecoBlast,
        asset: GameArt.iconEnergy,
        position: Offset(x, -42),
        velocity: Offset((_random.nextDouble() - 0.5) * 22, 78),
        size: 70,
        spin: _random.nextDouble() * math.pi,
      ),
    );
  }

  void _applyScreenshotSeed() {
    _view = widget.initialView;
    _tutorialSeen = true;
    _music = false;
    _sfx = false;
    _vibration = false;
    _selectedSkin = switch (widget.initialView) {
      GameView.game => 1,
      GameView.complete => 4,
      _ => 0,
    };
    _selectedMap = widget.initialView == GameView.map ? 1 : 0;
    _coins = 6550;
    _gems = 322;
    _energy = 5;
    _score = widget.initialView == GameView.complete ? 18950 : 12750;
    _bestScore = 18950;
    _lastCoinsEarned = 950;
    _lastGemsEarned = 25;
    _lastEnergyEarned = 5;
    _lastEarnedStars = widget.initialView == GameView.complete ? 3 : 0;
    _lastNewRecord = true;
    _combo = 28;
    _hearts = 5;
    _timeLeft = 45;
    _spawnIn = 99;
    _unlockedSkins
      ..clear()
      ..addAll(List<int>.generate(_skins.length, (int index) => index));
    _unlockedMaps
      ..clear()
      ..addAll(<int>{0, 1, 2});
    _claimedRewardDays
      ..clear()
      ..addAll(<int>{1, 2, 3});
  }

  void _ensureScreenshotGameplayItems(Size size) {
    if (!widget.screenshotMode || _view != GameView.game || size == Size.zero) {
      return;
    }
    if (_items.isNotEmpty && _playSize == size) {
      return;
    }

    _items
      ..clear()
      ..addAll(<WasteItem>[
        WasteItem(
          id: 9001,
          type: WasteType.glass,
          asset: GameArt.trashGlassBottle,
          position: Offset(size.width * 0.22, size.height * 0.18),
          velocity: Offset.zero,
          size: 76,
          spin: -0.26,
        ),
        WasteItem(
          id: 9002,
          type: WasteType.paper,
          asset: GameArt.trashCardboardBox,
          position: Offset(size.width * 0.62, size.height * 0.21),
          velocity: Offset.zero,
          size: 88,
          spin: 0.2,
        ),
        WasteItem(
          id: 9003,
          type: WasteType.food,
          asset: GameArt.trashBananaPeel,
          position: Offset(size.width * 0.54, size.height * 0.36),
          velocity: Offset.zero,
          size: 72,
          spin: -0.4,
        ),
        WasteItem(
          id: 9004,
          type: WasteType.metal,
          asset: GameArt.trashCrushedCan,
          position: Offset(size.width * 0.79, size.height * 0.32),
          velocity: Offset.zero,
          size: 76,
          spin: 0.5,
        ),
        WasteItem(
          id: 9005,
          type: WasteType.toxic,
          asset: GameArt.trashToxicBarrel,
          position: Offset(size.width * 0.28, size.height * 0.53),
          velocity: Offset.zero,
          size: 82,
          spin: -0.15,
        ),
        WasteItem(
          id: 9006,
          type: WasteType.plastic,
          asset: GameArt.trashPlasticBottleBlue,
          position: Offset(size.width * 0.72, size.height * 0.63),
          velocity: Offset.zero,
          size: 72,
          spin: 0.35,
        ),
        WasteItem(
          id: 9007,
          type: WasteType.food,
          kind: DropKind.ecoBlast,
          asset: GameArt.iconEnergy,
          position: Offset(size.width * 0.44, size.height * 0.27),
          velocity: Offset.zero,
          size: 70,
          spin: 0.9,
        ),
      ]);

    _items[2].trail.addAll(<Offset>[
      Offset(size.width * 0.47, size.height * 0.44),
      Offset(size.width * 0.51, size.height * 0.40),
      _items[2].position,
    ]);
    _bursts
      ..clear()
      ..add(
        SortBurst(
          position: Offset(size.width * 0.23, size.height * 0.36),
          label: 'COMBO 28',
          color: const Color(0xffffd642),
        ),
      )
      ..add(
        SortBurst(
          position: Offset(size.width * 0.78, size.height * 0.48),
          label: '+320',
          color: const Color(0xffbaff3d),
        ),
      );
    _hoverBin = BinType.recycle;
    _successBin = BinType.paper;
    _successPulse = 0.75;
  }

  void _rememberTrailPoint(WasteItem item) {
    if (item.trail.isEmpty || (item.trail.last - item.position).distance > 10) {
      item.trail.add(item.position);
      if (item.trail.length > 9) {
        item.trail.removeAt(0);
      }
    }
  }

  List<String> _spriteOptions(WasteType type) {
    return switch (type) {
      WasteType.plastic => const <String>[
        GameArt.trashPlasticBottleBlue,
        GameArt.trashYellowBottle,
        GameArt.trashRedCup,
      ],
      WasteType.metal => const <String>[
        GameArt.trashRedSodaCan,
        GameArt.trashCrushedCan,
        GameArt.trashRustyFoodCan,
      ],
      WasteType.paper => const <String>[
        GameArt.trashCardboardBox,
        GameArt.trashNewspaperStack,
        GameArt.trashCrumpledPaper,
      ],
      WasteType.glass => const <String>[GameArt.trashGlassBottle],
      WasteType.food => const <String>[GameArt.trashBananaPeel],
      WasteType.toxic => const <String>[GameArt.trashToxicBarrel],
    };
  }

  void _startRun({int? mode, int? map}) {
    final int chosenMode = mode ?? _selectedMode;
    final int chosenMap = map ?? _selectedMap;
    final int timeLevel = _upgradeLevels['time'] ?? 1;
    _playSfx(GameArt.sfxStart, volume: 0.72);
    _hapticMedium();
    setState(() {
      _selectedMode = chosenMode;
      _selectedMap = chosenMap;
      _view = GameView.game;
      _items.clear();
      _bursts.clear();
      _hoverBin = null;
      _successBin = null;
      _successPulse = 0;
      _celebrationController.reset();
      _score = 0;
      _combo = 0;
      _hearts = 5;
      _timeLeft = _modes[chosenMode].seconds + timeLevel * 2;
      _spawnIn = 0.08;
      _powerUpDropIn = 4.5;
      _lastEarnedStars = 0;
      _paused = false;
      _lastTick = DateTime.now();
    });
    _syncMusic();
  }

  void _finishRun() {
    final int earnedStars = _calculateEarnedStars(_score, _hearts);
    final double boost = _modes[_selectedMode].rewardBoost;
    final int coinsEarned = math.max(90, (_score / 18 * boost).round());
    final int gemsEarned = _score >= 15000 ? 8 : (_score >= 7000 ? 4 : 2);
    final int energyEarned = _score >= 5000 ? 1 : 0;
    _lastNewRecord = _score > _bestScore;
    _lastCoinsEarned = coinsEarned;
    _lastGemsEarned = gemsEarned;
    _lastEnergyEarned = energyEarned;
    _lastEarnedStars = earnedStars;
    _coins += coinsEarned;
    _gems += gemsEarned;
    _energy = math.min(10, _energy - 1 + energyEarned);
    _bestScore = math.max(_bestScore, _score);
    _xp = (_xp + (_score / 7).round()) % 2500;
    if (_xp > 2100) {
      _level += 1;
    }
    for (int i = 0; i < _maps.length; i++) {
      if (_bestScore >= _maps[i].unlockScore) {
        _unlockedMaps.add(i);
      }
    }
    _view = GameView.complete;
    _celebrationController.forward(from: 0);
    if (earnedStars > 0) {
      _playSfx(GameArt.sfxComplete, volume: 0.76);
      _hapticMedium();
    } else {
      _playSfx(GameArt.sfxMiss, volume: 0.62);
      _hapticHeavy();
    }
    _syncMusic();
  }

  int get _earnedStars {
    if (_view == GameView.complete) {
      return _lastEarnedStars;
    }
    return _calculateEarnedStars(_score, _hearts);
  }

  int _calculateEarnedStars(int score, int hearts) {
    if (score <= 0) {
      return 0;
    }
    final int scoreStars;
    if (score >= 12000) {
      scoreStars = 3;
    } else if (score >= 6000) {
      scoreStars = 2;
    } else {
      scoreStars = 1;
    }
    if (hearts <= 0) {
      return math.max(1, scoreStars - 1);
    }
    return scoreStars;
  }

  String get _resultCaption {
    return switch (_earnedStars) {
      3 => 'Perfect cleanup!',
      2 => 'City almost spotless!',
      1 => 'Cleanup started!',
      _ => 'Avoid barrels and sort fast!',
    };
  }

  String _formatNumber(int value) {
    final String raw = value.toString();
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < raw.length; i++) {
      final int remaining = raw.length - i;
      buffer.write(raw[i]);
      if (remaining > 1 && remaining % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
  }

  void _damagePlayer({Offset? position, bool toxic = false}) {
    _hearts = math.max(0, _hearts - 1);
    _combo = 0;
    _score = math.max(0, _score - 75);
    _playSfx(toxic ? GameArt.sfxBarrel : GameArt.sfxMiss, volume: 0.68);
    _hapticHeavy();
    if (position != null) {
      _bursts.add(
        SortBurst(
          position: position,
          label: '-75',
          color: const Color(0xffff3b4f),
        ),
      );
    }
  }

  void _startDrag(int id) {
    final int index = _items.indexWhere((WasteItem item) => item.id == id);
    if (index == -1) {
      return;
    }
    if (_items[index].kind == DropKind.ecoBlast) {
      setState(() => _collectEcoBlast(_items[index]));
      return;
    }
    if (_items[index].type == WasteType.toxic) {
      setState(() {
        final Offset hitPosition = _items[index].position;
        _bursts.add(
          SortBurst(
            position: hitPosition,
            label: 'AVOID',
            color: const Color(0xffff3b4f),
          ),
        );
        _items.removeAt(index);
        _damagePlayer(position: hitPosition, toxic: true);
      });
      return;
    }
    _playUiSfx(GameArt.sfxTap, volume: 0.34);
    _hapticSelection();
    setState(() {
      _items[index].held = true;
      _items[index].trail.clear();
      _items[index].trail.add(_items[index].position);
      _hoverBin = _binForPosition(_items[index].position);
    });
  }

  void _dragItem(int id, DragUpdateDetails details) {
    final int index = _items.indexWhere((WasteItem item) => item.id == id);
    if (index == -1 ||
        _items[index].kind != DropKind.waste ||
        _items[index].type == WasteType.toxic) {
      return;
    }
    setState(() {
      _rememberTrailPoint(_items[index]);
      _items[index].position += details.delta;
      _items[index].velocity = Offset.zero;
      _hoverBin = _binForPosition(_items[index].position);
    });
  }

  void _releaseItem(int id, DragEndDetails details) {
    final int index = _items.indexWhere((WasteItem item) => item.id == id);
    if (index == -1) {
      return;
    }
    final WasteItem item = _items[index];
    if (item.kind == DropKind.ecoBlast) {
      setState(() => _collectEcoBlast(item));
      return;
    }
    final BinType? bin = _binForPosition(item.position);
    final bool strongSwipe = details.velocity.pixelsPerSecond.distance > 520;
    final BinType? swipedBin = strongSwipe ? _binForSwipe(item.position) : null;
    final BinType? targetBin = bin ?? swipedBin;
    setState(() {
      item.held = false;
      if (targetBin == item.type.bin) {
        _collectItem(item, targetBin!);
      } else if (targetBin != null) {
        _bursts.add(
          SortBurst(
            position: item.position,
            label: 'MISS',
            color: const Color(0xffff3b4f),
          ),
        );
        _items.remove(item);
        _damagePlayer(position: item.position);
      } else {
        item.velocity = Offset(
          details.velocity.pixelsPerSecond.dx.clamp(-180, 180) / 6,
          105 + _random.nextDouble() * 40,
        );
      }
      _hoverBin = null;
    });
  }

  BinType? _binForPosition(Offset position) {
    final Map<BinType, Rect> rects = _binRects(
      _playSize,
      bottomInset: _playDockInset,
    );
    for (final MapEntry<BinType, Rect> entry in rects.entries) {
      if (entry.value.inflate(10).contains(position)) {
        return entry.key;
      }
    }
    return null;
  }

  BinType? _binForSwipe(Offset position) {
    if (_playSize.width <= 0) {
      return null;
    }
    final List<BinType> bins = _binTypes;
    final double slot = _playSize.width / bins.length;
    final int index = (position.dx / slot).floor().clamp(0, bins.length - 1);
    return bins[index];
  }

  void _collectItem(WasteItem item, BinType bin) {
    if (item.kind != DropKind.waste) {
      return;
    }
    _items.remove(item);
    _combo += 1;
    final int powerLevel = _upgradeLevels['power'] ?? 1;
    final int points = 120 + _combo * 18 + powerLevel * 8;
    _score += points;
    _coins += _combo % 5 == 0 ? 8 : 2;
    _successBin = bin;
    _successPulse = 1;
    _playSfx(_combo > 1 ? GameArt.sfxCombo : GameArt.sfxSort, volume: 0.72);
    _hapticLight();
    _bursts.add(
      SortBurst(
        position: item.position,
        label: '+$points',
        color: const Color(0xffffd33d),
      ),
    );
    if (_combo > 1) {
      _bursts.add(
        SortBurst(
          position: item.position + const Offset(0, -36),
          label: 'COMBO x$_combo',
          color: const Color(0xffbaff3d),
        ),
      );
    }
  }

  void _collectEcoBlast(WasteItem item) {
    final Offset origin = item.position;
    _items.remove(item);
    _activateEcoBlast(origin, freePickup: true);
  }

  void _useEcoBlastInventory() {
    if (_view != GameView.game || (_inventory['Eco Blast'] ?? 0) <= 0) {
      return;
    }
    setState(() {
      _inventory['Eco Blast'] = (_inventory['Eco Blast'] ?? 0) - 1;
      _activateEcoBlast(
        Offset(_playSize.width / 2, _playSize.height * 0.46),
        freePickup: false,
      );
    });
  }

  void _activateEcoBlast(Offset origin, {required bool freePickup}) {
    final List<WasteItem> cleared = _items
        .where((WasteItem item) => item.kind == DropKind.waste)
        .toList(growable: false);
    final int toxicCount = cleared
        .where((WasteItem item) => item.type == WasteType.toxic)
        .length;
    final int cleanCount = cleared.length - toxicCount;
    _items.removeWhere((WasteItem item) => cleared.contains(item));

    final int points = 220 + cleanCount * 115 + toxicCount * 45;
    _score += points;
    _coins += math.max(12, cleanCount * 5 + toxicCount * 2);
    _combo = math.max(_combo + math.max(1, cleanCount), 1);
    _successBin = BinType.recycle;
    _successPulse = 1;
    _playSfx(GameArt.sfxComplete, volume: freePickup ? 0.72 : 0.68);
    _hapticMedium();

    _bursts.add(
      SortBurst(
        position: origin,
        label: 'ECO BLAST',
        color: const Color(0xffbaff3d),
      ),
    );
    _bursts.add(
      SortBurst(
        position: origin + const Offset(0, -38),
        label: '+$points',
        color: const Color(0xffffe448),
      ),
    );
    for (final WasteItem item in cleared.take(9)) {
      _bursts.add(
        SortBurst(
          position: item.position,
          label: 'CLEAR',
          color: item.type == WasteType.toxic
              ? const Color(0xffff7483)
              : const Color(0xff7dffba),
        ),
      );
    }
  }

  double _bottomDockInset(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewPadding.bottom;
    return math.max(44, bottom).toDouble();
  }

  Map<BinType, Rect> _binRects(Size size, {double bottomInset = 0}) {
    if (size == Size.zero) {
      return const <BinType, Rect>{};
    }
    final List<BinType> bins = _binTypes;
    final double safeBottom = bottomInset.clamp(0, 96).toDouble();
    final double binTop = size.height - 140 - safeBottom;
    final double slotWidth = size.width / bins.length;
    return <BinType, Rect>{
      for (int i = 0; i < bins.length; i++)
        bins[i]: Rect.fromLTWH(i * slotWidth + 5, binTop, slotWidth - 10, 104),
    };
  }

  List<WasteType> get _cleanWasteTypes => const <WasteType>[
    WasteType.plastic,
    WasteType.metal,
    WasteType.paper,
    WasteType.glass,
    WasteType.food,
  ];

  List<BinType> get _binTypes => const <BinType>[
    BinType.organic,
    BinType.recycle,
    BinType.paper,
    BinType.hazard,
  ];

  void _buySkin(int index) {
    final TornadoSkin skin = _skins[index];
    setState(() {
      if (_unlockedSkins.contains(index)) {
        _selectedSkin = index;
        _playUiSfx(GameArt.sfxTap);
        _hapticSelection();
      } else if (_coins >= skin.price) {
        _coins -= skin.price;
        _unlockedSkins.add(index);
        _selectedSkin = index;
        _playSfx(GameArt.sfxComplete, volume: 0.66);
        _hapticMedium();
      }
    });
  }

  void _buyUpgrade(UpgradeSpec upgrade) {
    final int level = _upgradeLevels[upgrade.key] ?? 1;
    final int cost = upgrade.baseCost + level * 175;
    if (_coins < cost || level >= 10) {
      return;
    }
    setState(() {
      _coins -= cost;
      _upgradeLevels[upgrade.key] = level + 1;
      _playSfx(GameArt.sfxSort, volume: 0.62);
      _hapticLight();
    });
  }

  void _buyShopItem(String name, int price) {
    if (_coins < price) {
      return;
    }
    setState(() {
      _coins -= price;
      _inventory[name] = (_inventory[name] ?? 0) + 1;
      if (name == 'Energy') {
        _energy = math.min(10, _energy + 1);
      }
      _playSfx(GameArt.sfxSort, volume: 0.58);
      _hapticLight();
    });
  }

  void _claimReward(int day) {
    if (_claimedRewardDays.contains(day)) {
      return;
    }
    setState(() {
      _claimedRewardDays.add(day);
      if (day == 7) {
        _coins += 600;
        _gems += 20;
      } else if (day == 2 || day == 5) {
        _gems += day == 2 ? 5 : 10;
      } else if (day == 3) {
        _energy = math.min(10, _energy + 3);
      } else {
        _coins += day == 4 ? 200 : 100;
      }
      _playSfx(GameArt.sfxComplete, volume: 0.64);
      _hapticMedium();
    });
  }

  void _setMusicEnabled(bool value) {
    setState(() => _music = value);
    _playUiSfx(GameArt.sfxToggle, volume: 0.42);
    _hapticSelection();
    _syncMusic();
  }

  void _setSfxEnabled(bool value) {
    setState(() => _sfx = value);
    if (value) {
      _playUiSfx(GameArt.sfxToggle, volume: 0.42);
    }
    _hapticSelection();
  }

  void _setVibrationEnabled(bool value) {
    setState(() => _vibration = value);
    _playUiSfx(GameArt.sfxToggle, volume: 0.42);
    if (value) {
      _hapticMedium();
    }
  }

  void _setPowerSaverEnabled(bool value) {
    setState(() => _powerSaver = value);
    _playUiSfx(GameArt.sfxToggle, volume: 0.36);
    _hapticSelection();
  }

  void _selectMusicTrack(int index) {
    if (index == _selectedMusicTrack) {
      return;
    }
    setState(() => _selectedMusicTrack = index);
    _playUiSfx(GameArt.sfxToggle, volume: 0.46);
    _hapticSelection();
    _activeMusicAsset = null;
    _syncMusic();
  }

  void _resetProgress() {
    setState(() {
      _coins = 8450;
      _gems = 320;
      _energy = 5;
      _bestScore = 0;
      _selectedSkin = 0;
      _selectedMap = 0;
      _unlockedSkins
        ..clear()
        ..add(0);
      _unlockedMaps
        ..clear()
        ..add(0);
    });
    _playSfx(GameArt.sfxBarrel, volume: 0.44);
    _hapticHeavy();
  }

  void _showView(GameView view) {
    setState(() {
      _view = view;
      if (view != GameView.game) {
        _paused = false;
      }
    });
    _playUiSfx(GameArt.sfxTap, volume: 0.38);
    _hapticSelection();
    _syncMusic();
  }

  void _startTutorial() {
    _playUiSfx(GameArt.sfxStart, volume: 0.52);
    _hapticMedium();
    setState(() {
      _view = GameView.tutorial;
      _paused = false;
      _tutorialStep = 0;
      _tutorialItem = null;
      _tutorialSize = Size.zero;
      _tutorialHoverBin = null;
      _tutorialSuccessBin = null;
      _tutorialSuccessPulse = 0;
      _bursts.clear();
    });
    _syncMusic();
  }

  WasteType get _tutorialWasteType {
    return switch (_tutorialStep) {
      0 => WasteType.plastic,
      1 => WasteType.paper,
      _ => WasteType.toxic,
    };
  }

  String get _tutorialTitle {
    return switch (_tutorialStep) {
      0 => 'Drag to recycle',
      1 => 'Match the bin',
      _ => 'Avoid toxic barrels',
    };
  }

  String get _tutorialCaption {
    return switch (_tutorialStep) {
      0 => 'Move the blue bottle into the recycle bin.',
      1 => 'Paper goes into the yellow paper bin.',
      _ => 'Toxic barrels hurt. Leave them alone during cleanup.',
    };
  }

  void _ensureTutorialItem(Size size) {
    if (size == Size.zero) {
      return;
    }
    if (_tutorialItem != null && _tutorialSize == size) {
      return;
    }
    _tutorialSize = size;
    final WasteType type = _tutorialWasteType;
    _tutorialItem = WasteItem(
      id: -100 - _tutorialStep,
      type: type,
      asset: _spriteOptions(type).first,
      position: Offset(size.width * 0.5, size.height * 0.27),
      velocity: Offset.zero,
      size: type == WasteType.toxic ? 84 : 76,
      spin: type == WasteType.paper ? 0.16 : -0.18,
    );
    _tutorialHoverBin = null;
    _tutorialSuccessBin = null;
    _tutorialSuccessPulse = 0;
  }

  void _resetTutorialItem() {
    final Size size = _tutorialSize;
    _tutorialItem = null;
    if (size != Size.zero) {
      _ensureTutorialItem(size);
    }
  }

  BinType? _tutorialBinForPosition(Offset position) {
    if (_tutorialSize == Size.zero) {
      return null;
    }
    final Map<BinType, Rect> rects = _binRects(
      _tutorialSize,
      bottomInset: _tutorialDockInset,
    );
    for (final MapEntry<BinType, Rect> entry in rects.entries) {
      if (entry.value.inflate(12).contains(position)) {
        return entry.key;
      }
    }
    return null;
  }

  void _startTutorialDrag() {
    final WasteItem? item = _tutorialItem;
    if (item == null) {
      return;
    }
    if (item.type == WasteType.toxic) {
      _playSfx(GameArt.sfxBarrel, volume: 0.42);
      _hapticHeavy();
      setState(() {
        _bursts.add(
          SortBurst(
            position: item.position,
            label: 'AVOID',
            color: const Color(0xffff3b4f),
          ),
        );
      });
      return;
    }
    _playUiSfx(GameArt.sfxTap, volume: 0.34);
    _hapticSelection();
    setState(() {
      item.held = true;
      item.trail.clear();
      item.trail.add(item.position);
      _tutorialHoverBin = _tutorialBinForPosition(item.position);
    });
  }

  void _dragTutorialItem(DragUpdateDetails details) {
    final WasteItem? item = _tutorialItem;
    if (item == null || item.type == WasteType.toxic) {
      return;
    }
    setState(() {
      _rememberTrailPoint(item);
      item.position += details.delta;
      _tutorialHoverBin = _tutorialBinForPosition(item.position);
    });
  }

  void _releaseTutorialItem(DragEndDetails details) {
    final WasteItem? item = _tutorialItem;
    if (item == null || item.type == WasteType.toxic) {
      return;
    }
    final BinType? target = _tutorialBinForPosition(item.position);
    setState(() {
      item.held = false;
      if (target == item.type.bin) {
        _playSfx(GameArt.sfxSort, volume: 0.68);
        _hapticLight();
        _tutorialSuccessBin = target;
        _tutorialSuccessPulse = 1;
        _bursts.add(
          SortBurst(
            position: item.position,
            label: 'GREAT',
            color: const Color(0xffbaff3d),
          ),
        );
        _tutorialStep = math.min(2, _tutorialStep + 1);
        _tutorialItem = null;
      } else {
        _playSfx(GameArt.sfxMiss, volume: 0.45);
        _hapticSelection();
        _bursts.add(
          SortBurst(
            position: item.position,
            label: target == null ? 'DRAG' : 'TRY AGAIN',
            color: const Color(0xffffd33d),
          ),
        );
        _resetTutorialItem();
      }
      _tutorialHoverBin = null;
    });
  }

  void _finishTutorial({bool startRun = true}) {
    setState(() {
      _tutorialSeen = true;
      _tutorialItem = null;
      _tutorialHoverBin = null;
      _tutorialSuccessBin = null;
      _tutorialSuccessPulse = 0;
      _bursts.clear();
    });
    if (startRun) {
      _startRun();
    } else {
      _showView(GameView.menu);
    }
  }

  Future<void> _handleBackPressed() async {
    if (_view == GameView.game || _view == GameView.tutorial) {
      await _confirmQuitRun();
      return;
    }
    if (_view == GameView.menu) {
      await _confirmExitApp();
      return;
    }
    _showView(GameView.menu);
  }

  Future<void> _confirmQuitRun() async {
    final bool wasPaused = _paused;
    if (_view == GameView.game && !_paused) {
      setState(() => _paused = true);
    }
    final bool quit = await _showQuitDialog(
      title: 'Quit Game?',
      message: 'Do you want to quit the game?',
      confirmLabel: 'Quit',
      cancelLabel: 'Keep Playing',
      confirmColor: const Color(0xffdd3642),
    );
    if (!mounted) {
      return;
    }
    if (!quit) {
      if (_view == GameView.game) {
        setState(() => _paused = wasPaused);
      }
      return;
    }
    setState(() {
      _paused = false;
      _view = GameView.menu;
      _items.clear();
      _bursts.clear();
      _hoverBin = null;
      _successBin = null;
      _tutorialItem = null;
      _tutorialHoverBin = null;
      _tutorialSuccessBin = null;
    });
    _playUiSfx(GameArt.sfxTap, volume: 0.38);
    _hapticSelection();
    _syncMusic();
  }

  Future<void> _confirmExitApp() async {
    final bool quit = await _showQuitDialog(
      title: 'Quit Trash Tornado?',
      message: 'Do you want to quit the game?',
      confirmLabel: 'Quit',
      cancelLabel: 'Stay',
      confirmColor: const Color(0xffdd3642),
    );
    if (!quit) {
      return;
    }
    await _stopAllAudio();
    await SystemNavigator.pop();
  }

  Future<bool> _showQuitDialog({
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    required Color confirmColor,
  }) async {
    if (_quitDialogOpen || !mounted) {
      return false;
    }
    _quitDialogOpen = true;
    _playUiSfx(GameArt.sfxTap, volume: 0.32);
    final bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 330),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xff0d3760), Color(0xff041321)],
              ),
              border: Border.all(color: const Color(0xff78c7ff), width: 1.4),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 18,
                  offset: Offset(0, 9),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.exit_to_app_rounded,
                  color: Color(0xffffdf4f),
                  size: 44,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: _titleStyle(27).copyWith(shadows: _textShadows),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ArcadeButton(
                        label: cancelLabel,
                        icon: Icons.play_arrow_rounded,
                        compact: true,
                        color: const Color(0xff1468cc),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ArcadeButton(
                        label: confirmLabel,
                        icon: Icons.home_rounded,
                        compact: true,
                        color: confirmColor,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    _quitDialogOpen = false;
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final Widget screen = switch (_view) {
      GameView.game => _buildGameScreen(),
      GameView.tutorial => _buildTutorialScreen(),
      GameView.complete => _buildLevelComplete(),
      GameView.map => _screenFrame(title: 'World Map', child: _buildMap()),
      GameView.shop => _screenFrame(title: 'Shop', child: _buildShop()),
      GameView.upgrades => _screenFrame(
        title: 'Upgrades',
        child: _buildUpgrades(),
      ),
      GameView.rewards => _screenFrame(
        title: 'Daily Rewards',
        child: _buildRewards(),
      ),
      GameView.skins => _screenFrame(title: 'Skins', child: _buildSkins()),
      GameView.settings => _screenFrame(
        title: 'Settings',
        child: _buildSettings(),
      ),
      GameView.modes => _screenFrame(title: 'Game Modes', child: _buildModes()),
      GameView.menu => _buildMenu(),
    };
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          unawaited(_handleBackPressed());
        }
      },
      child: screen,
    );
  }

  Widget _buildMenu() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff0b4fa2),
              Color(0xff062f60),
              Color(0xff071423),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _topStatusBar(showBack: false),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xff83ceff),
                        width: 1.7,
                      ),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black87,
                          blurRadius: 18,
                          offset: Offset(0, 10),
                        ),
                        BoxShadow(
                          color: Color(0x6626a4ff),
                          blurRadius: 18,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        _cleanHomeBackdrop(),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.18),
                                  Colors.black.withValues(alpha: 0.42),
                                ],
                                stops: const <double>[0, 0.52, 0.78, 1],
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: IgnorePointer(
                            child: AnimatedBuilder(
                              animation: _ambientController,
                              builder: (BuildContext context, _) {
                                return CustomPaint(
                                  painter: HomeSwirlPainter(
                                    progress: _ambientController.value,
                                    skin: _skins[_selectedSkin],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: IgnorePointer(
                            child: LayoutBuilder(
                              builder:
                                  (
                                    BuildContext context,
                                    BoxConstraints constraints,
                                  ) {
                                    final double spriteSize = math.min(
                                      math.min(
                                        constraints.maxWidth * 0.78,
                                        constraints.maxHeight * 0.48,
                                      ),
                                      440,
                                    );
                                    final double centerX =
                                        constraints.maxWidth * 0.55;
                                    final double centerY =
                                        constraints.maxHeight * 0.57;
                                    return Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: centerX - spriteSize / 2,
                                          top: math.max(
                                            128,
                                            centerY - spriteSize / 2,
                                          ),
                                          child: AnimatedBuilder(
                                            animation: _ambientController,
                                            builder:
                                                (
                                                  BuildContext context,
                                                  Widget? child,
                                                ) {
                                                  final double bob =
                                                      math.sin(
                                                        _ambientController
                                                                .value *
                                                            math.pi *
                                                            2,
                                                      ) *
                                                      6;
                                                  return Transform.translate(
                                                    offset: Offset(0, bob),
                                                    child: child,
                                                  );
                                                },
                                            child: _selectedSkinSprite(
                                              size: spriteSize,
                                              opacity: 0.99,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: 116,
                          bottom: 150,
                          child: _homeMenuRail(),
                        ),
                        Positioned(
                          left: 76,
                          right: 12,
                          top: 34,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Transform.rotate(
                                angle: -0.07,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'TRASH',
                                    style: _titleStyle(54).copyWith(
                                      height: 0.82,
                                      shadows: _logoShadows,
                                    ),
                                  ),
                                ),
                              ),
                              Transform.rotate(
                                angle: -0.07,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'TORNADO',
                                    style: _titleStyle(58).copyWith(
                                      color: const Color(0xffa7ff2f),
                                      height: 0.82,
                                      shadows: _logoShadows,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 78,
                          right: 54,
                          bottom: 90,
                          child: AnimatedBuilder(
                            animation: _ambientController,
                            builder: (BuildContext context, Widget? child) {
                              final double pulse =
                                  1 +
                                  math.sin(
                                        _ambientController.value * math.pi * 2,
                                      ) *
                                      0.018;
                              return Transform.scale(
                                scale: pulse,
                                child: child,
                              );
                            },
                            child: ArcadeButton(
                              label: 'PLAY',
                              icon: Icons.play_arrow_rounded,
                              color: const Color(0xffffd22d),
                              foreground: const Color(0xff2f1700),
                              onPressed: () => _tutorialSeen
                                  ? _startRun()
                                  : _startTutorial(),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 58,
                          right: 26,
                          bottom: 22,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ArcadeButton(
                                  label: 'Store',
                                  icon: Icons.shopping_cart_rounded,
                                  compact: true,
                                  color: const Color(0xff8247e6),
                                  onPressed: () => _showView(GameView.shop),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: ArcadeButton(
                                  label: 'Skins',
                                  icon: Icons.cyclone_rounded,
                                  compact: true,
                                  color: const Color(0xff1594f2),
                                  onPressed: () => _showView(GameView.skins),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cleanHomeBackdrop() {
    return _sceneBackground(
      GameArt.homeBackground,
      alignment: Alignment.topCenter,
      scrim: 0.02,
    );
  }

  Widget _selectedSkinSprite({required double size, double opacity = 1}) {
    final TornadoSkin skin = _skins[_selectedSkin];
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: size * 0.58,
              height: size * 0.58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: skin.colors.first.withValues(alpha: 0.55),
                    blurRadius: size * 0.13,
                    spreadRadius: size * 0.025,
                  ),
                  BoxShadow(
                    color: skin.colors.last.withValues(alpha: 0.34),
                    blurRadius: size * 0.18,
                    spreadRadius: size * 0.035,
                  ),
                ],
              ),
            ),
            Image.asset(
              skin.asset,
              width: size,
              height: size,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorialScreen() {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = Size(constraints.maxWidth, constraints.maxHeight);
          final double dockInset = _bottomDockInset(context);
          _tutorialDockInset = dockInset;
          _ensureTutorialItem(size);
          final WasteItem? item = _tutorialItem;
          final Map<BinType, Rect> binRects = _binRects(
            size,
            bottomInset: dockInset,
          );
          final BinType? activeBin =
              item == null || item.type == WasteType.toxic
              ? null
              : item.type.bin;
          final Offset? target = activeBin == null
              ? null
              : binRects[activeBin]?.center;
          final bool hazardWarning = item?.type == WasteType.toxic;
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _sceneBackground(
                GameArt.gameplayBackground,
                alignment: Alignment.topCenter,
                scrim: 0.08,
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _ambientController,
                    builder: (BuildContext context, _) {
                      return CustomPaint(
                        painter: TutorialGuidePainter(
                          item: item,
                          target: target,
                          progress: _ambientController.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _ambientController,
                    builder: (BuildContext context, _) {
                      return CustomPaint(
                        painter: GameplayEffectsPainter(
                          items: item == null
                              ? const <WasteItem>[]
                              : <WasteItem>[item],
                          binRects: binRects,
                          activeBin: activeBin,
                          hoverBin: _tutorialHoverBin,
                          successBin: _tutorialSuccessBin,
                          successPulse: _tutorialSuccessPulse,
                          hazardWarning: hazardWarning,
                          time: _ambientController.value * 10,
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (item != null)
                Positioned(
                  left: item.position.dx - item.size * 0.6,
                  top: item.position.dy - item.size * 0.6,
                  child: GestureDetector(
                    onPanStart: (_) => _startTutorialDrag(),
                    onPanUpdate: _dragTutorialItem,
                    onPanEnd: _releaseTutorialItem,
                    onTap: _startTutorialDrag,
                    child: WasteToken(item: item),
                  ),
                ),
              if (item != null && item.type == WasteType.toxic)
                Positioned(
                  left: (item.position.dx - 42).clamp(8, size.width - 92),
                  top: (item.position.dy - 72).clamp(58, size.height - 180),
                  child: _warningBadge('AVOID'),
                ),
              for (final SortBurst burst in _bursts)
                Positioned(
                  left: (burst.position.dx - 55)
                      .clamp(8, size.width - 118)
                      .toDouble(),
                  top: (burst.position.dy - 34)
                      .clamp(48, size.height - 150)
                      .toDouble(),
                  child: _floatingBurst(burst),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BinDock(
                  rects: binRects,
                  activeBin: activeBin,
                  hoverBin: _tutorialHoverBin,
                  successBin: _tutorialSuccessBin,
                  successPulse: _tutorialSuccessPulse,
                  hazardWarning: hazardWarning,
                  time: _ambientController.value * 10,
                  bottomInset: dockInset,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          _roundIcon(
                            icon: Icons.arrow_back_rounded,
                            onTap: () => unawaited(_confirmQuitRun()),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _hudPill(
                              icon: Icons.school_rounded,
                              label:
                                  'Tutorial ${math.min(3, _tutorialStep + 1)}/3',
                              color: const Color(0xff36d6ff),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _roundIcon(
                            icon: Icons.skip_next_rounded,
                            onTap: () => _finishTutorial(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _tutorialCard(),
                      const Spacer(),
                      if (_tutorialStep >= 2)
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            44,
                            0,
                            44,
                            120 + dockInset,
                          ),
                          child: ArcadeButton(
                            label: 'Start Run',
                            icon: Icons.play_arrow_rounded,
                            color: const Color(0xffbaff3d),
                            foreground: const Color(0xff183600),
                            onPressed: () => _finishTutorial(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tutorialCard() {
    final WasteType type = _tutorialWasteType;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 13),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xff0b4e93), Color(0xff062340)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black45,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: <Color>[
                  type.color.withValues(alpha: 0.95),
                  Color.lerp(type.color, Colors.black, 0.28)!,
                ],
              ),
              border: Border.all(color: Colors.white70, width: 1.2),
            ),
            child: Icon(type.icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(_tutorialTitle, style: _titleStyle(19)),
                const SizedBox(height: 4),
                Text(
                  _tutorialCaption,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameScreen() {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = Size(constraints.maxWidth, constraints.maxHeight);
          final double dockInset = _bottomDockInset(context);
          _playDockInset = dockInset;
          if (_playSize != size) {
            _playSize = size;
          }
          _ensureScreenshotGameplayItems(size);
          final Map<BinType, Rect> binRects = _binRects(
            size,
            bottomInset: dockInset,
          );
          WasteItem? heldItem;
          for (final WasteItem item in _items) {
            if (item.held) {
              heldItem = item;
              break;
            }
          }
          final BinType? activeBin = heldItem?.kind == DropKind.waste
              ? heldItem?.type.bin
              : null;
          final bool hazardWarning = _items.any(
            (WasteItem item) =>
                item.kind == DropKind.waste && item.type == WasteType.toxic,
          );
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _sceneBackground(
                GameArt.gameplayBackground,
                alignment: Alignment.topCenter,
                scrim: 0.02,
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _ambientController,
                    builder: (BuildContext context, _) {
                      final double spriteSize = math.min(
                        math.min(size.width * 0.66, size.height * 0.34),
                        330,
                      );
                      final double drift =
                          math.sin(_ambientController.value * math.pi * 2) * 7;
                      final double maskWidth = size.width * 0.74;
                      final double maskHeight = spriteSize * 1.18;
                      return Stack(
                        children: <Widget>[
                          Positioned(
                            left: size.width / 2 - maskWidth / 2,
                            top: size.height * 0.58 - maskHeight / 2,
                            child: Container(
                              width: maskWidth,
                              height: maskHeight,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: <Color>[
                                    Colors.white.withValues(alpha: 0.24),
                                    const Color(
                                      0xff7ee7ff,
                                    ).withValues(alpha: 0.08),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: size.width / 2 - spriteSize / 2 + drift * 0.2,
                            top: size.height * 0.58 - spriteSize / 2 + drift,
                            child: _selectedSkinSprite(
                              size: spriteSize,
                              opacity: 0.9,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: GameplayEffectsPainter(
                      items: _items,
                      binRects: binRects,
                      activeBin: activeBin,
                      hoverBin: _hoverBin,
                      successBin: _successBin,
                      successPulse: _successPulse,
                      hazardWarning: hazardWarning,
                      time: _timeLeft,
                    ),
                  ),
                ),
              ),
              for (final WasteItem item in _items)
                Positioned(
                  left: item.position.dx - item.size * 0.6,
                  top: item.position.dy - item.size * 0.6,
                  child: GestureDetector(
                    onPanStart: (_) => _startDrag(item.id),
                    onPanUpdate: (DragUpdateDetails details) =>
                        _dragItem(item.id, details),
                    onPanEnd: (DragEndDetails details) =>
                        _releaseItem(item.id, details),
                    child: WasteToken(item: item),
                  ),
                ),
              for (final WasteItem item in _items)
                if (item.kind == DropKind.waste && item.type == WasteType.toxic)
                  Positioned(
                    left: (item.position.dx - 42)
                        .clamp(8, size.width - 92)
                        .toDouble(),
                    top: (item.position.dy - item.size * 0.88)
                        .clamp(56, size.height - 180)
                        .toDouble(),
                    child: _warningBadge('AVOID'),
                  ),
              for (final SortBurst burst in _bursts)
                Positioned(
                  left: (burst.position.dx - 55)
                      .clamp(8, size.width - 118)
                      .toDouble(),
                  top: (burst.position.dy - 34)
                      .clamp(48, size.height - 150)
                      .toDouble(),
                  child: _floatingBurst(burst),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BinDock(
                  rects: binRects,
                  activeBin: activeBin,
                  hoverBin: _hoverBin,
                  successBin: _successBin,
                  successPulse: _successPulse,
                  hazardWarning: hazardWarning,
                  time: _timeLeft,
                  bottomInset: dockInset,
                ),
              ),
              Positioned(
                right: 10,
                top: size.height * 0.43,
                child: _powerMeter(),
              ),
              Positioned(
                right: 10,
                bottom: 164 + dockInset,
                child: _ecoBlastButton(),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          _roundIcon(
                            icon: _paused
                                ? Icons.play_arrow_rounded
                                : Icons.pause_rounded,
                            onTap: () => setState(() => _paused = !_paused),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _hudPill(
                              icon: Icons.timer_rounded,
                              label: _timeLeft.ceil().toString().padLeft(
                                2,
                                '0',
                              ),
                              color: const Color(0xffffc83d),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _hudPill(
                              icon: Icons.favorite_rounded,
                              label: '$_hearts',
                              color: const Color(0xffff4668),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _hudPill(
                              icon: Icons.star_rounded,
                              label: '$_score',
                              color: const Color(0xffbaff3d),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (_combo > 1)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 6,
                              bottom: 160 + dockInset,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffff7a1a),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Text(
                              'COMBO\n$_combo\nAWESOME!',
                              textAlign: TextAlign.center,
                              style: _titleStyle(24).copyWith(height: 0.82),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (_paused)
                Positioned.fill(
                  child: Container(
                    color: Colors.black54,
                    child: Center(child: _pausePanel()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _pausePanel() {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Paused', style: _titleStyle(28)),
          const SizedBox(height: 14),
          ArcadeButton(
            label: 'Resume',
            icon: Icons.play_arrow_rounded,
            compact: true,
            onPressed: () => setState(() => _paused = false),
          ),
          const SizedBox(height: 10),
          ArcadeButton(
            label: 'Quit',
            icon: Icons.home_rounded,
            compact: true,
            color: const Color(0xffdd3642),
            onPressed: () => unawaited(_confirmQuitRun()),
          ),
        ],
      ),
    );
  }

  Widget _powerMeter() {
    return Container(
      width: 24,
      height: 128,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xff06213d),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xff6bb8ff), width: 1.2),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: (_energy / 10).clamp(0.12, 1),
          widthFactor: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[Color(0xffffe243), Color(0xff41ef63)],
              ),
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ecoBlastButton() {
    final int owned = _inventory['Eco Blast'] ?? 0;
    final bool enabled = owned > 0 && _view == GameView.game && !_paused;
    return GestureDetector(
      onTap: enabled ? _useEcoBlastInventory : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 160),
        opacity: enabled ? 1 : 0.62,
        child: Container(
          width: 82,
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 7),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: enabled
                  ? const <Color>[Color(0xfff8ff45), Color(0xff19c968)]
                  : const <Color>[Color(0xff53666d), Color(0xff21323a)],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white, width: 1.4),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: (enabled ? const Color(0xffbaff3d) : Colors.black)
                    .withValues(alpha: enabled ? 0.42 : 0.26),
                blurRadius: enabled ? 18 : 8,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xff07381f),
                size: 22,
              ),
              const SizedBox(height: 2),
              Text(
                'BLAST x$owned',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: enabled ? const Color(0xff07381f) : Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  shadows: enabled ? null : _textShadows,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _warningBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xffff424f), Color(0xff8f0710)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.72)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.warning_rounded, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.black87,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingBurst(SortBurst burst) {
    final double opacity = (1 - burst.age / 0.95).clamp(0, 1).toDouble();
    final double scale = 1 + math.sin(burst.age * math.pi) * 0.18;
    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xff06213d).withValues(alpha: 0.86),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: burst.color, width: 1.4),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: burst.color.withValues(alpha: 0.42),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              burst.label,
              textAlign: TextAlign.center,
              style: _titleStyle(
                18,
              ).copyWith(color: burst.color, shadows: _textShadows),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelComplete() {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _ambientController,
        builder: (BuildContext context, _) {
          return AnimatedBuilder(
            animation: _celebrationController,
            builder: (BuildContext context, _) {
              final double progress = _celebrationController.value;
              final int stars = _earnedStars;
              final bool passed = stars > 0;
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final bool compact = constraints.maxHeight < 720;
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CustomPaint(
                        painter: ResultCelebrationPainter(
                          progress: progress,
                          ambient: _ambientController.value,
                          success: passed,
                          stars: stars,
                        ),
                      ),
                      SafeArea(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                16,
                                compact ? 10 : 14,
                                16,
                                16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: _screenTitlePlaque('Level Complete'),
                                  ),
                                  SizedBox(height: compact ? 14 : 22),
                                  _animatedEntrance(
                                    progress: progress,
                                    child: _buildResultHeadline(
                                      passed: passed,
                                      compact: compact,
                                    ),
                                  ),
                                  SizedBox(height: compact ? 8 : 12),
                                  _buildResultStars(stars, progress, compact),
                                  SizedBox(height: compact ? 12 : 18),
                                  _buildResultPanel(progress, compact),
                                  SizedBox(height: compact ? 12 : 18),
                                  _animatedEntrance(
                                    progress: progress,
                                    delay: 0.52,
                                    child: ArcadeButton(
                                      label: passed ? 'NEXT' : 'MAP',
                                      icon: passed
                                          ? Icons.arrow_forward_rounded
                                          : Icons.map_rounded,
                                      onPressed: () {
                                        final int next = math.min(
                                          _selectedMap + 1,
                                          _maps.length - 1,
                                        );
                                        if (passed &&
                                            _unlockedMaps.contains(next)) {
                                          _startRun(map: next);
                                        } else {
                                          setState(() => _view = GameView.map);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  _animatedEntrance(
                                    progress: progress,
                                    delay: 0.6,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: ArcadeButton(
                                            label: 'Home',
                                            icon: Icons.home_rounded,
                                            compact: true,
                                            color: const Color(0xff1468cc),
                                            onPressed: () => setState(
                                              () => _view = GameView.menu,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: ArcadeButton(
                                            label: 'Retry',
                                            icon: Icons.refresh_rounded,
                                            compact: true,
                                            color: const Color(0xffdf8f13),
                                            onPressed: () => _startRun(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildResultHeadline({required bool passed, required bool compact}) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              passed ? 'CLEAN CITY!' : 'TRY AGAIN!',
              textAlign: TextAlign.center,
              maxLines: 1,
              style: _titleStyle(compact ? 38 : 44).copyWith(
                color: passed
                    ? const Color(0xffc6ff43)
                    : const Color(0xffffdf4f),
                shadows: _textShadows,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xff061423).withValues(alpha: 0.62),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.24)),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _resultCaption.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultStars(int stars, double progress, bool compact) {
    return SizedBox(
      height: compact ? 92 : 108,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: StarGlowPainter(
                  progress: progress,
                  earnedStars: stars,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _resultStar(index: 0, earnedStars: stars, progress: progress),
              SizedBox(width: compact ? 2 : 6),
              Padding(
                padding: EdgeInsets.only(bottom: compact ? 8 : 4),
                child: _resultStar(
                  index: 1,
                  earnedStars: stars,
                  progress: progress,
                  featured: true,
                ),
              ),
              SizedBox(width: compact ? 2 : 6),
              _resultStar(index: 2, earnedStars: stars, progress: progress),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resultStar({
    required int index,
    required int earnedStars,
    required double progress,
    bool featured = false,
  }) {
    final bool earned = index < earnedStars;
    final double local = ((progress - 0.12 - index * 0.13) / 0.42)
        .clamp(0, 1)
        .toDouble();
    final double pop = earned && local > 0
        ? Curves.elasticOut.transform(local)
        : Curves.easeOutCubic.transform(local);
    final double size = featured ? 86 : 72;
    final double tilt = (index - 1) * 0.13 + math.sin(local * math.pi) * 0.09;
    return Opacity(
      opacity: earned ? local.clamp(0.18, 1).toDouble() : 0.58,
      child: Transform.translate(
        offset: Offset(0, earned ? -math.sin(local * math.pi) * 12 : 0),
        child: Transform.rotate(
          angle: tilt,
          child: Transform.scale(
            scale: earned ? pop : 0.82 + pop * 0.12,
            child: SizedBox(
              width: featured ? 98 : 82,
              height: featured ? 98 : 82,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  if (earned)
                    Container(
                      width: size * 0.74,
                      height: size * 0.74,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: const Color(
                              0xffffd33d,
                            ).withValues(alpha: 0.72 * local),
                            blurRadius: 24,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  Icon(
                    earned ? Icons.star_rounded : Icons.star_border_rounded,
                    size: size + 12,
                    color: earned
                        ? const Color(0xffa46200)
                        : Colors.black.withValues(alpha: 0.32),
                  ),
                  Icon(
                    earned ? Icons.star_rounded : Icons.star_border_rounded,
                    size: size,
                    color: earned
                        ? const Color(0xffffe448)
                        : Colors.white.withValues(alpha: 0.5),
                  ),
                  if (earned)
                    Transform.translate(
                      offset: Offset(-size * 0.09, -size * 0.12),
                      child: Icon(
                        Icons.star_rounded,
                        size: size * 0.48,
                        color: Colors.white.withValues(alpha: 0.36),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultPanel(double progress, bool compact) {
    return _animatedEntrance(
      progress: progress,
      delay: 0.34,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(compact ? 14 : 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xff082a4a), Color(0xff03131e)],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff4ba4d8), width: 1.2),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 18,
              offset: Offset(0, 9),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: _resultMetric('Score', _formatNumber(_score))),
                Container(width: 1, height: 58, color: Colors.white12),
                Expanded(
                  child: _resultMetric('Best', _formatNumber(_bestScore)),
                ),
              ],
            ),
            if (_lastNewRecord) ...<Widget>[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xffffef54), Color(0xffff8d1a)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'NEW RECORD!',
                  style: TextStyle(
                    color: Color(0xff3a1900),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
            const Divider(height: 28, color: Colors.white24),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _rewardChip(
                    Icons.monetization_on_rounded,
                    _formatNumber(_lastCoinsEarned),
                  ),
                  const SizedBox(width: 28),
                  _rewardChip(Icons.diamond_rounded, '$_lastGemsEarned'),
                  const SizedBox(width: 28),
                  _rewardChip(Icons.bolt_rounded, '$_lastEnergyEarned'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultMetric(String title, String value) {
    return Column(
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(value, style: _titleStyle(31)),
        ),
      ],
    );
  }

  Widget _animatedEntrance({
    required double progress,
    required Widget child,
    double delay = 0,
  }) {
    final double normalized = ((progress - delay) / math.max(0.01, 1 - delay))
        .clamp(0, 1)
        .toDouble();
    final double eased = Curves.easeOutCubic.transform(normalized);
    return Opacity(
      opacity: eased,
      child: Transform.translate(
        offset: Offset(0, 22 * (1 - eased)),
        child: child,
      ),
    );
  }

  Widget _buildMap() {
    const List<Offset> positions = <Offset>[
      Offset(0.47, 0.13),
      Offset(0.66, 0.35),
      Offset(0.29, 0.45),
      Offset(0.62, 0.63),
      Offset(0.48, 0.83),
    ];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size size = Size(constraints.maxWidth, constraints.maxHeight);
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _sceneBackground(
              GameArt.worldMapBackground,
              alignment: Alignment.topCenter,
              scrim: 0.02,
            ),
            for (int i = 0; i < _maps.length; i++)
              Positioned(
                left: (size.width * positions[i].dx - 72)
                    .clamp(8, size.width - 154)
                    .toDouble(),
                top: (size.height * positions[i].dy)
                    .clamp(8, size.height - 126)
                    .toDouble(),
                child: _mapNode(i),
              ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 12,
              child: ArcadeButton(
                label: 'Play Selected',
                icon: Icons.play_arrow_rounded,
                compact: true,
                onPressed: () => _startRun(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _mapNode(int index) {
    final CityMap map = _maps[index];
    final bool unlocked = _unlockedMaps.contains(index);
    final bool selected = _selectedMap == index;
    return InkWell(
      onTap: unlocked
          ? () => setState(() {
              _selectedMap = index;
            })
          : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 146,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: unlocked
              ? const Color(0xff123b52).withValues(alpha: 0.88)
              : const Color(0xff101b2b).withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? const Color(0xffffd642) : const Color(0xff6ba9df),
            width: selected ? 2 : 1,
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 18,
              backgroundColor: unlocked
                  ? map.colors.first.withValues(alpha: 0.9)
                  : Colors.white12,
              child: Icon(
                unlocked ? map.icon : Icons.lock_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${index + 1}. ${map.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: List<Widget>.generate(
                      3,
                      (int star) => Icon(
                        Icons.star_rounded,
                        color: unlocked
                            ? const Color(0xffffd642)
                            : Colors.white24,
                        size: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShop() {
    final List<String> tabs = <String>['Power-Ups', 'Tools', 'Coins', 'Gems'];
    final List<_ShopEntry> entries = switch (_shopTab) {
      0 => <_ShopEntry>[
        _ShopEntry(
          'Boost',
          'Increase tornado speed for a short time.',
          500,
          Icons.cyclone_rounded,
          const Color(0xff2ed760),
        ),
        _ShopEntry(
          'Magnet',
          'Attract trash items to your drag path.',
          400,
          Icons.explore_rounded,
          const Color(0xffdb4758),
        ),
        _ShopEntry(
          'Freeze',
          'Freeze time for five seconds.',
          600,
          Icons.ac_unit_rounded,
          const Color(0xff4bc8ff),
        ),
        _ShopEntry(
          'Energy',
          'Start one level with extra energy.',
          300,
          Icons.bolt_rounded,
          const Color(0xffffc73d),
        ),
        _ShopEntry(
          'Eco Blast',
          'Clears every falling trash item instantly.',
          700,
          Icons.auto_awesome_rounded,
          const Color(0xffbaff3d),
        ),
      ],
      1 => <_ShopEntry>[
        _ShopEntry(
          'Sorter',
          'Shows faint bin hints while dragging.',
          650,
          Icons.rule_rounded,
          const Color(0xff70da5f),
        ),
        _ShopEntry(
          'Map Pin',
          'Adds one free map preview.',
          850,
          Icons.push_pin_rounded,
          const Color(0xffffb24d),
        ),
        _ShopEntry(
          'Cleaner',
          'Removes one missed-trash penalty.',
          750,
          Icons.cleaning_services_rounded,
          const Color(0xff4dc9ff),
        ),
      ],
      2 => <_ShopEntry>[
        _ShopEntry(
          'Coin Pack',
          'Instant 1,000 cleanup coins.',
          0,
          Icons.monetization_on_rounded,
          const Color(0xffffc73d),
        ),
        _ShopEntry(
          'Coin Crate',
          'Instant 3,000 cleanup coins.',
          0,
          Icons.inventory_2_rounded,
          const Color(0xffff9a2f),
        ),
      ],
      _ => <_ShopEntry>[
        _ShopEntry(
          'Gem Stack',
          'Instant 60 gems.',
          0,
          Icons.diamond_rounded,
          const Color(0xffbb62ff),
        ),
        _ShopEntry(
          'Gem Chest',
          'Instant 180 gems.',
          0,
          Icons.workspace_premium_rounded,
          const Color(0xff8b5cff),
        ),
      ],
    };

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xff061d38),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xff32669a)),
            ),
            child: Row(
              children: <Widget>[
                for (int i = 0; i < tabs.length; i++)
                  Expanded(child: _shopTabButton(tabs[i], i)),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (BuildContext context, int index) {
              final _ShopEntry entry = entries[index];
              return _shopRow(entry);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 12),
            itemCount: entries.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xff8c2edb),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xffffdf47), width: 2),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.local_offer_rounded,
                  color: Colors.white,
                  size: 34,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Special offer: starter cleanup bundle',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                FilledButton(onPressed: () {}, child: const Text('\$1.99')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _shopRow(_ShopEntry entry) {
    final bool virtualCurrency = entry.price == 0;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panelDecoration(),
      child: Row(
        children: <Widget>[
          _shopEntryIcon(entry),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(entry.name, style: _titleStyle(18)),
                const SizedBox(height: 4),
                Text(
                  entry.caption,
                  style: const TextStyle(color: Colors.white70),
                ),
                if (_inventory.containsKey(entry.name))
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'Owned: ${_inventory[entry.name]}',
                      style: const TextStyle(
                        color: Color(0xffbaff3d),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FilledButton.icon(
            onPressed: virtualCurrency
                ? () => setState(() {
                    if (entry.name.contains('Coin')) {
                      _coins += entry.name.contains('Crate') ? 3000 : 1000;
                    } else {
                      _gems += entry.name.contains('Chest') ? 180 : 60;
                    }
                  })
                : () => _buyShopItem(entry.name, entry.price),
            icon: Icon(
              virtualCurrency
                  ? Icons.add_rounded
                  : Icons.monetization_on_rounded,
            ),
            label: Text(virtualCurrency ? 'Add' : '${entry.price}'),
          ),
        ],
      ),
    );
  }

  Widget _shopEntryIcon(_ShopEntry entry) {
    final String? asset = _shopIconAsset(entry.name);
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: entry.color.withValues(alpha: 0.18),
        border: Border.all(color: entry.color.withValues(alpha: 0.75)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: asset == null
          ? Icon(entry.icon, color: entry.color, size: 34)
          : Image.asset(asset, fit: BoxFit.cover),
    );
  }

  String? _shopIconAsset(String name) {
    return switch (name) {
      'Boost' => GameArt.iconBoost,
      'Magnet' => GameArt.iconMagnet,
      'Freeze' => GameArt.iconFreeze,
      'Energy' => GameArt.iconEnergy,
      'Coin Pack' || 'Coin Crate' => GameArt.iconCoin,
      'Gem Stack' || 'Gem Chest' => GameArt.iconGem,
      _ => null,
    };
  }

  Widget _shopTabButton(String label, int index) {
    final bool selected = _shopTab == index;
    return InkWell(
      onTap: () => setState(() => _shopTab = index),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  colors: <Color>[Color(0xff168df0), Color(0xff0752a4)],
                )
              : null,
          color: selected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: selected ? Colors.white : Colors.white70,
              fontWeight: FontWeight.w900,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpgrades() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        final UpgradeSpec upgrade = _upgrades[index];
        final int level = _upgradeLevels[upgrade.key] ?? 1;
        final int cost = upgrade.baseCost + level * 175;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: _panelDecoration(),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 28,
                backgroundColor: upgrade.color.withValues(alpha: 0.2),
                child: Icon(upgrade.icon, color: upgrade.color, size: 34),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(upgrade.name, style: _titleStyle(18)),
                    const SizedBox(height: 7),
                    Row(
                      children: List<Widget>.generate(
                        10,
                        (int i) => Expanded(
                          child: Container(
                            height: 8,
                            margin: const EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              color: i < level ? upgrade.color : Colors.white12,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Lv. $level',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              FilledButton.icon(
                onPressed: level >= 10 || _coins < cost
                    ? null
                    : () => _buyUpgrade(upgrade),
                icon: const Icon(Icons.monetization_on_rounded),
                label: Text(level >= 10 ? 'MAX' : '$cost'),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 12),
      itemCount: _upgrades.length,
    );
  }

  Widget _buildRewards() {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 7,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.08,
            ),
            itemBuilder: (BuildContext context, int index) {
              final int day = index + 1;
              final bool claimed = _claimedRewardDays.contains(day);
              final bool today = day == 4;
              final IconData icon = switch (day) {
                2 || 5 => Icons.diamond_rounded,
                3 => Icons.bolt_rounded,
                7 => Icons.inventory_2_rounded,
                _ => Icons.monetization_on_rounded,
              };
              final String amount = switch (day) {
                2 => '5',
                3 => '3',
                4 => '200',
                5 => '10',
                6 => '300',
                7 => 'Epic Chest',
                _ => '100',
              };
              return InkWell(
                onTap: claimed ? null : () => _claimReward(day),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xff092b54),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: today
                          ? const Color(0xffffcf35)
                          : Colors.white.withValues(alpha: 0.18),
                      width: today ? 2.5 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('DAY $day', style: _titleStyle(16)),
                      const SizedBox(height: 10),
                      Icon(
                        icon,
                        color: icon == Icons.diamond_rounded
                            ? const Color(0xffbd5cff)
                            : const Color(0xffffce38),
                        size: 38,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        amount,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Icon(
                        claimed
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: claimed
                            ? const Color(0xffbaff3d)
                            : Colors.white38,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ArcadeButton(
            label: _claimedRewardDays.contains(4) ? 'Claimed' : 'Claim Day 4',
            icon: Icons.card_giftcard_rounded,
            onPressed: _claimedRewardDays.contains(4)
                ? null
                : () => _claimReward(4),
          ),
        ),
      ],
    );
  }

  Widget _buildSkins() {
    return Column(
      children: <Widget>[
        _skinTabsHeader(),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
            itemCount: _skins.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.74,
            ),
            itemBuilder: (BuildContext context, int index) {
              final TornadoSkin skin = _skins[index];
              final bool unlocked = _unlockedSkins.contains(index);
              final bool selected = _selectedSkin == index;
              return _skinCard(
                skin: skin,
                index: index,
                unlocked: unlocked,
                selected: selected,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _skinTabsHeader() {
    final List<({IconData icon, String label, bool active})> tabs =
        <({IconData icon, String label, bool active})>[
          (icon: Icons.cyclone_rounded, label: 'Tornado', active: true),
          (icon: Icons.delete_rounded, label: 'Bin', active: false),
          (icon: Icons.palette_rounded, label: 'Theme', active: false),
        ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xff071d3a),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xff3c89d2)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: tabs.map((tab) {
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  gradient: tab.active
                      ? const LinearGradient(
                          colors: <Color>[Color(0xff4ee7ff), Color(0xff147fe8)],
                        )
                      : null,
                  color: tab.active ? null : const Color(0xff11315b),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: tab.active
                        ? Colors.white.withValues(alpha: 0.52)
                        : Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(tab.icon, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          tab.label.toUpperCase(),
                          style: _titleStyle(12).copyWith(
                            color: Colors.white,
                            shadows: _textShadows,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _skinCard({
    required TornadoSkin skin,
    required int index,
    required bool unlocked,
    required bool selected,
  }) {
    final Color primary = skin.colors.first;
    final Color secondary = skin.colors.length > 1
        ? skin.colors[1]
        : skin.colors.first;
    final Color accent = skin.colors.length > 2 ? skin.colors[2] : primary;

    return InkWell(
      onTap: () => _buySkin(index),
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              const Color(0xff124c87),
              Color.lerp(const Color(0xff08294f), secondary, 0.16)!,
              const Color(0xff061a34),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xfff3ff45)
                : primary.withValues(alpha: 0.62),
            width: selected ? 3 : 1.4,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: selected
                  ? accent.withValues(alpha: 0.48)
                  : Colors.black.withValues(alpha: 0.34),
              blurRadius: selected ? 16 : 8,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: primary.withValues(alpha: 0.18),
              blurRadius: 16,
              spreadRadius: -3,
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: -20,
              top: -22,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary.withValues(alpha: 0.18),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                          final double avatarSize = math.min(
                            math.min(
                              constraints.maxWidth * 0.9,
                              constraints.maxHeight * 1.02,
                            ),
                            150,
                          );
                          return Center(
                            child: TornadoAvatar(
                              skin: skin,
                              size: avatarSize,
                              spin: index + _ambientController.value,
                            ),
                          );
                        },
                  ),
                ),
                Text(
                  skin.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _titleStyle(
                    19,
                  ).copyWith(color: Colors.white, shadows: _textShadows),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 32,
                  child: Text(
                    skin.tagline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                _skinActionPill(
                  skin: skin,
                  unlocked: unlocked,
                  selected: selected,
                ),
              ],
            ),
            if (selected)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xffeaff47), Color(0xff49d83c)],
                    ),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Color(0xff063113),
                    size: 22,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _skinActionPill({
    required TornadoSkin skin,
    required bool unlocked,
    required bool selected,
  }) {
    final IconData icon = selected
        ? Icons.check_rounded
        : unlocked
        ? Icons.cyclone_rounded
        : Icons.monetization_on_rounded;
    final String label = selected
        ? 'Selected'
        : unlocked
        ? 'Use'
        : '${skin.price}';
    final List<Color> colors = selected
        ? const <Color>[Color(0xffeaff47), Color(0xff4be245)]
        : unlocked
        ? const <Color>[Color(0xff45d7ff), Color(0xff138ee9)]
        : const <Color>[Color(0xffffdf42), Color(0xffff9c20)];
    final Color foreground = selected || !unlocked
        ? const Color(0xff17310b)
        : Colors.white;

    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.48)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 17, color: foreground),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: foreground,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                shadows: foreground == Colors.white
                    ? _textShadows
                    : const <Shadow>[],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettings() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _settingSwitch(
          Icons.music_note_rounded,
          'Music',
          _music,
          _setMusicEnabled,
        ),
        _musicTrackSelector(),
        _settingSwitch(
          Icons.volume_up_rounded,
          'Sound Effects',
          _sfx,
          _setSfxEnabled,
        ),
        _settingSwitch(
          Icons.vibration_rounded,
          'Vibration',
          _vibration,
          _setVibrationEnabled,
        ),
        _settingSwitch(
          Icons.battery_saver_rounded,
          'Power Saver',
          _powerSaver,
          _setPowerSaverEnabled,
        ),
        const SizedBox(height: 12),
        _settingsRow(Icons.language_rounded, 'Language', 'English'),
        _settingsRow(Icons.support_agent_rounded, 'Support', 'Ready'),
        _settingsRow(Icons.privacy_tip_rounded, 'Privacy Policy', 'Draft'),
        const SizedBox(height: 18),
        ArcadeButton(
          label: 'Reset Progress',
          icon: Icons.delete_forever_rounded,
          color: const Color(0xffc92130),
          onPressed: _resetProgress,
        ),
      ],
    );
  }

  Widget _musicTrackSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.library_music_rounded, color: Colors.white, size: 24),
              SizedBox(width: 10),
              Text(
                'MUSIC TRACK',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < _musicTracks.length; i++) ...<Widget>[
            _musicTrackTile(i),
            if (i != _musicTracks.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _musicTrackTile(int index) {
    final MusicTrackOption track = _musicTracks[index];
    final bool selected = index == _selectedMusicTrack;
    return InkWell(
      onTap: () => _selectMusicTrack(index),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: selected
                ? <Color>[
                    track.color.withValues(alpha: 0.42),
                    const Color(0xff092747),
                  ]
                : const <Color>[Color(0xff092646), Color(0xff061a31)],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? track.color
                : Colors.white.withValues(alpha: 0.16),
            width: selected ? 1.8 : 1,
          ),
          boxShadow: selected
              ? <BoxShadow>[
                  BoxShadow(
                    color: track.color.withValues(alpha: 0.28),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: track.color.withValues(alpha: selected ? 0.95 : 0.22),
                border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
              ),
              child: Icon(
                selected ? Icons.play_arrow_rounded : track.icon,
                color: selected ? const Color(0xff061423) : track.color,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    track.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    track.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle_rounded, color: track.color, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildModes() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        final GameModeOption mode = _modes[index];
        final bool selected = _selectedMode == index;
        return InkWell(
          onTap: () => setState(() => _selectedMode = index),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: selected
                    ? const <Color>[Color(0xff19772d), Color(0xff0d5e73)]
                    : const <Color>[Color(0xff123a64), Color(0xff082848)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected
                    ? const Color(0xffbaff3d)
                    : Colors.white.withValues(alpha: 0.18),
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.black26,
                  child: Icon(mode.icon, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(mode.name, style: _titleStyle(19)),
                      const SizedBox(height: 4),
                      Text(
                        mode.caption,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Icon(
                  selected
                      ? Icons.check_circle_rounded
                      : Icons.play_circle_fill_rounded,
                  color: selected ? const Color(0xffbaff3d) : Colors.white54,
                  size: 32,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 12),
      itemCount: _modes.length,
    );
  }

  Widget _screenFrame({required String title, required Widget child}) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xff052c5b), Color(0xff06182c)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _topStatusBar(title: title),
              Expanded(child: child),
              _bottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sceneBackground(
    String asset, {
    Alignment alignment = Alignment.center,
    double scrim = 0,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          asset,
          fit: BoxFit.cover,
          alignment: alignment,
          filterQuality: FilterQuality.medium,
        ),
        if (scrim > 0) ColoredBox(color: Colors.black.withValues(alpha: scrim)),
      ],
    );
  }

  Widget _screenTitlePlaque(String title) {
    return Container(
      height: 31,
      constraints: const BoxConstraints(maxWidth: 180),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xff168df0), Color(0xff064a99)],
        ),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xff64b7ff)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black45, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title.toUpperCase(),
          style: _titleStyle(15).copyWith(shadows: _textShadows),
        ),
      ),
    );
  }

  Widget _topStatusBar({String? title, bool showBack = true}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 7, 8, 4),
      child: Row(
        children: <Widget>[
          if (showBack)
            _roundIcon(
              icon: Icons.arrow_back_rounded,
              onTap: () => setState(() => _view = GameView.menu),
            )
          else
            _levelBadge(),
          const SizedBox(width: 8),
          Expanded(
            child: title == null
                ? _xpBar()
                : Center(child: _screenTitlePlaque(title)),
          ),
          const SizedBox(width: 8),
          _currencyChip(
            Icons.monetization_on_rounded,
            _coins.toString(),
            const Color(0xffffcc38),
          ),
          const SizedBox(width: 7),
          _currencyChip(
            Icons.diamond_rounded,
            _gems.toString(),
            const Color(0xffba5cff),
          ),
          if (!showBack) ...<Widget>[
            const SizedBox(width: 7),
            _roundIcon(
              icon: Icons.settings_rounded,
              onTap: () => setState(() => _view = GameView.settings),
            ),
          ],
        ],
      ),
    );
  }

  Widget _bottomNav() {
    final List<_NavEntry> entries = <_NavEntry>[
      _NavEntry('Home', Icons.home_rounded, GameView.menu),
      _NavEntry('Map', Icons.map_rounded, GameView.map),
      _NavEntry('Shop', Icons.store_rounded, GameView.shop),
      _NavEntry('Skins', Icons.cyclone_rounded, GameView.skins),
      _NavEntry('Gear', Icons.tune_rounded, GameView.upgrades),
    ];
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xff0b2e57), Color(0xff04101d)],
        ),
        border: Border(top: BorderSide(color: Color(0xff315d8a))),
      ),
      padding: const EdgeInsets.fromLTRB(6, 5, 6, 7),
      child: Row(
        children: entries.map((_NavEntry entry) {
          final bool selected = _view == entry.view;
          return Expanded(
            child: InkWell(
              onTap: () => setState(() => _view = entry.view),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      entry.icon,
                      color: selected
                          ? const Color(0xffffd33d)
                          : Colors.white70,
                      size: 22,
                    ),
                    Text(
                      entry.label,
                      style: TextStyle(
                        color: selected
                            ? const Color(0xffbaff3d)
                            : Colors.white70,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _homeMenuRail() {
    final List<Widget> actions = <Widget>[
      _menuRailAction(
        iconAsset: GameArt.sideIconDaily,
        label: 'Daily\nReward',
        onTap: () => _showView(GameView.rewards),
      ),
      _menuRailAction(
        iconAsset: GameArt.sideIconMissions,
        label: 'Missions',
        onTap: () => _showView(GameView.modes),
      ),
      _menuRailAction(
        iconAsset: GameArt.sideIconLeaderboard,
        label: 'Leaderboard',
        onTap: () => _showView(GameView.map),
      ),
      _menuRailAction(
        iconAsset: GameArt.sideIconSettings,
        label: 'Settings',
        onTap: () => _showView(GameView.settings),
      ),
    ];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const double actionWidth = 70;
        const double actionHeight = 86;
        const double compactGap = 10;
        const double compactHeight = actionHeight * 4 + compactGap * 3;
        if (constraints.maxHeight >= compactHeight) {
          return SizedBox(
            width: actionWidth,
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: actions,
            ),
          );
        }
        return SizedBox(
          width: actionWidth,
          height: constraints.maxHeight,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (int i = 0; i < actions.length; i++) ...<Widget>[
                  actions[i],
                  if (i < actions.length - 1)
                    const SizedBox(height: compactGap),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _menuRailAction({
    required String iconAsset,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 70,
        height: 86,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff174b7e),
              Color(0xff09213e),
              Color(0xff050f1d),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff86c9ff), width: 1.4),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              iconAsset,
              width: 42,
              height: 42,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  height: 0.95,
                  fontWeight: FontWeight.w900,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black87,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _levelBadge() {
    return Container(
      width: 38,
      height: 38,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: <Color>[Color(0xffffd944), Color(0xffff8d21)],
        ),
      ),
      child: Center(child: Text('$_level', style: _titleStyle(15))),
    );
  }

  Widget _xpBar() {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xff61a5dc)),
      ),
      child: Stack(
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: (_xp / 2500).clamp(0, 1),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xff2fc7ff), Color(0xff2472ff)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Center(
            child: Text(
              '$_xp / 2500',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _currencyChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xff0a203b),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xff305b88)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: color, size: 17),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundIcon({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xff174f83), Color(0xff09213d)],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff6ba9df)),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _hudPill({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xff174f83), Color(0xff092541)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff6eaee8)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black38, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewardChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          color: icon == Icons.diamond_rounded
              ? const Color(0xffbf5cff)
              : icon == Icons.bolt_rounded
              ? const Color(0xffffd13f)
              : const Color(0xffffc33d),
          size: 28,
        ),
        const SizedBox(width: 6),
        Text(label, style: _titleStyle(18)),
      ],
    );
  }

  Widget _settingSwitch(
    IconData icon,
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: _panelDecoration(),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _settingsRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: _panelDecoration(),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white54),
        ],
      ),
    );
  }

  BoxDecoration _panelDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xff0b3767), Color(0xff071d37)],
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xff356b9e)),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 5)),
      ],
    );
  }

  TextStyle _titleStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w900,
      letterSpacing: 0,
      color: Colors.white,
    );
  }

  List<Shadow> get _textShadows => const <Shadow>[
    Shadow(color: Colors.black87, blurRadius: 1, offset: Offset(0, 3)),
    Shadow(color: Color(0xff0d4f27), blurRadius: 12),
  ];

  List<Shadow> get _logoShadows => const <Shadow>[
    Shadow(color: Color(0xff042a4d), blurRadius: 2, offset: Offset(3, 4)),
    Shadow(color: Color(0xff0f7f2e), blurRadius: 12),
    Shadow(color: Colors.black87, blurRadius: 1, offset: Offset(0, 2)),
  ];
}

class _ShopEntry {
  const _ShopEntry(this.name, this.caption, this.price, this.icon, this.color);

  final String name;
  final String caption;
  final int price;
  final IconData icon;
  final Color color;
}

class _NavEntry {
  const _NavEntry(this.label, this.icon, this.view);

  final String label;
  final IconData icon;
  final GameView view;
}

class HomeSwirlPainter extends CustomPainter {
  HomeSwirlPainter({required this.progress, required this.skin});

  final double progress;
  final TornadoSkin skin;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) {
      return;
    }
    final double phase = progress * math.pi * 2;
    final Offset center = Offset(size.width * 0.51, size.height * 0.58);
    final double bodyHeight = size.height * 0.48;
    final Color primary = skin.colors.first;
    final Color secondary = skin.colors.length > 1
        ? skin.colors[1]
        : const Color(0xffaaff2c);

    final Paint halo = Paint()
      ..shader =
          RadialGradient(
            colors: <Color>[
              primary.withValues(alpha: 0.26),
              secondary.withValues(alpha: 0.12),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: center, radius: size.width * 0.53),
          );
    canvas.drawCircle(center, size.width * 0.53, halo);

    for (int i = 0; i < 14; i++) {
      final double t = (progress * 0.62 + i * 0.071) % 1;
      final double angle = phase * 1.6 + i * 1.38;
      final double radius = size.width * (0.08 + t * 0.22);
      final double y = center.dy + bodyHeight * (0.28 - t * 0.58);
      final Offset point = Offset(
        center.dx + math.cos(angle) * radius,
        y + math.sin(angle * 1.7) * 9,
      );
      final double scale = 0.45 + t * 0.55;
      final Color color = i.isEven
          ? const Color(0xffbaff3d)
          : const Color(0xfffff06a);
      _drawLeaf(canvas, point, scale, angle, color.withValues(alpha: 0.62));
    }

    final Paint ground = Paint()
      ..color = primary.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx, size.height * 0.86),
        width: size.width * (0.2 + math.sin(phase) * 0.02),
        height: 22,
      ),
      ground,
    );
  }

  void _drawLeaf(
    Canvas canvas,
    Offset center,
    double scale,
    double angle,
    Color color,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final Path leaf = Path()
      ..moveTo(-8 * scale, 0)
      ..quadraticBezierTo(0, -6 * scale, 9 * scale, 0)
      ..quadraticBezierTo(0, 6 * scale, -8 * scale, 0);
    canvas.drawPath(
      leaf,
      Paint()
        ..color = color.withValues(alpha: 0.52)
        ..style = PaintingStyle.fill,
    );
    canvas.drawLine(
      Offset(-6 * scale, 0),
      Offset(7 * scale, 0),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.34)
        ..strokeWidth = math.max(0.8, scale),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(HomeSwirlPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.skin != skin;
  }
}

class ResultCelebrationPainter extends CustomPainter {
  ResultCelebrationPainter({
    required this.progress,
    required this.ambient,
    required this.success,
    required this.stars,
  });

  final double progress;
  final double ambient;
  final bool success;
  final int stars;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Color top = success
        ? const Color(0xff073c55)
        : const Color(0xff33204c);
    final Color bottom = success
        ? const Color(0xff021a21)
        : const Color(0xff100f20);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[top, const Color(0xff053124), bottom],
        ).createShader(rect),
    );

    final Offset burstCenter = Offset(size.width / 2, size.height * 0.19);
    final Paint spotlight = Paint()
      ..shader =
          RadialGradient(
            colors: <Color>[
              (success ? const Color(0xffdfff4e) : const Color(0xffffc64f))
                  .withValues(alpha: 0.28 + progress * 0.18),
              const Color(0xff1ddc8c).withValues(alpha: 0.1),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: burstCenter, radius: size.width * 0.64),
          );
    canvas.drawCircle(burstCenter, size.width * 0.64, spotlight);

    _paintRays(canvas, size, burstCenter);
    _paintSwirl(canvas, size);
    _paintConfetti(canvas, size);
    _paintCitySilhouette(canvas, size);
  }

  void _paintRays(Canvas canvas, Size size, Offset center) {
    final double rayProgress = Curves.easeOutCubic.transform(progress);
    final Paint paint = Paint()
      ..color = (success ? const Color(0xffffe048) : const Color(0xffff6a4e))
          .withValues(alpha: 0.09 * rayProgress)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 18; i++) {
      final double angle = ambient * math.pi * 2 + i * math.pi / 9;
      final Offset p1 =
          center +
          Offset(math.cos(angle - 0.055), math.sin(angle - 0.055)) * 24;
      final Offset p2 =
          center + Offset(math.cos(angle), math.sin(angle)) * size.longestSide;
      final Offset p3 =
          center +
          Offset(math.cos(angle + 0.055), math.sin(angle + 0.055)) * 24;
      canvas.drawPath(
        Path()
          ..moveTo(p1.dx, p1.dy)
          ..lineTo(p2.dx, p2.dy)
          ..lineTo(p3.dx, p3.dy)
          ..close(),
        paint,
      );
    }
  }

  void _paintSwirl(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height * 0.43);
    final double phase = ambient * math.pi * 2;
    final Color color = success
        ? const Color(0xff91ff36)
        : const Color(0xffff9b3d);
    for (int i = 0; i < 8; i++) {
      final double t = i / 7;
      final Rect ring = Rect.fromCenter(
        center: Offset(
          center.dx + math.sin(phase + i * 0.7) * 7,
          center.dy + size.height * (0.13 - t * 0.2),
        ),
        width: size.width * (0.18 + t * 0.48),
        height: 18 + t * 12,
      );
      canvas.drawArc(
        ring,
        phase * 1.4 + i * 0.72,
        math.pi * 0.95,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 2.8 + t * 1.4
          ..color = color.withValues(alpha: (0.08 + t * 0.08) * progress)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
      );
    }
  }

  void _paintConfetti(Canvas canvas, Size size) {
    final List<Color> colors = success
        ? const <Color>[
            Color(0xffffdf38),
            Color(0xff41e96f),
            Color(0xff27c8ff),
            Color(0xffff5252),
            Color(0xffb25cff),
          ]
        : const <Color>[
            Color(0xffff9048),
            Color(0xffffd74f),
            Color(0xffa98cff),
          ];
    final int count = success ? 44 : 18;
    for (int i = 0; i < count; i++) {
      final double seed = (i * 37.19) % 97;
      final double drift = math.sin(ambient * math.pi * 2 + i) * 18;
      final double x = ((seed / 97) * size.width + drift) % size.width;
      final double fall = (progress * (0.75 + (i % 5) * 0.08) + i * 0.047) % 1;
      final double y = fall * size.height * 0.72 + size.height * 0.08;
      final double opacity = (progress * 1.4).clamp(0, 1).toDouble();
      final Paint paint = Paint()
        ..color = colors[i % colors.length].withValues(
          alpha: opacity * (success ? 0.9 : 0.55),
        );
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(ambient * math.pi * 4 + i);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: 6 + (i % 3) * 3,
            height: 11 + (i % 2) * 5,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  void _paintCitySilhouette(Canvas canvas, Size size) {
    final Paint hill = Paint()
      ..color = const Color(0xff06260f).withValues(alpha: 0.88);
    final Path path = Path()..moveTo(0, size.height * 0.86);
    for (int i = 0; i <= 8; i++) {
      final double x = size.width * i / 8;
      final double y =
          size.height * (0.83 + math.sin(i * 1.7 + ambient * 2) * 0.018);
      path.lineTo(x, y);
    }
    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, hill);

    final Paint building = Paint()
      ..color = const Color(0xff02111d).withValues(alpha: 0.92);
    for (int i = 0; i < 9; i++) {
      final double w = 22 + (i % 3) * 9;
      final double h = 34 + (i % 4) * 13;
      final double x = i * size.width / 8 - w / 2;
      final Rect buildingRect = Rect.fromLTWH(x, size.height * 0.84 - h, w, h);
      canvas.drawRect(buildingRect, building);
      for (int window = 0; window < 3; window++) {
        canvas.drawRect(
          Rect.fromLTWH(x + 5 + window * 7, buildingRect.top + 8, 3, 5),
          Paint()
            ..color = const Color(
              0xffffdb60,
            ).withValues(alpha: success ? 0.42 : 0.18),
        );
      }
    }
  }

  @override
  bool shouldRepaint(ResultCelebrationPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.ambient != ambient ||
        oldDelegate.success != success ||
        oldDelegate.stars != stars;
  }
}

class StarGlowPainter extends CustomPainter {
  StarGlowPainter({required this.progress, required this.earnedStars});

  final double progress;
  final int earnedStars;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height * 0.56);
    final double glow = Curves.easeOutCubic.transform(progress);
    final Paint ring = Paint()
      ..color =
          (earnedStars > 0 ? const Color(0xffffe448) : const Color(0xffff8d45))
              .withValues(alpha: 0.14 * glow)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    for (int i = 0; i < 3; i++) {
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: size.width * (0.58 + i * 0.14) * glow,
          height: size.height * (0.55 + i * 0.1) * glow,
        ),
        ring,
      );
    }
  }

  @override
  bool shouldRepaint(StarGlowPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.earnedStars != earnedStars;
  }
}

class ArcadeButton extends StatelessWidget {
  const ArcadeButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color = const Color(0xff62c90c),
    this.foreground = Colors.white,
    this.compact = false,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;
  final Color foreground;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null;
    final double height = compact ? 52 : 66;
    final double radius = compact ? 10 : 12;
    final Color topColor = disabled
        ? Colors.white24
        : Color.lerp(color, Colors.white, 0.28)!;
    final Color midColor = disabled ? Colors.white12 : color;
    final Color bottomColor = disabled
        ? Colors.white10
        : Color.lerp(color, Colors.black, 0.18)!;
    final Color lipColor = disabled
        ? Colors.black26
        : Color.lerp(color, Colors.black, 0.32)!;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const <double>[0, 0.48, 1],
                colors: <Color>[topColor, midColor, bottomColor],
              ),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: disabled
                    ? Colors.white24
                    : Colors.white.withValues(alpha: 0.78),
                width: 1.6,
              ),
              boxShadow: disabled
                  ? null
                  : <BoxShadow>[
                      BoxShadow(
                        color: color.withValues(alpha: 0.32),
                        blurRadius: 14,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.42),
                        blurRadius: 10,
                        offset: const Offset(0, 7),
                      ),
                    ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius - 1),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 6,
                    right: 6,
                    top: 4,
                    height: height * 0.36,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.white.withValues(alpha: 0.42),
                            Colors.white.withValues(alpha: 0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: compact ? 8 : 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: lipColor),
                    ),
                  ),
                  Positioned(
                    left: compact ? 10 : 18,
                    top: compact ? 9 : 10,
                    child: Container(
                      width: compact ? 32 : 44,
                      height: compact ? 32 : 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: foreground.withValues(
                          alpha: foreground == Colors.white ? 0.18 : 0.1,
                        ),
                        border: Border.all(
                          color: foreground.withValues(alpha: 0.38),
                          width: 1.2,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.16),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        icon,
                        size: compact ? 22 : 28,
                        color: foreground,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: compact ? 50 : 74,
                        right: compact ? 12 : 28,
                        bottom: compact ? 4 : 6,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          label.toUpperCase(),
                          maxLines: 1,
                          style: TextStyle(
                            color: foreground,
                            fontSize: compact ? 16 : 27,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0,
                            shadows: <Shadow>[
                              Shadow(
                                color: foreground == Colors.white
                                    ? Colors.black.withValues(alpha: 0.58)
                                    : Colors.white.withValues(alpha: 0.34),
                                blurRadius: foreground == Colors.white ? 2 : 0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TornadoAvatar extends StatelessWidget {
  const TornadoAvatar({
    required this.skin,
    required this.size,
    required this.spin,
    super.key,
  });

  final TornadoSkin skin;
  final double size;
  final double spin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: size * 0.68,
            height: size * 0.68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: skin.colors.first.withValues(alpha: 0.42),
                  blurRadius: size * 0.18,
                  spreadRadius: size * 0.02,
                ),
                BoxShadow(
                  color: skin.colors.last.withValues(alpha: 0.28),
                  blurRadius: size * 0.28,
                  spreadRadius: size * 0.03,
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, math.sin(spin) * size * 0.025),
            child: Image.asset(
              skin.asset,
              width: size,
              height: size,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      ),
    );
  }
}

class TornadoPainter extends CustomPainter {
  TornadoPainter({required this.skin, required this.spin});

  final TornadoSkin skin;
  final double spin;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height * 0.52);
    final double scale = size.shortestSide / 150;
    final Paint shadow = Paint()
      ..color = Colors.black.withValues(alpha: 0.28)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx, size.height * 0.86),
        width: 84 * scale,
        height: 22 * scale,
      ),
      shadow,
    );

    for (int i = 0; i < 6; i++) {
      final double t = i / 5;
      final double width = (100 - i * 12) * scale;
      final double height = (24 - i * 1.8) * scale;
      final double y = size.height * (0.18 + t * 0.56);
      final double wobble = math.sin(spin * 1.8 + i) * 7 * scale;
      final Rect rect = Rect.fromCenter(
        center: Offset(center.dx + wobble, y),
        width: width,
        height: height,
      );
      final Paint paint = Paint()
        ..shader = LinearGradient(
          colors: <Color>[
            skin.colors[i % skin.colors.length].withValues(alpha: 0.96),
            skin.colors[(i + 1) % skin.colors.length].withValues(alpha: 0.72),
          ],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (12 - i) * scale
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, spin + i * 0.5, math.pi * 1.45, false, paint);
    }

    final Path body = Path()
      ..moveTo(center.dx - 46 * scale, size.height * 0.28)
      ..cubicTo(
        center.dx - 34 * scale,
        size.height * 0.7,
        center.dx - 16 * scale,
        size.height * 0.86,
        center.dx,
        size.height * 0.95,
      )
      ..cubicTo(
        center.dx + 18 * scale,
        size.height * 0.82,
        center.dx + 36 * scale,
        size.height * 0.64,
        center.dx + 46 * scale,
        size.height * 0.28,
      )
      ..close();
    final Paint bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: skin.colors,
      ).createShader(Offset.zero & size);
    canvas.drawPath(body, bodyPaint);

    final Paint line = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5 * scale
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final double y = size.height * (0.32 + i * 0.11);
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(center.dx, y),
          width: (80 - i * 9) * scale,
          height: 18 * scale,
        ),
        spin + i,
        math.pi,
        false,
        line,
      );
    }

    final Paint eye = Paint()..color = const Color(0xff052410);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx - 18 * scale, size.height * 0.44),
        width: 14 * scale,
        height: 18 * scale,
      ),
      eye,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx + 18 * scale, size.height * 0.44),
        width: 14 * scale,
        height: 18 * scale,
      ),
      eye,
    );
    final Paint shine = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(center.dx - 21 * scale, size.height * 0.4),
      3 * scale,
      shine,
    );
    canvas.drawCircle(
      Offset(center.dx + 15 * scale, size.height * 0.4),
      3 * scale,
      shine,
    );
    final Paint smile = Paint()
      ..color = const Color(0xff052410)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * scale
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(center.dx, size.height * 0.52),
        width: 34 * scale,
        height: 20 * scale,
      ),
      0.15,
      math.pi - 0.3,
      false,
      smile,
    );

    final IconData badge = skin.icon;
    final TextPainter painter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(badge.codePoint),
        style: TextStyle(
          fontFamily: badge.fontFamily,
          package: badge.fontPackage,
          color: Colors.white.withValues(alpha: 0.9),
          fontSize: 22 * scale,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      Offset(center.dx - painter.width / 2, size.height * 0.62),
    );
  }

  @override
  bool shouldRepaint(TornadoPainter oldDelegate) {
    return oldDelegate.skin != skin || oldDelegate.spin != spin;
  }
}

class GameplayEffectsPainter extends CustomPainter {
  GameplayEffectsPainter({
    required this.items,
    required this.binRects,
    required this.activeBin,
    required this.hoverBin,
    required this.successBin,
    required this.successPulse,
    required this.hazardWarning,
    required this.time,
  });

  final List<WasteItem> items;
  final Map<BinType, Rect> binRects;
  final BinType? activeBin;
  final BinType? hoverBin;
  final BinType? successBin;
  final double successPulse;
  final bool hazardWarning;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    _paintItemTrails(canvas);
    _paintBinField(canvas, activeBin, const Color(0xffbaff3d), 0.38);
    _paintBinField(canvas, hoverBin, const Color(0xffffffff), 0.5);
    _paintBinField(canvas, successBin, const Color(0xffffd33d), successPulse);
    if (hazardWarning) {
      _paintBinField(
        canvas,
        BinType.hazard,
        const Color(0xffff3b4f),
        0.34 + math.sin(time * 6) * 0.12,
      );
    }
    _paintRecycleMagnet(canvas);
    _paintToxicWarnings(canvas);
  }

  void _paintItemTrails(Canvas canvas) {
    for (final WasteItem item in items) {
      if (item.trail.length < 2) {
        continue;
      }
      final Path path = Path()
        ..moveTo(item.trail.first.dx, item.trail.first.dy);
      for (int i = 1; i < item.trail.length; i++) {
        path.lineTo(item.trail[i].dx, item.trail[i].dy);
      }
      final Paint glow = Paint()
        ..color = (item.held ? Colors.white : item.type.color).withValues(
          alpha: item.held ? 0.46 : 0.24,
        )
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = item.held ? 8 : 4
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);
      canvas.drawPath(path, glow);
      final Paint line = Paint()
        ..color = (item.held ? const Color(0xfffff3a5) : item.type.color)
            .withValues(alpha: item.held ? 0.9 : 0.42)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = item.held ? 3.2 : 1.8;
      canvas.drawPath(path, line);

      if (item.held) {
        for (int i = 0; i < item.trail.length; i++) {
          final double t = i / math.max(1, item.trail.length - 1);
          canvas.drawCircle(
            item.trail[i],
            3 + 5 * t,
            Paint()
              ..color = const Color(
                0xffffdf4f,
              ).withValues(alpha: 0.1 + t * 0.22)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
          );
        }
      }
    }
  }

  void _paintBinField(
    Canvas canvas,
    BinType? bin,
    Color color,
    double strength,
  ) {
    if (bin == null || strength <= 0 || !binRects.containsKey(bin)) {
      return;
    }
    final Rect rect = binRects[bin]!;
    final Offset center = Offset(rect.center.dx, rect.top + rect.height * 0.38);
    final double pulse = 0.76 + math.sin(time * 8) * 0.1;
    final Paint glow = Paint()
      ..color = color.withValues(alpha: strength.clamp(0, 0.55) * pulse)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.inflate(8 + strength * 10),
        const Radius.circular(16),
      ),
      glow,
    );

    final Paint suction = Paint()
      ..color = color.withValues(alpha: strength.clamp(0, 0.65))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6;
    for (int i = 0; i < 7; i++) {
      final double phase = (time * 2.8 + i / 7) % 1;
      final double y = rect.top - 72 * (1 - phase);
      final double x =
          center.dx + math.sin(time * 4 + i * 1.7) * (10 + i * 2.2);
      canvas.drawLine(
        Offset(x, y - 14),
        Offset(center.dx, rect.top + 8),
        suction,
      );
      canvas.drawCircle(
        Offset(x, y),
        2.2 + phase * 2,
        Paint()..color = color.withValues(alpha: strength * (1 - phase) * 0.7),
      );
    }
  }

  void _paintRecycleMagnet(Canvas canvas) {
    if (activeBin != BinType.recycle ||
        !binRects.containsKey(BinType.recycle)) {
      return;
    }
    WasteItem? recyclable;
    for (final WasteItem item in items) {
      if (item.kind == DropKind.waste &&
          item.held &&
          item.type.bin == BinType.recycle) {
        recyclable = item;
        break;
      }
    }
    if (recyclable == null) {
      return;
    }
    final Rect recycleRect = binRects[BinType.recycle]!;
    final Offset start = Offset(recycleRect.center.dx, recycleRect.top + 18);
    final Offset end = recyclable.position;
    final Paint beam = Paint()
      ..color = const Color(0xff57d4ff).withValues(alpha: 0.38)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawLine(start, end, beam);
    canvas.drawLine(
      start,
      end,
      Paint()
        ..color = const Color(0xffdbfbff).withValues(alpha: 0.62)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.8,
    );
  }

  void _paintToxicWarnings(Canvas canvas) {
    for (final WasteItem item in items) {
      if (item.kind != DropKind.waste || item.type != WasteType.toxic) {
        continue;
      }
      final double pulse = 0.5 + math.sin(time * 8 + item.id) * 0.18;
      final Paint ring = Paint()
        ..color = const Color(0xffff3b4f).withValues(alpha: pulse)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(item.position, item.size * 0.68, ring);
    }
  }

  @override
  bool shouldRepaint(GameplayEffectsPainter oldDelegate) {
    return oldDelegate.items != items ||
        oldDelegate.binRects != binRects ||
        oldDelegate.activeBin != activeBin ||
        oldDelegate.hoverBin != hoverBin ||
        oldDelegate.successBin != successBin ||
        oldDelegate.successPulse != successPulse ||
        oldDelegate.hazardWarning != hazardWarning ||
        oldDelegate.time != time;
  }
}

class TutorialGuidePainter extends CustomPainter {
  TutorialGuidePainter({
    required this.item,
    required this.target,
    required this.progress,
  });

  final WasteItem? item;
  final Offset? target;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final WasteItem? current = item;
    if (current == null) {
      return;
    }
    if (current.type == WasteType.toxic) {
      final double pulse = 0.5 + math.sin(progress * math.pi * 2) * 0.5;
      final Paint danger = Paint()
        ..color = const Color(0xffff3b4f).withValues(alpha: 0.26 + pulse * 0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4 + pulse * 3;
      canvas.drawCircle(
        current.position,
        current.size * (0.9 + pulse * 0.12),
        danger,
      );
      final Paint slash = Paint()
        ..color = Colors.white.withValues(alpha: 0.82)
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;
      final double r = current.size * 0.62;
      canvas.drawLine(
        current.position + Offset(-r * 0.6, r * 0.6),
        current.position + Offset(r * 0.6, -r * 0.6),
        slash,
      );
      return;
    }

    final Offset? binTarget = target;
    if (binTarget == null || current.held) {
      return;
    }
    final Offset start = current.position + Offset(0, current.size * 0.56);
    final Offset end = binTarget + const Offset(0, -34);
    final Offset control = Offset(
      (start.dx + end.dx) / 2,
      math.min(start.dy, end.dy) - size.height * 0.1,
    );
    final Path path = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
    final Paint glow = Paint()
      ..color = current.type.color.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round;
    final Paint line = Paint()
      ..color = Colors.white.withValues(alpha: 0.86)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.4
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, glow);
    canvas.drawPath(path, line);

    for (int i = 0; i < 5; i++) {
      final double t = (progress + i * 0.2) % 1;
      final Offset p = _quadraticPoint(start, control, end, t);
      final Paint dot = Paint()
        ..color = current.type.color.withValues(alpha: 1 - t * 0.42);
      canvas.drawCircle(p, 4.5 - t * 1.5, dot);
    }

    final double arrowAngle = math.atan2(
      end.dy - control.dy,
      end.dx - control.dx,
    );
    final Path arrow = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(
        end.dx - math.cos(arrowAngle - 0.55) * 18,
        end.dy - math.sin(arrowAngle - 0.55) * 18,
      )
      ..lineTo(
        end.dx - math.cos(arrowAngle + 0.55) * 18,
        end.dy - math.sin(arrowAngle + 0.55) * 18,
      )
      ..close();
    canvas.drawPath(arrow, Paint()..color = current.type.color);
  }

  Offset _quadraticPoint(Offset a, Offset b, Offset c, double t) {
    final double mt = 1 - t;
    return Offset(
      mt * mt * a.dx + 2 * mt * t * b.dx + t * t * c.dx,
      mt * mt * a.dy + 2 * mt * t * b.dy + t * t * c.dy,
    );
  }

  @override
  bool shouldRepaint(TutorialGuidePainter oldDelegate) {
    return oldDelegate.item != item ||
        oldDelegate.target != target ||
        oldDelegate.progress != progress;
  }
}

class WasteToken extends StatelessWidget {
  const WasteToken({required this.item, super.key});

  final WasteItem item;

  @override
  Widget build(BuildContext context) {
    final double tokenSize = item.size * 1.2;
    final bool powerUp = item.kind == DropKind.ecoBlast;
    return Transform.rotate(
      angle: powerUp ? math.sin(item.spin) * 0.12 : item.spin,
      child: SizedBox(
        width: tokenSize,
        height: tokenSize,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: tokenSize * 0.13,
              child: Container(
                width: tokenSize * 0.52,
                height: tokenSize * 0.16,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.28),
                  borderRadius: BorderRadius.circular(tokenSize),
                ),
              ),
            ),
            if (item.held)
              Container(
                width: tokenSize * 0.86,
                height: tokenSize * 0.86,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color:
                          (powerUp ? const Color(0xffbaff3d) : item.type.color)
                              .withValues(alpha: 0.65),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
            if (powerUp)
              EcoBlastToken(size: tokenSize, spin: item.spin)
            else
              Image.asset(
                item.asset,
                width: tokenSize,
                height: tokenSize,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
          ],
        ),
      ),
    );
  }
}

class EcoBlastToken extends StatelessWidget {
  const EcoBlastToken({required this.size, required this.spin, super.key});

  final double size;
  final double spin;

  @override
  Widget build(BuildContext context) {
    final double pulse = 0.5 + math.sin(spin * 1.4) * 0.5;
    return Container(
      width: size * 0.86,
      height: size * 0.86,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: <Color>[
            Color(0xffffffff),
            Color(0xfff7ff55),
            Color(0xff31e46b),
            Color(0xff087c4d),
          ],
          stops: <double>[0.0, 0.34, 0.72, 1],
        ),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xffbaff3d).withValues(alpha: 0.5 + pulse * 0.3),
            blurRadius: 22,
            spreadRadius: 4,
          ),
          const BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(painter: EcoBlastPainter(progress: spin)),
          ),
          Icon(
            Icons.recycling_rounded,
            color: const Color(0xff06452e),
            size: size * 0.38,
          ),
          Positioned(
            right: size * 0.11,
            top: size * 0.12,
            child: Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white.withValues(alpha: 0.92),
              size: size * 0.22,
            ),
          ),
        ],
      ),
    );
  }
}

class EcoBlastPainter extends CustomPainter {
  EcoBlastPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Paint ring = Paint()
      ..color = Colors.white.withValues(alpha: 0.78)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 3; i++) {
      final double phase = progress * 0.9 + i * 2.1;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: size.width * (0.62 + i * 0.08),
        height: size.height * (0.23 + i * 0.04),
      );
      canvas.drawArc(rect, phase, math.pi * 1.16, false, ring);
    }
  }

  @override
  bool shouldRepaint(EcoBlastPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class BinDock extends StatelessWidget {
  const BinDock({
    required this.rects,
    required this.activeBin,
    required this.hoverBin,
    required this.successBin,
    required this.successPulse,
    required this.hazardWarning,
    required this.time,
    this.bottomInset = 0,
    super.key,
  });

  final Map<BinType, Rect> rects;
  final BinType? activeBin;
  final BinType? hoverBin;
  final BinType? successBin;
  final double successPulse;
  final bool hazardWarning;
  final double time;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final List<BinType> types = const <BinType>[
      BinType.organic,
      BinType.recycle,
      BinType.paper,
      BinType.hazard,
    ];
    final double safeBottom = bottomInset.clamp(0, 96).toDouble();
    return Container(
      height: 148 + safeBottom,
      padding: EdgeInsets.fromLTRB(5, 8, 5, 36 + safeBottom),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xff08294b), Color(0xff050d18)],
        ),
        border: Border(top: BorderSide(color: Color(0xff5a91ca), width: 1.2)),
      ),
      child: Row(
        children: <Widget>[
          for (final BinType type in types)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: RecycleBin(
                  type: type,
                  active: activeBin == type,
                  hovering: hoverBin == type,
                  success: successBin == type && successPulse > 0,
                  warning: type == BinType.hazard && hazardWarning,
                  time: time,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class BinParticlePainter extends CustomPainter {
  BinParticlePainter({
    required this.color,
    required this.time,
    required this.strong,
  });

  final Color color;
  final double time;
  final bool strong;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset target = Offset(size.width / 2, size.height * 0.34);
    for (int i = 0; i < 8; i++) {
      final double phase = (time * 2.7 + i * 0.13) % 1;
      final double spread = strong ? 26 : 18;
      final Offset start = Offset(
        size.width / 2 + math.sin(i * 1.4 + time * 3) * spread,
        size.height * (0.95 - phase * 0.72),
      );
      final Paint paint = Paint()
        ..color = color.withValues(alpha: (1 - phase) * (strong ? 0.5 : 0.32))
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strong ? 1.9 : 1.3;
      canvas.drawLine(start, target, paint);
      canvas.drawCircle(start, strong ? 2.4 : 1.8, paint);
    }
  }

  @override
  bool shouldRepaint(BinParticlePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.time != time ||
        oldDelegate.strong != strong;
  }
}

class RecycleBin extends StatelessWidget {
  const RecycleBin({
    required this.type,
    required this.active,
    required this.hovering,
    required this.success,
    required this.warning,
    required this.time,
    super.key,
  });

  final BinType type;
  final bool active;
  final bool hovering;
  final bool success;
  final bool warning;
  final double time;

  @override
  Widget build(BuildContext context) {
    final bool reactive = active || hovering || success || warning;
    final Color glowColor = warning
        ? const Color(0xffff3b4f)
        : success
        ? const Color(0xffffd33d)
        : hovering
        ? Colors.white
        : const Color(0xffbaff3d);
    final double bounce = reactive ? math.sin(time * 9) * 2.2 : 0;
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: reactive ? 1.04 : 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              type.color.withValues(alpha: 0.95),
              type.color.withValues(alpha: 0.55),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: reactive ? glowColor : Colors.white.withValues(alpha: 0.55),
            width: reactive ? 2.2 : 1.5,
          ),
          boxShadow: <BoxShadow>[
            const BoxShadow(
              color: Colors.black38,
              blurRadius: 8,
              offset: Offset(0, 5),
            ),
            if (reactive)
              BoxShadow(
                color: glowColor.withValues(alpha: 0.65),
                blurRadius: 18,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            if (reactive)
              Positioned(
                top: 6,
                left: 12,
                right: 12,
                child: Transform.translate(
                  offset: Offset(0, hovering || success ? -9 : -5),
                  child: Container(
                    height: 9,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.42),
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        color: glowColor.withValues(alpha: 0.9),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            if (active || hovering || success)
              Positioned.fill(
                child: CustomPaint(
                  painter: BinParticlePainter(
                    color: glowColor,
                    time: time,
                    strong: hovering || success,
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(0, bounce),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: reactive ? 56 : 50,
                    height: reactive ? 52 : 48,
                    child: Image.asset(
                      type.asset,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      type.label.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (success)
              Positioned(
                top: -18,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xffd8ff4d), Color(0xff37d85f)],
                    ),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Color(0xff06340f),
                    size: 24,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CityBackdropPainter extends CustomPainter {
  CityBackdropPainter({required this.map, required this.time});

  final CityMap map;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint sky = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          map.colors[2].withValues(alpha: 0.95),
          const Color(0xff2586d4),
          const Color(0xff1f7b52),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, sky);

    final Paint glow = Paint()
      ..shader =
          RadialGradient(
            colors: <Color>[
              const Color(0xffbffcff).withValues(alpha: 0.35),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.48, size.height * 0.47),
              radius: size.width * 0.55,
            ),
          );
    canvas.drawCircle(
      Offset(size.width * 0.48, size.height * 0.47),
      size.width * 0.55,
      glow,
    );

    final Paint cloud = Paint()..color = Colors.white.withValues(alpha: 0.82);
    for (int i = 0; i < 5; i++) {
      final double x =
          (size.width * (0.1 + i * 0.23) + time * (8 + i)) % (size.width + 90) -
          45;
      final double y = size.height * (0.1 + (i % 3) * 0.08);
      canvas.drawCircle(Offset(x, y), 18, cloud);
      canvas.drawCircle(Offset(x + 20, y + 3), 14, cloud);
      canvas.drawCircle(Offset(x - 18, y + 4), 12, cloud);
    }

    final Paint buildingSide = Paint()..color = const Color(0xff9c6038);
    final Paint buildingBlue = Paint()..color = const Color(0xff235b92);
    final Paint window = Paint()
      ..color = const Color(0xffffe787).withValues(alpha: 0.56);
    for (int i = 0; i < 9; i++) {
      final bool left = i.isEven;
      final double w = 34 + (i % 3) * 12;
      final double h = size.height * (0.25 + (i % 4) * 0.045);
      final double x = left
          ? -14 + (i ~/ 2) * 34
          : size.width - ((i ~/ 2) + 1) * 42;
      final double y = size.height * 0.54 - h;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, w, h),
          const Radius.circular(5),
        ),
        left ? buildingSide : buildingBlue,
      );
      for (double wy = y + 14; wy < y + h - 10; wy += 22) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x + 8, wy, 6, 9),
            const Radius.circular(2),
          ),
          window,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x + w - 15, wy, 6, 9),
            const Radius.circular(2),
          ),
          window,
        );
      }
    }

    final Paint hill = Paint()..color = map.colors[1].withValues(alpha: 0.72);
    final Path hills = Path()
      ..moveTo(0, size.height * 0.62)
      ..quadraticBezierTo(
        size.width * 0.2,
        size.height * 0.48,
        size.width * 0.43,
        size.height * 0.61,
      )
      ..quadraticBezierTo(
        size.width * 0.72,
        size.height * 0.75,
        size.width,
        size.height * 0.55,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(hills, hill);

    final Paint road = Paint()
      ..color = const Color(0xff263646).withValues(alpha: 0.82);
    final Path roadPath = Path()
      ..moveTo(size.width * 0.1, size.height)
      ..lineTo(size.width * 0.36, size.height * 0.58)
      ..quadraticBezierTo(
        size.width * 0.49,
        size.height * 0.48,
        size.width * 0.63,
        size.height * 0.58,
      )
      ..lineTo(size.width * 0.92, size.height)
      ..close();
    canvas.drawPath(roadPath, road);

    final Paint stripe = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.37, size.height * 0.62),
      Offset(size.width * 0.19, size.height),
      stripe,
    );
    canvas.drawLine(
      Offset(size.width * 0.62, size.height * 0.62),
      Offset(size.width * 0.82, size.height),
      stripe,
    );

    final Paint dash = Paint()
      ..color = const Color(0xffffe35a)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 6; i++) {
      final double y = size.height * (0.65 + i * 0.055);
      canvas.drawLine(
        Offset(size.width * 0.5, y),
        Offset(size.width * 0.51, y + 20),
        dash,
      );
    }
  }

  @override
  bool shouldRepaint(CityBackdropPainter oldDelegate) {
    return oldDelegate.map != map || oldDelegate.time != time;
  }
}

class WindTrailPainter extends CustomPainter {
  WindTrailPainter({required this.color, required this.progress});

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 9; i++) {
      final double y = size.height * ((progress + i / 9) % 1);
      final double startX =
          math.sin(progress * math.pi * 2 + i) * 40 + size.width * 0.5;
      final Path path = Path()
        ..moveTo(startX - 140, y)
        ..quadraticBezierTo(startX, y - 40, startX + 145, y + 16);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(WindTrailPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.progress != progress;
  }
}

class WorldMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint sea = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xff1d9dda),
          Color(0xff0b6ba7),
          Color(0xff06375d),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, sea);

    final Paint island = Paint()..color = const Color(0xff58b84f);
    final Paint sand = Paint()..color = const Color(0xffffd074);
    for (final Offset center in <Offset>[
      Offset(size.width * 0.28, size.height * 0.18),
      Offset(size.width * 0.68, size.height * 0.38),
      Offset(size.width * 0.36, size.height * 0.58),
      Offset(size.width * 0.72, size.height * 0.78),
    ]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: size.width * 0.52,
          height: size.height * 0.2,
        ),
        sand,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: size.width * 0.45,
          height: size.height * 0.16,
        ),
        island,
      );
    }

    final Path road = Path()
      ..moveTo(size.width * 0.26, size.height * 0.16)
      ..cubicTo(
        size.width * 0.72,
        size.height * 0.2,
        size.width * 0.72,
        size.height * 0.36,
        size.width * 0.58,
        size.height * 0.36,
      )
      ..cubicTo(
        size.width * 0.12,
        size.height * 0.42,
        size.width * 0.22,
        size.height * 0.56,
        size.width * 0.3,
        size.height * 0.57,
      )
      ..cubicTo(
        size.width * 0.84,
        size.height * 0.63,
        size.width * 0.76,
        size.height * 0.76,
        size.width * 0.45,
        size.height * 0.84,
      );
    final Paint roadPaint = Paint()
      ..color = const Color(0xff5d5142)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 28
      ..strokeCap = StrokeCap.round;
    final Paint dashPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(road, roadPaint);
    canvas.drawPath(road, dashPaint);

    final Paint wave = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 7; i++) {
      final double x = size.width * (0.1 + (i % 3) * 0.32);
      final double y = size.height * (0.1 + i * 0.12);
      canvas.drawArc(
        Rect.fromLTWH(x, y, 38, 13),
        0.1,
        math.pi * 0.8,
        false,
        wave,
      );
    }
  }

  @override
  bool shouldRepaint(WorldMapPainter oldDelegate) => false;
}

class HomeScenePainter extends CustomPainter {
  HomeScenePainter({required this.colors, required this.skin});

  final List<Color> colors;
  final TornadoSkin skin;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint sky = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xff1296e8),
          Color(0xff72d8fa),
          Color(0xff56b05a),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, sky);

    final Paint sunGlow = Paint()
      ..shader =
          RadialGradient(
            colors: <Color>[
              skin.colors.first.withValues(alpha: 0.5),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.55, size.height * 0.48),
              radius: size.width * 0.55,
            ),
          );
    canvas.drawCircle(
      Offset(size.width * 0.55, size.height * 0.48),
      size.width * 0.55,
      sunGlow,
    );

    final Paint buildingPaint = Paint()..color = const Color(0xff28649c);
    final Paint buildingDark = Paint()..color = const Color(0xff173c64);
    for (int i = 0; i < 7; i++) {
      final double w = 28 + (i % 3) * 9;
      final double h = size.height * (0.22 + (i % 4) * 0.045);
      final double x = i < 4 ? -8 + i * 28 : size.width - (i - 3) * 35 - 20;
      final double y = size.height * 0.5 - h;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, w, h),
          const Radius.circular(5),
        ),
        i.isEven ? buildingPaint : buildingDark,
      );
      final Paint window = Paint()
        ..color = Colors.white.withValues(alpha: 0.32);
      for (double wy = y + 12; wy < y + h - 8; wy += 18) {
        canvas.drawRect(Rect.fromLTWH(x + 7, wy, 5, 7), window);
        canvas.drawRect(Rect.fromLTWH(x + w - 12, wy, 5, 7), window);
      }
    }

    final Paint park = Paint()..color = colors.first.withValues(alpha: 0.82);
    final Path leftHill = Path()
      ..moveTo(0, size.height * 0.58)
      ..quadraticBezierTo(
        size.width * 0.24,
        size.height * 0.48,
        size.width * 0.52,
        size.height * 0.6,
      )
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(leftHill, park);

    final Paint road = Paint()..color = const Color(0xff2f3743);
    final Path roadPath = Path()
      ..moveTo(size.width * 0.2, size.height)
      ..lineTo(size.width * 0.43, size.height * 0.58)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.52,
        size.width * 0.58,
        size.height * 0.58,
      )
      ..lineTo(size.width * 0.87, size.height)
      ..close();
    canvas.drawPath(roadPath, road);

    final Paint roadEdge = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width * 0.43, size.height * 0.6),
      Offset(size.width * 0.25, size.height),
      roadEdge,
    );
    canvas.drawLine(
      Offset(size.width * 0.58, size.height * 0.6),
      Offset(size.width * 0.82, size.height),
      roadEdge,
    );
    final Paint lane = Paint()
      ..color = const Color(0xffffe35d)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 5; i++) {
      final double y = size.height * (0.68 + i * 0.07);
      final double x = size.width * (0.5 + i * 0.015);
      canvas.drawLine(Offset(x, y), Offset(x + 5, y + 24), lane);
    }

    for (int i = 0; i < 6; i++) {
      final double y = size.height * (0.13 + i * 0.08);
      final double width = size.width * (0.42 - i * 0.035);
      final Rect swirlRect = Rect.fromCenter(
        center: Offset(size.width * 0.52, y + size.height * 0.23),
        width: width,
        height: size.height * 0.08,
      );
      final Paint swirl = Paint()
        ..color = skin.colors[i % skin.colors.length].withValues(alpha: 0.34)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(swirlRect, -0.35, math.pi * 1.45, false, swirl);
    }

    final Paint vignette = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          Colors.transparent,
          Colors.black.withValues(alpha: 0.22),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, vignette);
  }

  @override
  bool shouldRepaint(HomeScenePainter oldDelegate) {
    return oldDelegate.colors != colors || oldDelegate.skin != skin;
  }
}

class FloatingTrashPainter extends CustomPainter {
  FloatingTrashPainter({required this.seed, required this.intensity});

  final int seed;
  final int intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> palette = <Color>[
      const Color(0xff30b6ff),
      const Color(0xff35db68),
      const Color(0xffffc234),
      const Color(0xffff554d),
      const Color(0xffd7e3ef),
    ];
    final List<IconData> icons = <IconData>[
      Icons.local_drink_rounded,
      Icons.description_rounded,
      Icons.soup_kitchen_rounded,
      Icons.wine_bar_rounded,
      Icons.restaurant_rounded,
    ];
    for (int i = 0; i < intensity; i++) {
      final double n = (math.sin((seed + i) * 12.9898) * 43758.5453) % 1;
      final double x = size.width * (0.18 + ((i * 37 + seed * 11) % 70) / 100);
      final double y = size.height * (0.15 + ((i * 23 + seed * 7) % 48) / 100);
      final double tokenSize = 18 + (i % 3) * 5;
      final Paint shadow = Paint()
        ..color = Colors.black.withValues(alpha: 0.24)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate((n - 0.5) * math.pi);
      canvas.drawCircle(Offset(2, 3), tokenSize * 0.58, shadow);
      final Paint bg = Paint()..color = palette[i % palette.length];
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: tokenSize,
            height: tokenSize,
          ),
          Radius.circular(tokenSize * 0.28),
        ),
        bg,
      );
      final IconData icon = icons[i % icons.length];
      final TextPainter painter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontFamily: icon.fontFamily,
            package: icon.fontPackage,
            color: Colors.white,
            fontSize: tokenSize * 0.68,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(FloatingTrashPainter oldDelegate) {
    return oldDelegate.seed != seed || oldDelegate.intensity != intensity;
  }
}

class MenuSwirlPainter extends CustomPainter {
  MenuSwirlPainter({required this.colors});

  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height * 0.56);
    final Paint glow = Paint()
      ..shader =
          RadialGradient(
            colors: <Color>[
              colors.first.withValues(alpha: 0.45),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: center, radius: size.width * 0.48),
          );
    canvas.drawCircle(center, size.width * 0.48, glow);

    for (int i = 0; i < 6; i++) {
      final Paint paint = Paint()
        ..color = colors[i % colors.length].withValues(alpha: 0.28)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4 + i.toDouble()
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCenter(
          center: center,
          width: size.width * (0.35 + i * 0.08),
          height: size.height * (0.18 + i * 0.05),
        ),
        i * 0.8,
        math.pi * 1.3,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(MenuSwirlPainter oldDelegate) =>
      oldDelegate.colors != colors;
}
