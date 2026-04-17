import 'package:flutter_riverpod/flutter_riverpod.dart';

// Klasa zarządzająca stanem indeksu dolnego paska nawigacji
class NavigationController extends StateNotifier<int> {
  NavigationController() : super(0);

  void setIndex(int newIndex) {
    state = newIndex;
  }

  int get selectedIndex => state;
}

// Provider dostępny globalnie
final navigationProvider =
    StateNotifierProvider<NavigationController, int>((ref) {
  return NavigationController();
});
