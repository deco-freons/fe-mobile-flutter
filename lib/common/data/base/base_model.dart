import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BaseModel extends Equatable {
  const BaseModel();
  @override
  List<Object> get props => [];
}
