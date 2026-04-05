import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  final String movieTitle;
  final String date;
  final String time;
  final String seat;

  const TicketPage({
    super.key,
    required this.movieTitle,
    required this.date,
    required this.time,
    required this.seat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tiket Saya")),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("🎬 XIII Movie Ticket",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text("Film: $movieTitle",
                    style: const TextStyle(fontSize: 18)),
                Text("Tanggal: $date",
                    style: const TextStyle(fontSize: 18)),
                Text("Waktu: $time",
                    style: const TextStyle(fontSize: 18)),
                Text("Kursi: $seat",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text("Kembali ke Home"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
