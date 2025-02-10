import 'package:flutter/material.dart';

class PartDetailsScreen extends StatefulWidget {
  final String partName;

  const PartDetailsScreen({super.key, required this.partName});

  @override
  _PartDetailsScreenState createState() => _PartDetailsScreenState();
}

class _PartDetailsScreenState extends State<PartDetailsScreen> {
  String? selectedCar;
  String? selectedModel;
  String? selectedYear;

  final List<String> carNames = [
    'Toyota',
    'Mercedes-Benz',
    'Ford',
    'BMW',
    'Honda'
  ];
  final Map<String, List<String>> carModels = {
    'Toyota': ['Corolla', 'Camry', 'Yaris'],
    'Mercedes-Benz': ['C-Class', 'E-Class', 'S-Class'],
    'Ford': ['Focus', 'Mustang', 'F-150'],
    'BMW': ['Series 3', 'Series 5', 'X5'],
    'Honda': ['Civic', 'Accord', 'CR-V'],
  };
  final List<String> years =
      List.generate(25, (index) => (2025 - index).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.partName} Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCar,
              decoration: InputDecoration(labelText: 'Car Name'),
              items: carNames.map((car) {
                return DropdownMenuItem(value: car, child: Text(car));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCar = value;
                  selectedModel = null; // Reset model selection
                });
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedModel,
              decoration: InputDecoration(labelText: 'Car Model'),
              items: (selectedCar != null)
                  ? carModels[selectedCar]!.map((model) {
                      return DropdownMenuItem(value: model, child: Text(model));
                    }).toList()
                  : [],
              onChanged: (value) {
                setState(() {
                  selectedModel = value;
                });
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedYear,
              decoration: InputDecoration(labelText: 'Year of Production'),
              items: years.map((year) {
                return DropdownMenuItem(value: year, child: Text(year));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedYear = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedCar != null &&
                    selectedModel != null &&
                    selectedYear != null) {
                  // Handle submission logic
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
