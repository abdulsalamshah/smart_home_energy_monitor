import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appliance_provider.dart';
import '../models/appliance_model.dart';

class ApplianceScheduleScreen extends StatelessWidget {
  const ApplianceScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final applianceProvider = Provider.of<ApplianceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appliance Scheduling'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: applianceProvider.appliances.length,
        itemBuilder: (context, index) {
          final appliance = applianceProvider.appliances[index];
          return ListTile(
            title: Text(appliance.name),
            subtitle: Text(appliance.hasSchedule()
                ? 'Scheduled for: ${appliance.scheduledTime}'
                : 'No schedule set'),
            trailing: IconButton(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                _selectTime(context, applianceProvider, appliance);
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, ApplianceProvider provider,
      Appliance appliance) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final scheduledTime =
      DateTime(now.year, now.month, now.day, picked.hour, picked.minute);

      // Update the appliance schedule
      provider.scheduleAppliance(appliance, scheduledTime);
    }
  }
}
