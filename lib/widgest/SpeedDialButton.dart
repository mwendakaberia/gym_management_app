import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:the_bar_gym/pages/log_pages/exercise_list.dart';
import 'package:the_bar_gym/pages/qr_scanner_pagetest.dart';

import '../theme.dart';

class SpeedDialButton extends StatefulWidget {
  const SpeedDialButton({Key? key}) : super(key: key);

  @override
  _SpeedDialButtonState createState() => _SpeedDialButtonState();
}

class _SpeedDialButtonState extends State<SpeedDialButton> {
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: SpeedDial(
        icon: FontAwesomeIcons.angleDoubleUp,
        activeIcon: FontAwesomeIcons.angleDoubleDown,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        dialRoot: customDialRoot
            ? (ctx, open, toggleChildren) {
                return ElevatedButton(
                  onPressed: toggleChildren,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 18),
                  ),
                  child: const Text(
                    "Custom Dial Root",
                    style: TextStyle(fontSize: 17),
                  ),
                );
              }
            : null,
        buttonSize: buttonSize,
        label: extend ? const Text('open') : null,
        activeLabel: extend ? const Text("Close") : null,
        childrenButtonSize: childrenButtonSize,
        visible: visible,
        direction: speedDialDirection,
        switchLabelPosition: switchLabelPosition,

        /// If true user is forced to close dial manually
        closeManually: closeManually,

        /// If false, backgroundOverlay will not be rendered.
        renderOverlay: renderOverlay,
        // overlayColor: Colors.black,
        // overlayOpacity: 0.5,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        useRotationAnimation: useRAnimation,
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        // foregroundColor: Colors.black,
        // backgroundColor: Colors.white,
        // activeForegroundColor: Colors.red,
        // activeBackgroundColor: Colors.blue,
        elevation: 8.0,
        isOpenOnStart: false,
        animationSpeed: 200,
        shape: customDialRoot
            ? const RoundedRectangleBorder()
            : const StadiumBorder(),
        // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          SpeedDialChild(
            child: !rmicons ? const Icon(Icons.qr_code_scanner_sharp) : null,
            backgroundColor: AppColors.cardDark,
            foregroundColor: Colors.white,
            label: 'QR - Strength',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Scanner();
                },
              ),
            ),
            onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: !rmicons ? const Icon(Icons.camera_alt_outlined) : null,
            backgroundColor: AppColors.cardDark,
            foregroundColor: Colors.white,
            label: 'Selfie Library',
            onTap: () => debugPrint('SECOND CHILD'),
          ),
          SpeedDialChild(
            child:
                !rmicons ? const FaIcon(FontAwesomeIcons.clipboardList) : null,
            elevation: 4,
            backgroundColor: AppColors.cardDark,
            foregroundColor: Colors.white,
            label: 'Workout Log',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ExerciseList();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
