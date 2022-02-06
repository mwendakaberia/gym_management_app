import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:the_bar_gym/models/exercise.dart';
import 'package:the_bar_gym/pages/log_pages/exercise_details.dart';
import 'package:the_bar_gym/pages/log_pages/settings.dart';
import 'package:the_bar_gym/provider/exercise_detail_provider.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/theme.dart';
import 'package:the_bar_gym/utils/colors.dart';
import 'package:the_bar_gym/utils/date_picker.dart';
import 'package:the_bar_gym/utils/textStyles.dart';
import 'package:the_bar_gym/widgest/log_widgets/empty_page.dart';
import 'package:the_bar_gym/widgest/log_widgets/exercise_card.dart';

class ExerciseList extends StatefulWidget {
  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  DateTime date = DateTime.now();

  //get the date
  void getExerciseOnDate() async {
    DateTime? newDate = await selectDate(context, date);
    if (newDate != null) {
      setState(() {
        date = newDate
            .add(const Duration(days: 1))
            .subtract(const Duration(seconds: 1));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("date --- ${date.toString()}");
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor:
            // isThemeDark(context) ?
            AppColors.cardDark,
        // : AppColors.cardLight,
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
            ),
            backgroundColor: AppColors.cardDark,
            elevation: 2,
            title: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.iconLight.withOpacity(0.3),
                    spreadRadius: 8,
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Hero(
                tag: 'appBarTitle',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    DateFormat('EEE, d').format(date),
                    style: AppBarTitleStyle.dark,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.calendar_today_rounded,
                  color: MyColors.white,
                ),
                tooltip: 'Select date',
                onPressed: () => getExerciseOnDate(),
              ),
              IconButton(
                icon: Icon(
                  Icons.settings_rounded,
                  color: MyColors.white,
                ),
                tooltip: 'Settings',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage())),
              ),
            ]),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: buildExerciseList(context),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.accent,
          heroTag: 'fab',
          elevation: 3.0,
          child: Icon(Icons.add),
          // foregroundColor: MyColors.black,
          // backgroundColor: MyColors.accentColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseDetail(
                  isEdit: false,
                  exercise: null,
                  date: date,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

//Build Exercise list
  StreamBuilder<List<Exercise>> buildExerciseList(BuildContext context) {
    return StreamBuilder(
      stream: context.watch<ExerciseDetailProvider>().getAllData(date),
      builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
        final List<Exercise> exercises = snapshot.data!;
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.all(6.0),
              itemCount: exercises.length,
              itemBuilder: (_, index) {
                final exercise = exercises[index];
                return ExerciseCard(
                  exercise: exercise,
                  index: index,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseDetail(
                          exercise: exercise,
                          isEdit: true,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return EmptyPage();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
