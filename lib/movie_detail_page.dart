import 'package:flutter/material.dart';
import 'ticket_page.dart';

class MovieDetailPage extends StatefulWidget {
  final String title;
  final String description;

  const MovieDetailPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  String? selectedSeat;

  List<String> seats = ["A1", "A2", "A3", "B1", "B2", "B3"];
  List<String> unavailableSeats = ["A2", "B3"];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2026, 12, 31),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context);
      });
    }
  }

  void _bookTicket() {
    if (selectedSeat == null || selectedTime == null) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Error"),
          content: Text("Pilih jadwal dan kursi terlebih dahulu!"),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TicketPage(
          movieTitle: widget.title,
          date: "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
          time: selectedTime!,
          seat: selectedSeat!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.description,
                style: const TextStyle(fontSize: 16, height: 1.4)),
            const Divider(height: 24),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.date_range),
              label: const Text("Pilih Tanggal"),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickTime,
              icon: const Icon(Icons.access_time),
              label: const Text("Pilih Waktu"),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: seats.map((seat) {
                final isUnavailable = unavailableSeats.contains(seat);
                return ChoiceChip(
                  label: Text(seat),
                  selected: selectedSeat == seat,
                  onSelected: isUnavailable
                      ? null
                      : (bool selected) {
                          setState(() {
                            selectedSeat = selected ? seat : null;
                          });
                        },
                  selectedColor: Colors.pink,
                  disabledColor: Colors.grey.shade400,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Informasi Booking",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text("Film: ${widget.title}"),
                    Text("Tanggal: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
                    Text("Waktu: ${selectedTime ?? '-'}"),
                    Text("Kursi: ${selectedSeat ?? '-'}"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton.icon(
                onPressed: _bookTicket,
                icon: const Icon(Icons.local_movies),
                label: const Text("Booking Film"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
