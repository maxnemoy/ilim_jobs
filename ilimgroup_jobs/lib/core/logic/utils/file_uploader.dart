import 'dart:async';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/models/response_data.dart';

FutureOr<String> pickFileAndUpload(String token,
    {FileType type = FileType.image}) async {
  Dio dio = Dio();
  dio.options = BaseOptions(baseUrl: serverBaseUrl);
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: type);
  if (result != null) {
    String? extension = result.files.single.extension;
    late MultipartFile file;
    if (kIsWeb) {
      file = MultipartFile.fromBytes(result.files.single.bytes!.toList(), filename: result.files.single.name);
    } else {
      file = await MultipartFile.fromFile(result.files.single.path!, filename: result.files.single.name);
    }

    final _data = FormData();
    _data.files.add(MapEntry('file', file));
    _data.fields.add(MapEntry('extension', extension!));

    final _result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': token},
                contentType: 'multipart/form-data')
            .compose(dio.options, uploadPath, data: _data)
            .copyWith(baseUrl: dio.options.baseUrl)));
    final resp = RespData.fromJson(_result.data!);

    return resp.path!;
  }
  return "";
}

RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
  if (T != dynamic &&
      !(requestOptions.responseType == ResponseType.bytes ||
          requestOptions.responseType == ResponseType.stream)) {
    if (T == String) {
      requestOptions.responseType = ResponseType.plain;
    } else {
      requestOptions.responseType = ResponseType.json;
    }
  }
  return requestOptions;
}


// Работа в команде экспертов в сфере IT – это решение сложных и интересных задач по цифровизации и автоматизации процессов.

// Проекты

// В активе компании на сегодняшний день насчитывается около 40 IT-проектов, которые входят в единую цифровую стратегию. Ни один производственный проект не обходится без специалистов IT в составе рабочей группы. Уже реализованы проекты:

// Сквозной учет леса

// Мы применяем инновационные методы и технологии измерения объёмов и качественных характеристик леса, в том числе с применением беспилотников. С помощью сканирующих лазерных систем и нейронных сетей мы собираем и анализируем информацию о лесосырье на этапах таксации, заготовки, хранения, перевалки и подачи на производство. 

// Supplier Relationship Management (SRM)

// Это собственная закупочная платформа, которая помогает повысить прозрачность закупок и делает процесс выбора поставщика более удобным. SRM позволяет сократить операционные затраты и оптимизировать процесс документооборота.

// Прогнозирование обрывов бумажного полотна

// Цель проекта – спрогнозировать и предотвратить обрывы бумажного полотна на картоно- и бумагоделательных машинах. Для построения моделей оборудования использовались решения SAP Predictive и Python. Были опробованы методы моделирования: деревья решений, случайные леса (random forest), градиентный бустинг над решающими деревьями (xgboost). Для решения задачи была построена физико-математическая модель оборудования, дополненная фактическими данными. 

// WMS «Игра рулонов»

// Проект позволяет вести онлайн учет выпуска товарной продукции и брака в SAP. Организована работа складов по приемке, размещению и отгрузке продукции с учетом адресного хранения и с применением терминалов сбора данных. Ведутся работы по интеграционному планированию на базе online данных о запасах и интерактивному информированию клиентов об отгруженной продукции.

// IMill

// Была создана оболочка, которая все данные синхронизирует из системы и отображает в удобном интерфейсе. Информация размещена на 7 уровнях — от общей информации про годовые KPI до анализа работы машин в режиме онлайн (технико-математические показатели). Для реализации проекта применялись решения Tableau (визуализация) и SAP PI/PO (интеграция со всеми IT системами). Реализована интеграция с модулями SAP и другими IT решениями компании: SAP MM, SAP WMS, SAP SF, SAP PM, OSISoft PI system, Проконт и др.