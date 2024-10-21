class Appliance {
  String name;
  double powerConsumption;
  bool isOn;
  DateTime? scheduledTime;

  Appliance({
    required this.name,
    this.powerConsumption = 0.0,
    this.isOn = false,
    this.scheduledTime,
  });

  // Function to check if the appliance has a schedule set
  bool hasSchedule() {
    return scheduledTime != null;
  }
}
