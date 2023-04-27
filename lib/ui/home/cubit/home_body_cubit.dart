import 'package:bloc/bloc.dart';

import 'home_body_state.dart';

class HomeBodyCubit extends Cubit<HomeBodyState> {
  HomeBodyCubit() : super(const HomeBodyInitial(items: []));
}
