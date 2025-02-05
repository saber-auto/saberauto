import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingScreen extends StatefulWidget {
  final String serviceId;

  const BookingScreen({super.key, required this.serviceId});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _carMatriculeController = TextEditingController();

  String? _selectedMonth;
  int? _selectedDay;
  int? _selectedHour;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> hours = List.generate(24, (index) => index);

  final supabase = Supabase.instance.client;

  Future<void> _bookAppointment() async {
    if (!_formKey.currentState!.validate()) return;

    final user = supabase.auth.currentUser;
    if (user == null) return; // Ensure user is logged in

    final bookingTime =
        '${_selectedMonth!} ${_selectedDay!}, ${_selectedHour!}:00';

    // Check for existing bookings (1-hour gap)
    final existingBookings = await supabase
        .from('appointments')
        .select('id')
        .eq('month', _selectedMonth)
        .eq('day', _selectedDay)
        .eq('hour', _selectedHour)
        .execute();

    if (existingBookings.data.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This time slot is already booked!')),
      );
      return;
    }

    // Save booking to Supabase
    final response = await supabase.from('appointments').insert({
      'user_id': user.id,
      'service_id': widget.serviceId,
      'month': _selectedMonth,
      'day': _selectedDay,
      'hour': _selectedHour,
      'name': _nameController.text,
      'car_matricule': _carMatriculeController.text,
    }).execute();

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error!.message}')),
      );
      return;
    }

    // Send confirmation email
    await supabase.rpc('send_booking_email', params: {
      'email': user.email,
      'message':
          'Your appointment for $_selectedMonth $_selectedDay at $_selectedHour:00 has been confirmed!',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking confirmed! Check your email.')),
    );

    Navigator.pop(context); // Return to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              TextFormField(
                controller: _carMatriculeController,
                decoration: const InputDecoration(labelText: 'Car Matricule'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter car matricule' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedMonth,
                hint: const Text('Select Month'),
                items: months.map((month) {
                  return DropdownMenuItem(value: month, child: Text(month));
                }).toList(),
                onChanged: (value) => setState(() => _selectedMonth = value),
              ),
              DropdownButtonFormField<int>(
                value: _selectedDay,
                hint: const Text('Select Day'),
                items: days.map((day) {
                  return DropdownMenuItem(value: day, child: Text('$day'));
                }).toList(),
                onChanged: (value) => setState(() => _selectedDay = value),
              ),
              DropdownButtonFormField<int>(
                value: _selectedHour,
                hint: const Text('Select Hour'),
                items: hours.map((hour) {
                  return DropdownMenuItem(value: hour, child: Text('$hour:00'));
                }).toList(),
                onChanged: (value) => setState(() => _selectedHour = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _bookAppointment,
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
