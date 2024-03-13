part of 'chat_bloc.dart';

abstract class ChatEvent {}

final class ChatNewMessageEvent extends ChatEvent {
  final String newChat;

  ChatNewMessageEvent({required this.newChat});
}
