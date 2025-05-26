import 'package:dummmyfeelz/secrets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

  Future<String> getResponse(String prompt) async {
    final formattedPrompt = 'Based on someone feeling "$prompt", write them something heartfelt to cheer them up.You dont have to repeat the prompt. It can be a short story, quote, or a funny line. Avoid dad jokes and be as authentic and human as possible. Make it relatable and emotional and also provide emojis. If a user prompts using a different language, respond with the same language since they might not understand english  .';
    final response = await model.generateContent([Content.text(formattedPrompt)]);
    return response.text ?? '';
  }
}