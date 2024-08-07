import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:buksam_flutter_practicum/core/utils/extensions.dart';
import 'package:buksam_flutter_practicum/data/models/book.dart';
import 'package:buksam_flutter_practicum/core/utils/ai_constants.dart';
import 'package:buksam_flutter_practicum/core/utils/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

part 'events/generative_ai_events.dart';
part 'states/generative_ai_states.dart';

class GenerativeAiBloc extends Bloc<GenerativeAiEvents, GenerativeAiStates> {
  GenerativeAiBloc() : super(InitialGenerativeAiState()) {
    on<SummarizeAiEvent>(_summarize);
  }

  void _summarize(SummarizeAiEvent event, emit) async {
    emit(LoadingGenerativeAiState());

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: dotenv.get("API_KEY"),
      );

      List<DataPart> dataParts = [];

      for (var image in event.files) {
        dataParts.add(DataPart('image/jpeg', image));
      }

      final content = [
        Content.multi([
          TextPart(AiConstants.summarizePrompt(event.summaryLength.name)),
          // The only accepted mime types are image/*.
          ...dataParts,
        ]),
        // images
        // images
        // texts
      ];
      final response = await model.generateContent(content);

      if (response.text == null) {
        throw ("Xulosa qila olmadim");
      } else {
        final book = Book.fromJson(response.text!.clearJson);
        emit(LoadedGenerativeAiState(book));
      }
    } catch (e) {
      emit(ErrorGenerativeAiState(e.toString()));
    }
  }
}
