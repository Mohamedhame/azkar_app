import 'package:azkar_app/controller/mawaqit_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/functions/opacity_to_alph.dart';
import 'package:azkar_app/service/shared.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/mawaqit/add_city.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cities extends StatelessWidget {
  const Cities({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<MawaqitCtrl>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: model.isLoadingLocation ? 0.5 : 1.0,
              child: Column(
                children: [
                  CustomDesignBuuton(
                    titleItem: "المدن والعواصم",
                    backgroundColor: theme.fontColor.withAlpha(
                      opacityToAlpha(0.5),
                    ),
                    foregroundColor: theme.primaryColor,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.allCities.length,
                      itemBuilder: (context, index) {
                        return CustomDesignBuuton(
                          titleItem: model.allCities[index]['city'],
                          widget: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              model.ifInShared(index)
                                  ? InkWell(
                                    child: Icon(
                                      Icons.check_box,
                                      color: theme.fontColor,
                                    ),
                                  )
                                  : InkWell(
                                    onTap: () async {
                                      await Shared.saveCityData(
                                        model.allCities[index],
                                      );
                                      model.changePrayerState();
                                      model.getCityName();
                                    },
                                    child: Icon(
                                      Icons.check_box_outline_blank,
                                      color: theme.fontColor,
                                    ),
                                  ),
                              if (model.allCities[index]['isAdded'])
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        model.deleteCityFromData(index);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: theme.fontColor,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  AddCityToData(theme: theme, model: model),
                ],
              ),
            ),
            if (model.isLoadingLocation)
              Positioned.fill(
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
