// Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PaginaWordPress extends StatefulWidget {
  @override
  State<PaginaWordPress> createState() => _PaginaWordPress();
}

class Post {
  final String title;
  final String description;
  final String link;
  final String imageUrl;

  Post({
    required this.title,
    required this.description,
    required this.link,
    required this.imageUrl,
  });

  static stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        title: json['title']['rendered'],
        description: stripHtmlTags(json['excerpt']['rendered']),
        link: json['link'],
        imageUrl: json['featured_image_src']);
  }
}

// Servicio para obtener los posts desde la API
class PostService {
  Future<List<Post>> fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://guias.donweb.com/wp-json/wp/v2/posts'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Post> posts =
          body.map((dynamic item) => Post.fromJson(item)).toList();

      // Devolver solo los primeros 3 posts
      return posts.take(3).toList();
    } else {
      throw 'Error al cargar los posts';
    }
  }
}

class _PaginaWordPress extends State<PaginaWordPress> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = PostService().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
  child: Column(
    children: [
      Image.asset(
        'assets/images/logo-guias-donweb.png', // Ruta de tu imagen
        width: 200, // Ancho de la imagen, ajusta según sea necesario
        height: 100, // Alto de la imagen, ajusta según sea necesario
      ),
      Expanded(
        child: FutureBuilder<List<Post>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data!;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 255, 187, 187),
                    child: GestureDetector(
                      onTap: () {
                        launch(posts[index].link);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              posts[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${posts[index].description}Para visitar original, pulsa aquí.',
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                            if (posts[index].imageUrl.isNotEmpty)
                              const SizedBox(height: 10),
                              Image.network(
                                posts[index].imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height:
                                    200, // Ajusta la altura según sea necesario
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // Por defecto, muestra un indicador de carga
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    ],
  ),
),

    );
  }
}
