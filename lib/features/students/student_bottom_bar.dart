import 'package:flutter_bloc/flutter_bloc.dart';



// Your Student Bottom Navigation Bar State
enum BottomNavItemS { home, classes, scanner, social, test }

class StudentBottomBar extends Cubit<BottomNavItemS> {
  StudentBottomBar() : super(BottomNavItemS.home);

  void updateIndex(int index) {
    switch (index) {
      case 0:
        emit(BottomNavItemS.home);
        break;
      case 1:
        emit(BottomNavItemS.classes);
        break;
      case 2:
        emit(BottomNavItemS.scanner);
        break;
      case 3:
        emit(BottomNavItemS.social);
        break;
      case 4:
        emit(BottomNavItemS.test);
        break;
    }
  }
}
