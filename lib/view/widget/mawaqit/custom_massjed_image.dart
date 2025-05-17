import 'package:flutter/material.dart';

class CustomMassjedImage extends StatelessWidget {
  const CustomMassjedImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: SizedBox(
        child: Image.asset("assets/images/massjed.png"),
      ),
    );
  }
}
