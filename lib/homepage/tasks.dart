import 'package:Todo_List/app_colors.dart';
import 'package:Todo_List/firestore_utils.dart';
import 'package:Todo_List/homepage/edit_page.dart';
import 'package:Todo_List/homepage/view_page.dart';
import 'package:Todo_List/moduls/task.dart';
import 'package:Todo_List/provider/Appprovider.dart';
import 'package:Todo_List/provider/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class Tasks extends StatefulWidget {
  Task task;

  Tasks({required this.task});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: .5,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.

            SlidableAction(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                delete(widget.task.id);
                listProvider.initDataList();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: provider.isDark()
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                    content: Text(
                      '${widget.task.name} deleted successfully',
                      style: Theme.of(context).textTheme.labelSmall,
                    )));
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                Navigator.of(context)
                    .pushNamed(EditPage.routeName, arguments: widget.task);
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: provider.isDark()
                    ? AppColors.darkColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15)),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: VerticalDivider(
                          thickness: 3,
                          color: listProvider.isDone(widget.task)
                              ? AppColors.greenColor
                              : AppColors.blueColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(ViewPage.routeName);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.task.name,
                                style: listProvider.isDone(widget.task)
                                    ? Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: AppColors.greenColor)
                                    : Theme.of(context).textTheme.titleMedium),
                            Row(
                              children: [
                                Text(
                                  TimeOfDay(
                                          hour: widget.task.hour,
                                          minute: widget.task.min)
                                      .format(context),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: listProvider.isDone(widget.task)
                        ? Text(
                            AppLocalizations.of(context)!.done,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: AppColors.greenColor),
                          )
                        : IconButton.filled(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.blueColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            color: AppColors.whiteColor,
                            onPressed: () {
                              listProvider.finishTask(widget.task);
                              print(widget.task.isDone);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.check,
                              size: 35,
                            )),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void delete(String id) {
    FirestoreUtils.getCollections().doc(id).delete();
  }
}
