import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:the_bar_gym/pages/support_staff_pages/nutrionist_expanded_list.dart';
import 'package:the_bar_gym/pages/support_staff_pages/physical_therapist_expanded_list.dart';
import 'package:the_bar_gym/pages/support_staff_pages/trainer_expanded_list.dart';
import 'package:the_bar_gym/screens/machine_video_screens/machine_video_screens.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/screens/test_1.dart';
import '../../theme.dart';

class TrainerTabBarLibrary extends StatefulWidget {
  const TrainerTabBarLibrary({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  State<TrainerTabBarLibrary> createState() => _TrainerTabBarLibraryState();
}

class _TrainerTabBarLibraryState extends State<TrainerTabBarLibrary> {
  List trainerNames = <String>[
    'Name 1',
    'Name 2',
    'Name 3',
    'Name 4',
    'Name 5',
  ];

  List chestPages = <dynamic>[
    FlatBenchPressVideoPage(),
    InclinePressVideoPage(),
    IsoLateralChestPressVideoPage(),
    PeckDeckVideoPage(),
    PowerPressVideoPage(),
  ];
  List backPages = <dynamic>[
    ChestSupportRowPage(),
    IsoLatDYRowPage(),
    IsoLatLowRowPage(),
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
  List nutrionistNames = <String>[
    'Name 1',
    'Name 2',
    'Name 3',
    'Name 4',
    'Name 5',
  ];
  List physicalTherapistsNames = <String>[
    'Name 1',
    'Name 2',
    'Name 3',
    'Name 4',
    'Name 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Container(
            child: TrainersExpadedList()
          ),
          Container(
            child:
            NutrionistExpadedList(),
            // ListView.builder(
            //     itemCount: nutrionistNames.length,
            //     itemBuilder: (BuildContext context, int position) {
            //       return getRowBack(position);
            //     }),
          ),
          PTExpandedList(),
        ],
        controller: widget._tabController,
      ),
    );
  }

  Widget getRowChest(int i) {
    return GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: AppColors.cardDark,
          elevation: 10,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: Icon(
                Icons.accessibility_new,
                size: 70,
                color: Colors.red[900],
              ),
              title: Text(
                trainerNames[i],
                style: TextStyle(letterSpacing: 3.0),
              ),
              subtitle: Text(trainerNames[i]),
            ),
          ]),
        ),
        onTap: () {
          Dialogs.bottomMaterialDialog(
              color: AppColors.cardDark,
              context: context,
              msg: 'Select an Option!',
              title: trainerNames[i],
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return chestPages[i];
                      }),
                    );
                  },
                  text: 'Play Demo',
                  iconData: CupertinoIcons.play,
                  color: AppColors.accent,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
                IconsButton(
                  onPressed: () {},
                  text: 'Log Workout',
                  iconData: CupertinoIcons.square_list,
                  color: AppColors.accent,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
        });
  }

  Widget getRowBack(int i) {
    return GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: AppColors.cardDark,
          elevation: 10,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: Icon(
                Icons.accessibility_new,
                size: 70,
                color: Colors.red[900],
              ),
              title: Text(
                nutrionistNames[i],
                style: TextStyle(letterSpacing: 3.0),
              ),
              subtitle: Text(nutrionistNames[i]),
            ),
          ]),
        ),
        onTap: () {
          Dialogs.bottomMaterialDialog(
              color: AppColors.cardDark,
              context: context,
              msg: 'Select an Option!',
              title: nutrionistNames[i],
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return backPages[i];
                      }),
                    );
                  },
                  text: 'Play Demo',
                  iconData: CupertinoIcons.play,
                  color: AppColors.accent,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
                IconsButton(
                  onPressed: () {},
                  text: 'Log Workout',
                  iconData: CupertinoIcons.square_list,
                  color: AppColors.accent,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
        });
  }

  Widget getRowLegs(int i) {
    return GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: AppColors.cardDark,
          elevation: 10,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: Icon(
                Icons.accessibility_new,
                size: 70,
                color: Colors.red[900],
              ),
              title: Text(
                physicalTherapistsNames[i],
                style: TextStyle(letterSpacing: 3.0),
              ),
              subtitle: Text(physicalTherapistsNames[i]),
            ),
          ]),
        ),
        onTap: () {
          Dialogs.bottomMaterialDialog(
              color: AppColors.cardDark,
              context: context,
              msg: 'Select an Option!',
              title: physicalTherapistsNames[i],
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return legPages[i];
                      }),
                    );
                  },
                  text: 'Play Demo',
                  iconData: CupertinoIcons.play,
                  color: AppColors.accent,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
                IconsButton(
                  onPressed: () {},
                  text: 'Log Workout',
                  iconData: CupertinoIcons.square_list,
                  color: AppColors.accent,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
        });
  }
}
