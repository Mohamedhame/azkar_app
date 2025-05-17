import 'package:azkar_app/controller/mawaqit_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/mawaqit/box_decorated_mawaqit_view.dart';
import 'package:azkar_app/view/widget/mawaqit/custom_city_name.dart';
import 'package:azkar_app/view/widget/mawaqit/custom_massjed_image.dart';
import 'package:azkar_app/view/widget/mawaqit/custom_prayer_name_and_prayer_time.dart';
import 'package:azkar_app/view/widget/mawaqit/custom_raw_remaning.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MawaqitView extends StatelessWidget {
  const MawaqitView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final Size size = MediaQuery.of(context).size;
    return Consumer<MawaqitCtrl>(
      builder: (context, model, child) {
        return SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.4,
                    child: DecoratedBox(decoration: boxDecorationMawaqitView),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CustomMassjedImage(),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 150,
                    child: CustomRowRemaining(
                      title: "الوقت المتبقي",
                      remaining: model.remaining,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 30,
                    child: CustomPrayerNameAndTime(
                      prayrName: model.prayrName,
                      prayerTime: model.timeOfPrayae,
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 70,
                    child: CustomCityName(cityName: model.cityName),
                  ),
                ],
              ),
              //=================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: ListView.builder(
                    itemCount: model.prayers.length,
                    itemBuilder: (context, index) {
                      return CustomDesignBuuton(
                        titleItem:
                            index != 1
                                ? "صلاة ${model.prayers[index]['prayerName']}"
                                : "${model.prayers[index]['prayerName']}",
                        widget: Text(
                          "${model.prayers[index]['time']}",
                          style: TextStyle(color: theme.fontColor),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
