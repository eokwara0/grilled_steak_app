import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chef_state.dart';

class ChefCubit extends Cubit<ChefState> {
  ChefCubit() : super(ChefInitial());
}
