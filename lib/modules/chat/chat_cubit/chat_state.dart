part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitialState extends ChatState {}
class ChatAISuccessState extends ChatState {}
class ChatAIErrorState extends ChatState {}


