 import 'package:flutter/material.dart';

var boxDecorationMawaqitView = BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff2F3192), Color(0xff8E89A8)],
                    ),
                  );