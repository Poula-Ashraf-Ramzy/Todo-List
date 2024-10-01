import 'package:Todo_List/app_colors.dart';
import 'package:Todo_List/homepage/tasks.dart';
import 'package:Todo_List/provider/Appprovider.dart';
import 'package:Todo_List/provider/list_provider.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    double height = MediaQuery.of(context).size.height;

    return Stack(children: [
      Stack(
        children: [
          Container(
            color: provider.isDark()
                ? AppColors.primaryDarkColor
                : AppColors.primaryLightColor,
          ),
          Container(
            height: height * .08,
            color: AppColors.blueColor,
          )
        ],
      ),
      Column(
        children: [
          EasyDateTimeLine(
            locale: provider.appLanguage,
            initialDate: listProvider.selectedDate,
            onDateChange: (selectedDate) {
              listProvider.changeDate(selectedDate);
            },
            timeLineProps: EasyTimeLineProps(),
            headerProps: EasyHeaderProps(
              selectedDateStyle: Theme.of(context).textTheme.titleLarge,
              monthPickerType: MonthPickerType.switcher,
              monthStyle: Theme.of(context).textTheme.titleLarge,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            activeColor: AppColors.blueColor,
            dayProps: EasyDayProps(
                inactiveDayStyle: DayStyle(
                    dayNumStyle: Theme.of(context).textTheme.labelMedium,
                    dayStrStyle: Theme.of(context).textTheme.labelMedium,
                    monthStrStyle: Theme.of(context).textTheme.labelMedium,
                    decoration: BoxDecoration(
                      color: provider.isDark()
                          ? AppColors.darkColor
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    )),
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                todayHighlightColor: provider.isDark()
                    ? AppColors.darkColor
                    : AppColors.whiteColor,
                todayStyle: DayStyle(
                  dayNumStyle: Theme.of(context).textTheme.labelMedium,
                  dayStrStyle: Theme.of(context).textTheme.labelMedium,
                  monthStrStyle: Theme.of(context).textTheme.labelMedium,
                )),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: listProvider.list.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.transparent,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => Tasks(
                      task: listProvider.list[index],
                    ),
                    itemCount: listProvider.list.length,
                  ),
          )
        ],
      )
    ]);
  }
}
