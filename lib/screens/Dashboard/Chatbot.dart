import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  List<String> _messages = [];
  List<String> _suggestions = ['Hello', 'Help', 'Goodbye']; // Text suggestions
  ScrollController _scrollController = ScrollController();
  bool _shouldScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Scrolled to the bottom
      setState(() {
        _shouldScroll = false;
      });
    } else {
      setState(() {
        _shouldScroll = true;
      });
    }
  }

  void _sendMessageToChatbot(String text) async {
    _textController.clear();
    _addMessage(text, true); // Add user message

    // Simulate a delay to make it feel like the chatbot is processing the message
    await Future.delayed(Duration(seconds: 1));

    String response = await _getChatbotResponse(text);
    _addMessage(response, false); // Add chatbot response
  }

  void _addMessage(String message, bool isUserMessage) {
    setState(() {
      _messages.add(message);
      _messages.add(isUserMessage ? 'user' : 'chatbot');
    });

    if (_shouldScroll) {
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<String> _getChatbotResponse(String text) async {
    String url = 'http://192.168.0.186:8080/api/chat';
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': text}),
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData['response'];
    } else {
      return 'Error: ${response.statusCode}';
    }
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            _buildSuggestions(), // Display text suggestions
            TextField(
              controller: _textController,
              onSubmitted: _sendMessageToChatbot,
              decoration: InputDecoration(
                hintText: 'Send a message',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return Container(
      height: 60.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                _textController.text = suggestion;
              },
              child: Chip(
                padding: EdgeInsets.all(10),
                label: Text(
                  suggestion,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessage(String message, bool isUserMessage) {
    return Align(
      alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUserMessage ? Color(0xff800000) : Colors.blue.shade500,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
            width: MediaQuery.of(context).size.width,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xff800000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xff000000),
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Text(
                  "YOUR CHATBOT",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView.builder(
                  controller: _scrollController,
                  reverse: false, // Reverse the order of the list
                  padding: EdgeInsets.all(8.0),
                  itemBuilder: (_, int index) {
                    final message = _messages[index];
                    final isUserMessage = message == 'user';
                    if (isUserMessage) {
                      return _buildMessage(_messages[index - 1], isUserMessage);
                    } else {
                      return _buildMessage(message, isUserMessage);
                    }
                  },
                  itemCount: _messages.length,
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}
