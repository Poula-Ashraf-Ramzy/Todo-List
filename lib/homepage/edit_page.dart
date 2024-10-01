import 'package:Todo_List/app_colors.dart';
import 'package:Todo_List/provider/Appprovider.dart';
import 'package:Todo_List/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../firestore_utils.dart';
import '../moduls/task.dart';
import '../provider/list_provider.dart';

class EditPage extends StatefulWidget {
  static const String routeName = 'editpage';

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var formkey = GlobalKey<FormState>();

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  String name = '';

  String description = '';

  late ListProvider listProvider;
  late Task args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Task;
    if (nameController.text.isEmpty && descriptionController.text.isEmpty) {
      nameController.text = args.name;
      descriptionController.text = args.description;
    }
    if (selectedDate == null && selectedTime == null) {
      selectedDate = args.dateTime;
      selectedTime = TimeOfDay(hour: args.hour, minute: args.min);
    }
    listProvider = Provider.of<ListProvider>(context);
    var provider = Provider.of<AppProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.blue,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.app_title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Stack(children: [
          Container(
            height: height * .08,
            color: AppColors.blueColor,
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(
              top: height * .05,
              bottom: height * .1,
              right: width * .1,
              left: width * .1,
            ),
            decoration: BoxDecoration(
                color: provider.isDark()
                    ? AppColors.darkColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white12,
                      spreadRadius: 4,
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.add_new_task,
                  style: provider.isDark()
                      ? Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.whiteColor)
                      : Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.blackColor),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          MyTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .title_validation;
                              }
                              return null;
                            },
                            controller: nameController,
                            label: AppLocalizations.of(context)!.title,
                            iconColor: AppColors.blueColor,
                            floatingLabelStyleColor: AppColors.blueColor,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MyTextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .description_vadidation;
                              }
                              return null;
                            },
                            controller: descriptionController,
                            label: AppLocalizations.of(context)!.description,
                            iconColor: AppColors.blueColor,
                            floatingLabelStyleColor: AppColors.blueColor,
                            maxLines: 3,
                            maxTextLength: 100,
                            buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                required maxLength}) {
                              return Text(
                                '${currentLength}/${maxLength}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: currentLength == maxLength
                                        ? AppColors.redColor
                                        : AppColors.blueColor),
                              );
                            },
                          ),
                        ],
                      )),
                ),
                Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
                  onTap: () {
                    showCalender();
                  },
                  child: Text(
                    DateFormat.yMMMd(
                            Localizations.localeOf(context).languageCode)
                        .format(selectedDate!),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: AppColors.blueColor.withOpacity(.7)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.select_time,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
                  onTap: () {
                    showClock();
                  },
                  child: Text(
                    DateFormat.jm(Localizations.localeOf(context).languageCode)
                        .format(DateTime(
                            1, 1, 1, selectedTime!.hour, selectedTime!.minute)),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: AppColors.blueColor.withOpacity(.7)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: ElevatedButton(
                    onPressed: () {
                      update();
                    },
                    child: Text(AppLocalizations.of(context)!.save_changes,
                        style: GoogleFonts.inter(
                            color: AppColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void showClock() async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
            TimeOfDay.now();
    setState(() {});
  }

  void update() {
    if (formkey.currentState?.validate() == true) {
      args.name = nameController.text;
      args.description = descriptionController.text;
      args.dateTime = selectedDate!;
      args.hour = selectedTime!.hour;
      args.min = selectedTime!.minute;
      FirestoreUtils.updateDate(args).timeout(Duration(seconds: 1),
          onTimeout: () {
        print('updated');
      });
      Navigator.pop(context);
      listProvider.initDataList();
    }
  }

  void showCalender() async {
    selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
          initialDate: selectedDate,
        ) ??
        selectedDate;
    print(selectedDate);
    setState(() {});
  }
}
