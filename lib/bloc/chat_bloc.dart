import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_gemini/model/chat_message.dart';
import 'package:google_gemini/repository/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(message: [])) {
    on<ChatNewMessageEvent>(chatNewMessageEvent);
  }

  List<ChatMessageModel> message = [];
  bool generate = false;

  FutureOr<void> chatNewMessageEvent(
      ChatNewMessageEvent event, Emitter<ChatState> emit) async {
    message.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.newChat)]));
    emit(ChatSuccessState(message: message));
    generate = true;
    String generatedText = await ChatRepo.chatMessage(message);
    if (generatedText.length > 0) {
      message.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSuccessState(message: message));
    }
    generate = false;
  }
}
