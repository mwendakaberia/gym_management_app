import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme.dart';





// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    // required this.trainerName,
    required this.fullName,
    required this.trainerPic,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  // String trainerName;
  bool isExpanded;
  String fullName;
  AssetImage trainerPic;
}

List<Item> generateItems(int numberOfItems) {
  List trainerNames = <String>[
    'Derek',
    'Matt',
    'Josh',
    'Name 4',
    'Name 5',
  ];
  List trainerPictures = <AssetImage>[
    const AssetImage('images/Derek_JPG-modified.png'),
    const AssetImage('images/matt_PNG-modified.png'),
    const AssetImage('images/josh-modified.png')
  ];
  return List<Item>.generate(numberOfItems, (int index) {

    return Item(
      trainerPic: trainerPictures[index],
      fullName: trainerNames[index],
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class NutrionistExpadedList extends StatefulWidget {

   NutrionistExpadedList({Key? key, }) : super(key: key);

  @override
  State<NutrionistExpadedList> createState() => _NutrionistExpadedListState();
}

class _NutrionistExpadedListState extends State<NutrionistExpadedList> {
  // List trainerFullNames = <String>[
  //   'Derek',
  //   'Matt',
  //   'Josh',
  //   'Name 4',
  //  'Name 5'
  // ];
  List trainerPictures = <AssetImage>[
    const AssetImage('images/Derek_JPG-modified.png'),
    const AssetImage('images/matt_PNG-modified.png'),
    const AssetImage('images/josh-modified.png')
  ];

  final List<Item> _data = generateItems(3);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(


          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(


              height: 75,
              child: ListTile(
                leading: Container(
                  height: 200,child:  Image(
                  image: item.trainerPic,

                ),),
                title: Text(item.fullName),
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(

              tileColor: AppColors.textDark,
              title:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Contact ${item.fullName}',
                   style: TextStyle(decoration: TextDecoration.underline)
                    ,),
                  Icon(FontAwesomeIcons.instagram,
                    size: 65,),
                  Icon(FontAwesomeIcons.facebook,
                      size: 65),],),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
