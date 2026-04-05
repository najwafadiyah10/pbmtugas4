import 'package:flutter/material.dart';
import 'movie_detail_page.dart';

class MovieListPage extends StatefulWidget {
  final String username;
  const MovieListPage({super.key, required this.username});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<String> movies = ["Avengers: Endgame", "Parasite", "Dilan 1990"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Film")),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(movies[index],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailPage(
                      title: movies[index],
                      description:
                          "Film ${movies[index]} adalah film populer dengan cerita menarik.",
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
