// lib/screens/energy_monitor_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/energy_provider.dart';

class EnergyMonitorScreen extends StatelessWidget {
  const EnergyMonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final energyProvider = Provider.of<EnergyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Monitoring'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Current Energy Usage: ${energyProvider.currentEnergyUsage} kW',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Update Energy Data'),
              onPressed: () {
                energyProvider.updateEnergyUsage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
