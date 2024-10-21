import 'package:chatapp/components/text_field.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String reveiverUserID;
  const ChatPage({super.key,required this.receiverUserEmail,required this.reveiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageControler = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async{
    if(_messageControler.text.isNotEmpty){
      await chatService.sendMessage(widget.reveiverUserID, _messageControler.text);
      _messageControler.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail),),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput(){
    return Row(
      children: [
        Expanded(
            child: MyTextField(
                controller: _messageControler,
                hintText: "Nhập tin nhắn",
                odscureText: false,
            ),
        ),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 40,
            )
        ),
      ],
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data()! as Map<String,dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
      ?Alignment.centerRight
      :Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message']),
        ],
      ),
    );

  }

  Widget _buildMessageList(){
    return StreamBuilder(
        stream: chatService.getMessage(
            widget.reveiverUserID,
            _firebaseAuth.currentUser!.uid,
        ),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text('Error${snapshot.error}');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        }
    );
  }

}
