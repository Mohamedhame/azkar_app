import 'package:azkar_app/controller/counter_ctrl.dart';
import 'package:azkar_app/controller/theme_controller.dart';
import 'package:azkar_app/view/widget/calculate_of_progress.dart';
import 'package:azkar_app/view/widget/counter/cusom_field_input_in_counter.dart';
import 'package:azkar_app/view/widget/custom_app_bar.dart';
import 'package:azkar_app/view/widget/custom_design_buuton.dart';
import 'package:azkar_app/view/widget/custom_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final model = Provider.of<CounterCtrl>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: customAppBar(theme: theme, title: "السبحة"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CusomFieldInputInCounter(model: model),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.6,
                child: InkWell(
                  onTap: () {
                    model.counterFunc();
                  },
                  child: CulculateOfProgress(
                    theme: theme,
                    centerText: model.counter.toString(),
                    selector: (CounterCtrl ctrl) => ctrl.percent,
                    radius: 120,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomDesignBuuton(
                titleItem: "إضافة ذكر",
                onTap: () {
                  final model = Provider.of<CounterCtrl>(
                    context,
                    listen: false,
                  );
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: theme.primaryColor,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                              readOnly: false,
                              controller: model.addZekr,
                            ),
                            const SizedBox(height: 10),
                            CustomDesignBuuton(
                              titleItem: "إضافة",

                              onTap: () {
                                model.insertIntoAzkerListInShared();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
