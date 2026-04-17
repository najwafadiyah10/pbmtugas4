import 'package:flutter/material.dart';
import 'history.dart'; // ambil list bookingHistory

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();
  int _selectedStars = 0;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pemesanan"),
        backgroundColor: Colors.deepPurple,
      ),
      body: bookingHistory.isEmpty
          ? const Center(
              child: Text("Belum ada riwayat pemesanan"),
            )
          : ListView.builder(
              itemCount: bookingHistory.length,
              itemBuilder: (context, index) {
                final item = bookingHistory[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.movie, color: Colors.deepPurple),
                    title: Text(item["movie"]!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["date"]} • ${item["time"]} • Kursi ${item["seat"]}",
                        ),
                        if (item.containsKey("review"))
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "⭐ ${item["stars"]} | ${item["review"]}",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        _showReviewDialog(context, item["movie"]!);
                      },
                      child: const Text("Review"),
                    ),
                  ),
                );
              },
            ),
    );
  }

  /// Dialog form review
  void _showReviewDialog(BuildContext context, String movieTitle) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Review untuk $movieTitle"),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// PILIH BINTANG
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            Icons.star,
                            color: index < _selectedStars
                                ? Colors.amber // aktif
                                : Colors.grey, // belum dipilih
                            size: 32,
                          ),
                          onPressed: () {
                            setStateDialog(() {
                              _selectedStars = index + 1;
                            });
                          },
                        );
                      }),
                    ),

                    /// INPUT REVIEW
                    TextFormField(
                      controller: _reviewController,
                      decoration: const InputDecoration(
                        labelText: "Tulis review kamu",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Review tidak boleh kosong";
                        } else if (value.length < 5) {
                          return "Review minimal 5 huruf";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _reviewController.clear();
                    _selectedStars = 0;
                  },
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedStars == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Pilih jumlah bintang dulu ya ⭐"),
                          ),
                        );
                        return;
                      }

                      // Simpan review ke item yang dipilih
                      setState(() {
                        bookingHistory[_selectedIndex!]["review"] =
                            _reviewController.text;
                        bookingHistory[_selectedIndex!]["stars"] =
                            _selectedStars.toString();
                      });

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Review untuk $movieTitle berhasil disimpan! ⭐$_selectedStars"),
                        ),
                      );

                      _reviewController.clear();
                      _selectedStars = 0;
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
