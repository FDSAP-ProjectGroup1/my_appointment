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
                label: Text(suggestion),
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
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Color(0xff800000) : Colors.blue.shade500,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white),
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
      appBar: AppBar(
        title: Text('Chatbot'),
        backgroundColor: Color(0xff800000),
      ),
      body: Column(
        children: [
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
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}
