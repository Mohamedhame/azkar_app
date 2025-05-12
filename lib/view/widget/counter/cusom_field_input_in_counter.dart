import 'package:azkar_app/controller/counter_ctrl.dart';
import 'package:azkar_app/view/widget/counter/custom_suffix_icon_counter.dart';
import 'package:azkar_app/view/widget/custom_text_form_filed.dart';
import 'package:flutter/material.dart';

class CusomFieldInputInCounter extends StatelessWidget {
  const CusomFieldInputInCounter({super.key, required this.model});
  final CounterCtrl model;
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: CustomTextFormField(
            readOnly: true,
            controller: model.zekr,
            suffixIcon: CustomSuffixIconCuonter(),
          ),
        ),
        SizedBox(
          width: 80,
          child: CustomTextFormField(
            controller: model.count,
            isNumber: true,
            onChanged: (value) {
              model.resetCounter();
            },
          ),
        ),
      ],
    );
  }
}
