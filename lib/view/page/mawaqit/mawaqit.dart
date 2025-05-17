import 'package:azkar_app/controller/mawaqit_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/functions/opacity_to_alph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Mawaqit extends StatelessWidget {
  const Mawaqit({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<MawaqitCtrl>(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: model.pages[model.currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.primaryColor,
        selectedItemColor: theme.fontColor,
        unselectedItemColor: theme.fontColor.withAlpha(opacityToAlpha(0.5)),
        selectedLabelStyle: GoogleFonts.amiri(
          color: theme.fontColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        currentIndex: model.currentPage,
        onTap: model.changePage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'مواقيت الصلاة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'المدن',
          ),
        ],
      ),
    );
  }
}
