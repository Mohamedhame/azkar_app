import 'package:azkar_app/controller/mawaqit_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/functions/opacity_to_alph.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/custom_text_form_filed.dart';
import 'package:flutter/material.dart';

class AddCityToData extends StatelessWidget {
  const AddCityToData({
    super.key,
    required this.theme,
    required this.model,
  });

  final ThemeController theme;
  final MawaqitCtrl model;

  @override
  Widget build(BuildContext context) {
    return CustomDesignBuuton(
      titleItem: "إضافة مدينة",
      backgroundColor: theme.fontColor.withAlpha(
        opacityToAlpha(0.8),
      ),
      foregroundColor: theme.primaryColor,
      onTap: () async {
        await model.getLocation();
        if (model.isPermission) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: theme.primaryColor,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(
                      controller: model.cityNameController,
                      label: "إضافة مدينة",
                    ),
                    CustomTextFormField(
                      controller: model.latitudeController,
                      label: "خط الطول",
                    ),
                    CustomTextFormField(
                      controller: model.longitudeController,
                      label: "دوائر العرض",
                    ),
    
                    CustomDesignBuuton(
                      titleItem: "إضافة",
                      onTap: () async {
                        model.addToDataList();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
