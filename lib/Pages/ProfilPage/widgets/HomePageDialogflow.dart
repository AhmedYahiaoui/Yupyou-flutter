import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class HomePageDialogflow extends StatefulWidget {
  HomePageDialogflow({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageDialogflow createState() =>  _HomePageDialogflow();
}

class _HomePageDialogflow extends State<HomePageDialogflow> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController =  TextEditingController();

  Widget _buildTextComposer() {
    return  IconTheme(
      data:  IconThemeData(color: Theme.of(context).accentColor),
      child:  Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child:  Row(
          children: <Widget>[
             Flexible(
              child:  TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                 InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
             Container(
              margin:  EdgeInsets.symmetric(horizontal: 4.0),
              child:  IconButton(
                  icon:  Icon(Icons.send,color:Colors.green,),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/pfe-project-notif-4d6ee945e624.json")
        .build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message =  ChatMessage(
      text: response.getMessage() ??
           CardDialogflow(response.getListMessage()[0]).title,
      name: "TreeBot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message =  ChatMessage(
      text: text,
      name: "You",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      child: Column(
          children: <Widget>[
            Flexible(
                child:  ListView.builder(
                  padding:  EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                )),
            Divider(height: 1.0),
            Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ]
      ),
    );


  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
       Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo/logoe.png'),

//            child: Text('B')
        ),
      ),
       Expanded(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Text(this.name,
                style:  TextStyle(fontWeight: FontWeight.bold)),
             Container(
              margin: const EdgeInsets.only(top: 5.0),
              child:  Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
       Expanded(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
             Text(this.name, style: Theme.of(context).textTheme.subhead),
             Container(
              margin: const EdgeInsets.only(top: 5.0),
              child:  Text(text),
            ),
          ],
        ),
      ),
       Container(
        margin: const EdgeInsets.only(left: 16.0),
        child:  CircleAvatar(

          backgroundImage: AssetImage('assets/images/userr.png'),

//          child: Text(
//              this.name[0],
//              style:  TextStyle(fontWeight: FontWeight.bold),
//            ),


        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
