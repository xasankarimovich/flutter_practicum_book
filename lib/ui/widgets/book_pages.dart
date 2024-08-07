import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/all_blocs.dart';

class BookPages extends StatelessWidget {
  const BookPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilePickerBloc, FilePickerStates>(
      listener: (context, state) {
        if (state is LoadedFilePickerState) {
          if (state.file != null) {
            context
                .read<PdfToImageBloc>()
                .add(ConvertPdfToImageEvent(state.file!));
          }
        }
      },
      builder: (context, state) {
        if (state is LoadedFilePickerState) {
          return SizedBox(
            height: 250,
            child: BlocBuilder<PdfToImageBloc, PdfToImageStates>(
              builder: (context, state) {
                if (state is ErrorPdfToImageState) {
                  return const Center(
                    child: Text("Fayl yuklanishda xatolik"),
                  );
                }

                if (state is LoadingPdfToImageState ||
                    state is LoadedPdfToImageState) {
                  final files = state is LoadedPdfToImageState
                      ? state.files
                      : (state as LoadingPdfToImageState).files;

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisExtent: 100,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: files.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.memory(files[index]),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
