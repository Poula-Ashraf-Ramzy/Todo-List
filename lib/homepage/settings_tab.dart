import 'package:Todo_List/app_colors.dart';
import 'package:Todo_List/provider/Appprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    List<String> languages = [
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.arabic,
    ];
    List<String> languagecode = ['en', 'ar'];
    List<String> mode = [
      AppLocalizations.of(context)!.light,
      AppLocalizations.of(context)!.dark,
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height * .08,
          color: AppColors.blueColor,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: DropdownMenu(
                  width: width * 0.77,
                  initialSelection:
                      languages[languagecode.indexOf(provider.appLanguage)],
                  onSelected: (value) {
                    if (value != null) {
                      provider.changeLanguage(
                          languagecode[languages.indexOf(value)]);
                      setState(() {});
                    }
                  },
                  dropdownMenuEntries: languages.map((value) {
                    return DropdownMenuEntry(value: value, label: value);
                  }).toList()),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                AppLocalizations.of(context)!.mode,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: DropdownMenu(
                  width: width * 0.77,
                  initialSelection: provider.isDark()
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
                  onSelected: (value) {
                    if (value != null) {
                      value == AppLocalizations.of(context)!.dark
                          ? provider.changeTheme(ThemeMode.dark)
                          : provider.changeTheme(ThemeMode.light);
                    }
                  },
                  dropdownMenuEntries: mode.map((value) {
                    return DropdownMenuEntry(value: value, label: value);
                  }).toList()),
            )
          ],
        ),
      ],
    );
  }
}
