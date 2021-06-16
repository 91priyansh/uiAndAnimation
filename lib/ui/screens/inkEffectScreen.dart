import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CubitState {}

class Load extends CubitState {}

class Fetched extends CubitState {
  final int i;
  Fetched({required this.i});
}

class TempCubit extends Cubit<CubitState> {
  final int i;
  TempCubit({required this.i}) : super(Load()) {
    loadData();
  }

  void loadData() async {
    await Future.delayed(Duration(seconds: 2));
    emit(Fetched(i: 10));
  }

  void updateData() {
    emit(Fetched(i: (state as Fetched).i + 1));
  }
}

class InkEffectScreen extends StatelessWidget {
  static Route<dynamic> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
      builder: (_) => BlocProvider<TempCubit>(
        create: (_) => TempCubit(i: 5),
        child: InkEffectScreen(),
      ),
    );
  }

  InkEffectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TempCubit, CubitState>(
        bloc: context.read<TempCubit>(),
        builder: (context, state) {
          return Center(
            child: Material(
              elevation: 5.0,
              color: Colors.blueAccent,
              shadowColor: Colors.lightBlueAccent.shade100,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                splashColor: Colors.greenAccent.withOpacity(0.1),
                onTap: () {
                  print("Hello");
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Wallah Wallah",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: MediaQuery.of(context).size.width * (0.8),
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pinkAccent.shade200),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
