import 'package:flutter_bloc/flutter_bloc.dart';

class NavCubit extends Cubit<int> {
   NavCubit() : super(0);

     update(int tab) {
    emit(tab);
  }
}
