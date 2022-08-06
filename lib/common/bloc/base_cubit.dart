import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCubit<BaseState> extends Cubit<BaseState> {
  BaseCubit(BaseState baseState) : super(baseState);
}
