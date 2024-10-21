// lib/screens/device_control_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appliance_model.dart';
import '../providers/appliance_provider.dart';

class DeviceControlScreen extends StatelessWidget {
  const DeviceControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Control'),
        backgroundColor: Colors.teal,
      ),
      body: Consumer<ApplianceProvider>(
        builder: (context, applianceProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: applianceProvider.appliances.length,
                  itemBuilder: (context, index) {
                    final appliance = applianceProvider.appliances[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(appliance.name),
                        subtitle: Text('Power: ${appliance.powerConsumption} kW'),
                        trailing: Switch(
                          value: appliance.isOn,
                          onChanged: (value) {
                            applianceProvider.toggleAppliance(appliance);
                          },
                        ),
                        onTap: () {
                          _showEditApplianceDialog(
                              context, applianceProvider, index, appliance);
                        },
                        onLongPress: () {
                          applianceProvider.deleteAppliance(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              Text(
                'Total Power Consumption: ${applianceProvider.getTotalPowerConsumption()} kW',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: const Text('Add Appliance'),
                onPressed: () {
                  _showAddApplianceDialog(context, applianceProvider);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // Add Appliance Dialog
  void _showAddApplianceDialog(BuildContext context, ApplianceProvider provider) {
    final nameController = TextEditingController();
    final powerController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Appliance'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Appliance Name'),
              ),
              TextField(
                controller: powerController,
                decoration: const InputDecoration(labelText: 'Power (kW)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final name = nameController.text;
                final power = double.tryParse(powerController.text) ?? 0.0;
                provider.addAppliance(
                    Appliance(name: name, powerConsumption: power));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Edit Appliance Dialog
  void _showEditApplianceDialog(BuildContext context, ApplianceProvider provider,
      int index, Appliance appliance) {
    final nameController = TextEditingController(text: appliance.name);
    final powerController = TextEditingController(
        text: appliance.powerConsumption.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Appliance'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Appliance Name'),
              ),
              TextField(
                controller: powerController,
                decoration: const InputDecoration(labelText: 'Power (kW)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                final name = nameController.text;
                final power = double.tryParse(powerController.text) ?? 0.0;
                provider.modifyAppliance(index,
                    Appliance(name: name, powerConsumption: power));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
