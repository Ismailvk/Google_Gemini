import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_gemini/bloc/chat_bloc.dart';
import 'package:google_gemini/model/chat_message.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController textEditingController = TextEditingController();

  ChatBloc chatBloc = ChatBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.paddingOf(context).top;
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> message =
                  (state as ChatSuccessState).message;
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/Artificial intelligence (AI).jpeg'),
                    fit: BoxFit.cover,
                    opacity: 0.4,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size, left: 20),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'G E M I N I',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: message.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            alignment: message[index].role == 'user'
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: message[index].role == 'user'
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                message[index].role == 'user'
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            message[index].parts.first.text,
                                            style:
                                                const TextStyle(fontSize: 17),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Image.network(
                                            'https://logowik.com/content/uploads/images/google-ai-gemini91216.logowik.com.webp',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                const SizedBox(width: 8),
                                message[index].role == 'user'
                                    ? const CircleAvatar(
                                        radius: 20, child: Text('You'))
                                    : Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              message[index].parts.first.text,
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                    if (chatBloc.generate)
                      Center(
                          child: Lottie.asset('assets/loader.json',
                              height: 80, width: 80)),
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: textEditingController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                    hintText: 'Type here .....'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (textEditingController.text.isNotEmpty) {
                                    String text = textEditingController.text;
                                    textEditingController.clear();
                                    chatBloc.add(
                                        ChatNewMessageEvent(newChat: text));
                                  }
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Colors.white)),
                                child:
                                    const Icon(Icons.send, color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
