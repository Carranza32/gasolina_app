import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  int _currentTab = 1;
  int get currentTab => _currentTab;

  set currentTab(int index) {
    _currentTab = index;
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  bool _isFilterActive = false;
  bool get isFilterActive => _isFilterActive;
  set isFilterActive(bool value) {
    _isFilterActive = value;
    notifyListeners();
  }
  

  final List<String> _alerts = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  List<String> get alerts => _alerts;

  void addAlerts(List<String> alerts) {
    _alerts.addAll(alerts);
    notifyListeners();
  }
  
}