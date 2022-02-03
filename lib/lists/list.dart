


import 'package:the_bar_gym/screens/machine_video_screens/chest/flat_bench_press.dart';
import 'package:the_bar_gym/screens/machine_video_screens/chest/incline_press.dart';
import 'package:the_bar_gym/screens/machine_video_screens/chest/iso_lateral_chest_press.dart';
import 'package:the_bar_gym/screens/machine_video_screens/chest/peck_deck.dart';
import 'package:the_bar_gym/screens/machine_video_screens/machine_video_screens.dart';

List chestPages = <dynamic>[
  FlatBenchPressVideoPage(),
  InclinePressVideoPage(),
  IsoLateralChestPressVideoPage(),
  PeckDeckVideoPage(),
  PowerPressVideoPage(),
];
List chestTitles = <String>[
  'Flat Bench Press',
  'Incline Press',
  'Iso Lateral Chest Press',
  'Peck Deck',


  'Power Press',
];
List chestMachineImage = <String>[
  'images/chest/benchpress.jpg',
  'images/chest/inclinepress.png',
  'images/chest/isolateral.png',
  'images/chest/peckdec.jpg',


  'images/chest/logo.png',
];
List backMachineImage = <String>[

  'images/back/chestsupport.jpg',
  'images/back/dy.png',
  'images/back/lowrow.png',


  'images/',
  'images/',
];

List backPages = <dynamic>[
  ChestSupportRowPage(),
  IsoLatDYRowPage(),
  IsoLatLowRowPage(),
];

List backTitles = <String>[
  'Chest Supported Row',
  'Iso Lat DY Row',
  'Iso Lat Low Row',


];
List legPages = <dynamic>[
  BeltSquatVideoPage(),
  CalfMachineVideoPage(),
  GluteatorVideoPage(),
  HackSquatVideoPage(),
  InverseCurlVideoPage(),
  LegExtensionVideoPage(),
  LegPressVideoPage(),
  LyingLegCurlVideoPage(),
  SeatedLegCurlVideoPage(),
  StandingLegCurlVideoPage(),
  SuperSquatVideoPage(),
];
List legsTitles = <String>[
  'Belt Squat',
  'Calf Machine',
  'Gluteator',
  'Hack Squat',
  'Inverse Curl',
  'Leg Extension',
  'Leg Press',
  'Lying Leg Curl',
  'Seated Leg Curl',
  'Standing Leg Curl',
  'Super Squat',
];
List legMachineImage = <String>[
  'images/legs/logo.png',
  'images/legs/standingcalf.jpg',
  'images/legs/gluteator.jpg',
  'images/legs/hax.png',
  'images/legs/logo.png',
  'images/legs/legextension.jpg',
  'images/legs/legpress.png',
  'images/legs/lyingleg.jpg',
  'images/legs/seatedlegcurl.jpg',
  'images/legs/logo.png',
  'images/legs/logo.png',
  'images/legs/',
  'images/legs/',
  'images/legs/',
  'images/legs/',
  'images/legs/',

];