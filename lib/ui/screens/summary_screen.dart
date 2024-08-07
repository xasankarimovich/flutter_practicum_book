import 'package:buksam_flutter_practicum/logic/blocs/books/books_bloc.dart';
import 'package:buksam_flutter_practicum/ui/widgets/book_info_dialog.dart';
import 'package:buksam_flutter_practicum/ui/widgets/markdown_with_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/all_blocs.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<GenerativeAiBloc, GenerativeAiStates>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (state is LoadedGenerativeAiState) {
                    showDialog(
                      context: context,
                      builder: (ctx) => BookInfoDialog(book: state.book),
                    );
                  }
                },
                icon: const Icon(Icons.info),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<GenerativeAiBloc, GenerativeAiStates>(
        builder: (context, state) {
          if (state is LoadedGenerativeAiState) {
            return Column(
              children: [
                Expanded(
                  child: MarkdownWithFooter(
                    markdownData: state.book.summary,
                    footer: const Icon(Icons.star),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilledButton.icon(
                        onPressed: () {},
                        label: const Text("Audio"),
                        icon: const Icon(Icons.play_arrow),
                      ),
                      BlocBuilder<BooksBloc, BooksState>(
                        builder: (context, booksState) {
                          if (booksState is LoadingBookState) {
                            return const CircularProgressIndicator();
                          }

                          return FilledButton.icon(
                            onPressed: () {
                              context
                                  .read<BooksBloc>()
                                  .add(AddBookEvent(state.book));
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            label: const Text("Saqlash"),
                            icon: const Icon(Icons.bookmark),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(
            child: Text("Natija mavjud emas"),
          );
        },
      ),
    );
  }
}
