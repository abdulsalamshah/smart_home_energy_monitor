import 'package:flutter/material.dart';
import '../models/appliance_model.dart';

class ApplianceProvider with ChangeNotifier {
  final List<Appliance> _appliances = [
    Appliance(name: 'Air Conditioner', powerConsumption: 1.5),
    Appliance(name: 'Heater', powerConsumption: 2.0),
    Appliance(name: 'Lights', powerConsumption: 0.1),
  ];

  List<Appliance> get appliances => _appliances;

  void toggleAppliance(Appliance appliance) {
    appliance.isOn = !appliance.isOn;
    notifyListeners();
  }

  void addAppliance(Appliance appliance) {
    _appliances.add(appliance);
    notifyListeners();
  }

  void modifyAppliance(int index, Appliance updatedAppliance) {
    _appliances[index] = updatedAppliance;
    notifyListeners();
  }

  void deleteAppliance(int index) {
    _appliances.removeAt(index);
    notifyListeners();
  }

  double getTotalPowerConsumption() {
    double total = 0.0;
    for (var appliance in _appliances) {
      if (appliance.isOn) {
        total += appliance.powerConsumption;
      }
    }
    return total;
  }

  // Add this method to schedule an appliance
  void scheduleAppliance(Appliance appliance, DateTime scheduledTime) {
    appliance.scheduledTime = scheduledTime;
    notifyListeners();
  }
}
