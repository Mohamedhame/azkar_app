import 'package:azkar_app/controller/counter_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class CustomSuffixIconCuonter extends StatelessWidget {
  const CustomSuffixIconCuonter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context, listen: false);
    final model = Provider.of<CounterCtrl>(context);
    return GestureDetector(
      onTapUp: (details) async {
        double dx = details.globalPosition.dx;
        double dy = details.globalPosition.dy;
        double right = MediaQuery.of(context).size.width - dx;
        double bottom = MediaQuery.of(context).size.width - dy;
        showMenu(
          color: theme.primaryColor,
          context: context,
          position: RelativeRect.fromLTRB(dx, dy, right, bottom),
          items: [
            ...List.generate(model.azkerFromShared.length, (index) {
              String value = model.azkerFromShared[index];
              return PopupMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.fontColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.center,
                                model.azkerFromShared[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            if (!model.azkarList.contains(
                              model.azkerFromShared[index],
                            ))
                              Row(
                                children: [
                                  const SizedBox(width: 15),
                                  InkWell(
                                    onTap: () {
                                      model.deleteItemFromShared(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  model.setInZekrController(model.azkerFromShared[index]);
                  model.resetCounter();
                },
              );
            }),
          ],
        );
      },
      child: Icon(Icons.arrow_drop_down, color: theme.fontColor, size: 26),
    );
  }
}
