import 'dart:io';

import 'package:client/common/test_case_result.dart';
import 'package:client/features/users/blocs/users_gprc/users_grpc_cubit.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class UsersResults extends StatelessWidget {
  const UsersResults({Key? key}) : super(key: key);

  Future<void> exportModelsToCsv(List<TestCaseResult> testCaseResults) async {
    final rows = testCaseResults
        .map((testCaseResult) => [
              testCaseResult.countRecords.toString(),
              testCaseResult.requestTime.toString(),
              testCaseResult.responseTime.toString(),
              testCaseResult.requestVolumeInBytes.toString(),
              testCaseResult.responseVolumeInBytes.toString(),
            ])
        .toList();

    rows.insert(0, [
      'Count records',
      'Request time',
      'Response time',
      'Request volume',
      'Response volume',
    ]);

    final csvData = const ListToCsvConverter().convert(rows);

    final String? directory = (await getExternalStorageDirectory())?.path;
    if (directory != null) {
      print("$directory/results.csv");
      final csvFile = File('$directory/results.csv');
      await csvFile.writeAsString(csvData);

      // await FilePicker.platform.saveFile(fileName: "$directory/results.csv");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text("Users test case"),
          BlocBuilder<UsersGrpcCubit, UsersGrpcState>(
            builder: (context, state) {
              return state.maybeMap(
                initial: (value) {
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<UsersGrpcCubit>(context)
                          .startMeasurement();
                    },
                    child: const Text("Start measurements"),
                  );
                },
                loadingUsers: (value) => const Text("Loading users..."),
                processing: (value) => const Text("Processing test case"),
                done: (value) => Column(
                  children: [
                    const Text("Done"),
                    ElevatedButton(
                        onPressed: () {
                          exportModelsToCsv(value.testCaseResults)
                              .then((value) {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('CSV exported'),
                                  content: const Text(
                                      'The CSV file has been saved to your downloads directory.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        },
                        child: const Text("Export to csv"))
                  ],
                ),
                error: (value) => Column(
                  children: [
                    Text(value.msg),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<UsersGrpcCubit>(context)
                            .startMeasurement();
                      },
                      child: const Text("Restart measurements"),
                    ),
                  ],
                ),
                orElse: () => const Text("Unknown state"),
              );
            },
          ),
        ],
      ),
    );
  }
}
