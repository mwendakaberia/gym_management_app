
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_bar_gym/models/data_model.dart';
import 'package:the_bar_gym/models/exercise.dart';
import 'package:the_bar_gym/utils/colors.dart';
import 'package:the_bar_gym/utils/enums.dart';
import 'package:the_bar_gym/utils/helpers.dart';
import 'package:the_bar_gym/utils/textStyles.dart';
import 'package:the_bar_gym/utils/units.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise? exercise;
  final int? index;
  final Function? onTap;

  ExerciseCard({this.exercise, this.index, this.onTap});

  Color getCardOverLayColor(BuildContext context, Color color) {
    return Color.alphaBlend(ElevationOverlay.overlayColor(context, 1), color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Material(
        elevation: 3,
        color: isThemeDark(context)
            ? getCardOverLayColor(context, MyColors.darkGrey)
            : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: onTap as void Function()?,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.80, // 80% width if display
                      child: Text(
                        exercise!.name,
                        // overflow: TextOverflow.ellipsis,
                        style: isThemeDark(context)
                            ? CardTitleStyle.dark
                            : CardTitleStyle.light,
                      ),
                    ),
                    // Ecercise number
                    Text(
                      '#${index! + 1}',
                      style: CardExNumberStyle.light,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      getSetsNumber(), //returns the number of sets
                      style: CardSubTitleStyle.dark.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                //horizontal line break lol
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
                  height: 3.0,
                  decoration: BoxDecoration(
                      color: isThemeDark(context)
                          ? getCardOverLayColor(
                              context,
                              getCardOverLayColor(
                                  context,
                                  MyColors
                                      .darkGrey)) //stupid way to get overlay color of an overlay color
                          : MyColors.lightGrey,
                      borderRadius: BorderRadius.circular(12.0)),
                ),

                //Build the sets data here
                buildDataList(exercise!, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getIntNumber() {
    return exercise!.data.length;
  }

//return the number of sets
  String getSetsNumber() {
    int length = exercise!.data.length;
    return length < 2
        ? (length.toString() + " Set, " + "Total Volume: " + exercise!.totalSets.toString())
        : (length.toString() + " Sets, " + "Total Volume: " + exercise!.totalSets.toString());
  }

//build data
  Widget buildDataList(Exercise exercise, BuildContext context) {
    List<Data> dataDecoded = exercise.data;

    return Column(
      children: [
        for (var i = 0; i < dataDecoded.length; i++)
          Row(
            children: [
              Text("#${i + 1} ", style: CardPreNumStyle.darkLight),
              Text(
                  Provider.of<UnitsNotifier>(context).weightUnit ==
                          WeightUnit.kg
                      ? '${dataDecoded[i].weight!.kg}'
                      : '${dataDecoded[i].weight!.lbs}',
                  style: CardSubTitleStyle.dark),
              Text(
                  Provider.of<UnitsNotifier>(context).weightUnit ==
                          WeightUnit.kg
                      ? ' Kg'
                      : ' Lbs', //" Kg",
                  style: CardSubTitleStyle.dark),
              Text(" for ", style: CardSubTitleStyle.dark),
              Text('${dataDecoded[i].reps}', style: CardSubTitleStyle.dark),
              Text(" Reps", style: CardSubTitleStyle.dark),
            ],
          ),
      ],
    );
  }
}
