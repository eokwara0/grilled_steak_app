part of 'chef_cubit.dart';

abstract class ChefState extends Equatable {
  const ChefState();

  @override
  List<Object> get props => [];
}

class ChefInitial extends ChefState {}
