import 'package:cubik_app/providers/newscubit.dart';
import 'package:cubik_app/providers/newsstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/news_slider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Home'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => NewsCubit()..fetchNews(),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return ListTile(
                    leading: Image.network(
                      article.urlToImage,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(article.title),
                    subtitle: Text(article.description),
                    onTap: () {
                      // Acción al tocar una noticia
                    },
                  );
                },
              );
            } else if (state is NewsError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('Sin noticias disponibles'));
          },
        ),
      ),
    );
  }
}