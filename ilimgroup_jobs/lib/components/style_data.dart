import 'package:flutter/material.dart';

class StyleData{
  static iconBoxDecoration(BuildContext context) => BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 10),
                  ],
                );
}