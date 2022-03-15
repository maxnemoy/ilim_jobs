import 'package:flutter/material.dart';

IconData tag2icon(int tag) {
  switch (tag) {
    case 1: //Первая работа
      return Icons.child_care;
    case 2: //Удаленно
      return Icons.maps_home_work_rounded;
    case 3: //Полный рабочий день
      return Icons.av_timer_rounded;
    case 4: //Частичная занятость
      return Icons.timelapse_rounded;
    case 5: //Работа вахтовым методом
      return Icons.airplane_ticket_rounded;
    default:
      return Icons.question_mark;
  }
}
