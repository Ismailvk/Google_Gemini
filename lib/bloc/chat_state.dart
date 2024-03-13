part of 'chat_bloc.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccessState extends ChatState {
  final List<ChatMessageModel> message;

  ChatSuccessState({required this.message});
}
