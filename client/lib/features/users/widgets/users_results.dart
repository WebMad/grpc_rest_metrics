import 'package:client/common/export_test_case_results_to_csv.dart';
import 'package:client/features/users/blocs/users_gprc/users_grpc_cubit.dart';
import 'package:client/features/users/blocs/users_rest/users_rest_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersResults extends StatelessWidget {
  const UsersResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
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
                      child: const Text("Start grpc measurements"),
                    );
                  },
                  loadingUsers: (value) => const Text("Loading users..."),
                  processing: (value) => const Text("Processing test case"),
                  done: (value) => Column(
                    children: [
                      const Text("Done"),
                      ElevatedButton(
                          onPressed: () {
                            exportTestCaseResultsToCsv(
                                    testCaseResults: value.testCaseResults,
                                    name: 'users grpc')
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
                        child: const Text("Restart grpc measurements"),
                      ),
                    ],
                  ),
                  orElse: () => const Text("Unknown state"),
                );
              },
            ),
            BlocBuilder<UsersRestCubit, UsersRestState>(
              builder: (context, state) {
                return state.maybeMap(
                  initial: (value) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<UsersRestCubit>(context)
                            .startMeasurement();
                      },
                      child: const Text("Start rest measurements"),
                    );
                  },
                  loadingUsers: (value) => const Text("Loading users..."),
                  processing: (value) => const Text("Processing test case"),
                  done: (value) => Column(
                    children: [
                      const Text("Done"),
                      ElevatedButton(
                          onPressed: () {
                            exportTestCaseResultsToCsv(
                                    testCaseResults: value.testCaseResults,
                                    name: 'users rest')
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
                          BlocProvider.of<UsersRestCubit>(context)
                              .startMeasurement();
                        },
                        child: const Text("Restart rest measurements"),
                      ),
                    ],
                  ),
                  orElse: () => const Text("Unknown state"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
