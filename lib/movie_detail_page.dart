import 'dart:ui';
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
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => selectedTime = picked.format(context));
    }
  }

  void _bookTicket() {
    if (selectedSeat == null || selectedTime == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text("Error", style: TextStyle(color: Colors.white)),
          content: const Text(
            "Pilih jadwal dan kursi dulu yaa 🎬",
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TicketPage(
          movieTitle: widget.title,
          date:
              "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
          time: selectedTime!,
          seat: selectedSeat!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1f1c2c), Color(0xFF928DAB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// GLOW
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          widget.description,
                          style: const TextStyle(
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// DATE & TIME
                        Row(
                          children: [
                            Expanded(
                              child: _buildButton(
                                icon: Icons.date_range,
                                text:
                                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                onTap: _pickDate,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildButton(
                                icon: Icons.access_time,
                                text: selectedTime ?? "Pilih Jam",
                                onTap: _pickTime,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// SEAT
                        const Text("Pilih Kursi 🎟️",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),

                        const SizedBox(height: 10),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: seats.map((seat) {
                            final isUnavailable =
                                unavailableSeats.contains(seat);

                            return GestureDetector(
                              onTap: isUnavailable
                                  ? null
                                  : () {
                                      setState(() {
                                        selectedSeat = seat;
                                      });
                                    },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isUnavailable
                                      ? Colors.grey
                                      : selectedSeat == seat
                                          ? Colors.purple
                                          : Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  seat,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        /// SUMMARY
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Ringkasan 🎬",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),

                              const SizedBox(height: 8),

                              _info("Film", widget.title),
                              _info(
                                  "Tanggal",
                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                              _info("Waktu", selectedTime ?? "-"),
                              _info("Kursi", selectedSeat ?? "-"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// BUTTON
                        GestureDetector(
                          onTap: _bookTicket,
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.purple, Colors.blue],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.5),
                                  blurRadius: 15,
                                )
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "BOOKING SEKARANG",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 6),
            Text(text, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        "$label: $value",
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}