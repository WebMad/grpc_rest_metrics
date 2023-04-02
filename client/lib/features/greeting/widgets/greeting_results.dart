import 'package:client/common/export_test_case_results_to_csv.dart';
import 'package:client/features/greeting/blocs/greeting_grpc/greeting_grpc_cubit.dart';
import 'package:client/features/greeting/blocs/greeting_rest/greeting_rest_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GreetingResults extends StatelessWidget {
  const GreetingResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Text("Greeting test case"),
            BlocBuilder<GreetingGrpcCubit, GreetingGrpcState>(
              builder: (context, state) {
                return state.maybeMap(
                  initial: (value) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<GreetingGrpcCubit>(context)
                            .startMeasurement();
                      },
                      child: const Text("Start grpc measurements"),
                    );
                  },
                  processing: (value) => const Text("Processing test case"),
                  done: (value) => Column(
                    children: [
                      const Text("Done"),
                      ElevatedButton(
                          onPressed: () {
                            exportTestCaseResultsToCsv(
                                    testCaseResults: value.testCaseResults,
                                    name: "greeting grpc")
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
                          BlocProvider.of<GreetingGrpcCubit>(context)
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
            BlocBuilder<GreetingRestCubit, GreetingRestState>(
              builder: (context, state) {
                return state.maybeMap(
                  initial: (value) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<GreetingRestCubit>(context)
                            .startMeasurement();
                      },
                      child: const Text("Start rest measurements"),
                    );
                  },
                  processing: (value) => const Text("Processing test case"),
                  done: (value) => Column(
                    children: [
                      const Text("Done"),
                      ElevatedButton(
                          onPressed: () {
                            exportTestCaseResultsToCsv(
                                    testCaseResults: value.testCaseResults,
                                    name: 'greeting rest')
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
                          BlocProvider.of<GreetingRestCubit>(context)
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
