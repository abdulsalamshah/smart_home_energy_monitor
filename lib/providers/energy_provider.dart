// lib/providers/energy_provider.dart
import 'package:flutter/material.dart';
import 'dart:math';

class EnergyProvider with ChangeNotifier {
  double _currentEnergyUsage = 5.0; // Default energy usage

  double get currentEnergyUsage => _currentEnergyUsage;

  void updateEnergyUsage() {
    // Simulate energy usage change
    _currentEnergyUsage = Random().nextDouble() * 10;
    notifyListeners();
  }
}

