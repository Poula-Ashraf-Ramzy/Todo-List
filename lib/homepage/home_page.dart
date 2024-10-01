import 'package:Todo_List/app_colors.dart';
import 'package:Todo_List/homepage/settings_tab.dart';
import 'package:Todo_List/homepage/tasks_tab.dart';
import 'package:Todo_List/provider/list_provider.dart';
import 'package:Todo_List/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      extendBody: true,
      body: selectedindex == 0 ? TasksTab() : SettingsTab(),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
          onTap: (index) {
            selectedindex = index;

            setState(() {});
          },
          currentIndex: selectedindex,
          selectedLabelStyle: Theme.of(context).textTheme.titleSmall,
          unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list, size: 25),
              label: AppLocalizations.of(context)?.tasks,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 20,
              ),
              label: AppLocalizations.of(context)?.settings,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet();
        },
        child: Icon(Icons.add, color: AppColors.whiteColor),
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  showBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => MyBottomSheet());
  }
}
