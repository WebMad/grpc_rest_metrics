import 'dart:io';

import 'package:client/common/test_case_result.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

Future<void> exportTestCaseResultsToCsv(
    {required List<TestCaseResult> testCaseResults,
    required String name}) async {
  final rows = testCaseResults
      .map((testCaseResult) => [
            testCaseResult.countRecords.toString(),
            testCaseResult.requestTime.toString(),
            testCaseResult.requestVolumeInBytes.toString(),
            testCaseResult.responseVolumeInBytes.toString(),
          ])
      .toList();

  rows.insert(0, [
    'Count records',
    'Request time',
    'Request volume',
    'Response volume',
  ]);

  final csvData = const ListToCsvConverter().convert(rows);

  final String? directory = (await getExternalStorageDirectory())?.path;
  if (directory != null) {
    print("$directory/results.csv");
    final csvFile = File('$directory/$name.csv');
    await csvFile.writeAsString(csvData);

    // await FilePicker.platform.saveFile(fileName: "$directory/results.csv");
  }
}
