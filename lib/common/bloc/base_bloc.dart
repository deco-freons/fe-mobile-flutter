import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBloc<BaseEvent, BaseState> extends Bloc<BaseEvent, BaseState> {
  BaseBloc(BaseState baseState) : super(baseState);
}
