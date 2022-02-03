import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:the_bar_gym/lists/list.dart';
import 'package:the_bar_gym/pages/log_pages/exercise_list.dart';
import 'package:the_bar_gym/screens/machine_video_screens/machine_video_screens.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/screens/test_1.dart';
import '../theme.dart';

class TabBarLibrary extends StatefulWidget {
  const TabBarLibrary({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  State<TabBarLibrary> createState() => _TabBarLibraryState();
}

class _TabBarLibraryState extends State<TabBarLibrary> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Container(
            child: ListView.builder(
                itemCount: chestTitles.length,
                itemBuilder: (BuildContext context, int position) {
                  return getRowChest(position);
                }
                // children: [
                //   Wrap(
                //     direction: Axis.horizontal,
                //     alignment: WrapAlignment.center,
                //     spacing: 8.0,
                //     // runAlignment:WrapAlignment.center,
                //     runSpacing: 8.0,
                //     // crossAxisAlignment: WrapCrossAlignment.center,
                //     // textDirection: TextDirection.rtl,
                //     // verticalDirection: VerticalDirection.up,
                //     children: <Widget>[
                //       Container(
                //           color: Colors.blue,
                //           width: MediaQuery.of(context).size.width * 0.25,
                //           height: MediaQuery.of(context).size.width * 0.25,
                //           child: Center(
                //               child: Text(
                //             "W1",
                //             textScaleFactor: 2.5,
                //           ))),
                //     ],
                //   ),
                // ],
                ),
          ),
          Container(
            child: ListView.builder(
                itemCount: backTitles.length,
                itemBuilder: (BuildContext context, int position) {
                  return getRowBack(position);
                }),
          ),
          Container(
            child: ListView.builder(
                itemCount: legsTitles.length,
                itemBuilder: (BuildContext context, int position) {
                  return getRowLegs(position);
                }),
          ),
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

              contentPadding: EdgeInsets.all(4.0),
              leading: Container(clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(

                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      blurStyle: BlurStyle.outer,
                    )],
                    border: Border.all(
                      color: Colors.white12,


                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8),
                    )
                ),
                child: Image.asset(chestMachineImage[i],
                  fit: BoxFit.contain,

                  width: 80,
                  height:80,
                  ),
              ),
              title: Text(
                chestTitles[i],
                style: TextStyle(letterSpacing: 3.0),
              ),
              subtitle: Text(chestTitles[i]),
            ),
          ]),
        ),
        onTap: () {
          Dialogs.bottomMaterialDialog(
              color: AppColors.cardDark,
              context: context,
              msg: 'Select an Option!',
              title: chestTitles[i],
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
                  onPressed: () {  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ExerciseList();
                    }),
                  );},
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
              leading: Container(clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(

                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 12.0,
                      blurStyle: BlurStyle.outer,
                    )],
                    border: Border.all(
                      color: Colors.white12,


                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Image.asset(backMachineImage[i],
                  fit: BoxFit.contain,

                  width: 80,
                  height:80,),
              ),
              title: Text(
                backTitles[i],
                style: TextStyle(letterSpacing: 3.0),
              ),
              subtitle: Text(backTitles[i]),
            ),
          ]),
        ),
        onTap: () {
          Dialogs.bottomMaterialDialog(
              color: AppColors.cardDark,
              context: context,
              msg: 'Select an Option!',
              title: backTitles[i],
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
              leading: Container(clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(

                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 12.0,
                    blurStyle: BlurStyle.outer,
                  )],
                  border: Border.all(
                    color: Colors.white12,


                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Image.asset(legMachineImage[i],
                  fit: BoxFit.contain,

                  width: 80,
                  height:80,),
              ),
              title: Text(
                legsTitles[i],
                style: TextStyle(letterSpacing: 3.0),
              ),
              subtitle: Text(legsTitles[i]),
            ),
          ]),
        ),
        onTap: () {
          Dialogs.bottomMaterialDialog(
              color: AppColors.cardDark,
              context: context,
              msg: 'Select an Option!',
              title: legsTitles[i],
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
