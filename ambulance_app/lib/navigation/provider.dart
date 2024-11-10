import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarVisibilityNotifier extends StateNotifier<bool>{
  AppBarVisibilityNotifier():super(true); 

  void toggleVisibility(){
    state = !state; //* ne mozes menjati u memoriji moras napraviti novi
  }
}

final appBarVisibilityProvider = StateNotifierProvider<AppBarVisibilityNotifier,bool>((ref) => AppBarVisibilityNotifier());