import 'package:flutter_boilerplate/common/data/base_model.dart';

class ItemFilterModel<T> extends BaseModel {
  final T data;
  final bool isPicked;

  const ItemFilterModel({required this.data, this.isPicked = false});

  @override
  List<Object> get props => [];

  ItemFilterModel<T> copyWith({T? data, bool? isPicked}) {
    return ItemFilterModel<T>(
      data: data ?? this.data,
      isPicked: isPicked ?? this.isPicked,
    );
  }
}
