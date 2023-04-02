import 'package:client/features/users/blocs/users_gprc/users_grpc_cubit.dart';
import 'package:client/features/users/widgets/users_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocProvider(
                create: (context) => UsersGrpcCubit(),
                child: const UsersResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
