import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopsy/components/custom_action_bar.dart';
import 'package:shopsy/screens/home_page.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final SnackBar _snackBar = SnackBar(
    content: Text('Empty query please enter query to ask chatbot'),
  );

  TextEditingController queryController = TextEditingController();
  List<Map> messages = [];

  void sendQuery(String query) async {
    print(query);
    var url = Uri.parse('http://ec2-13-127-170-102.ap-south-1.compute.amazonaws.com/cgi-bin/chat.py?q=${query}');
    var response = await http.post(url);
    print('Response status code ${response.statusCode}');
    print('Response body ${response.body}');

    setState(() {
      messages.insert(0, {"data": 0, "message": response.body.toString()});
    });
  }

  @override
  Widget build(BuildContext context) {
    String query = "";
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) => messages[index]
                                  ["data"] ==
                              0
                          ? Container(
                              alignment: Alignment.centerLeft,
                              margin: (messages[index]['message'].length < 30)
                                  ? EdgeInsets.only(
                                      left: 10.0,
                                      right: MediaQuery.of(context).size.width -
                                          (messages[index]["message"]
                                                  .length
                                                  .toDouble() *
                                              12.0),
                                      top: 10.0,
                                      bottom: 10.0)
                                  : EdgeInsets.only(
                                      left: 10.0,
                                      right: 50.0,
                                      top: 10.0,
                                      bottom: 10.0),
                              padding: EdgeInsets.only(
                                top: 10.0,
                                left: 10.0,
                                bottom: 0.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                messages[index]["message"].toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.centerLeft,
                              margin: messages[index]['message'].length < 20
                                  ? EdgeInsets.only(
                                      right: 10.0,
                                      left: MediaQuery.of(context).size.width -
                                          (messages[index]["message"]
                                                  .length
                                                  .toDouble() *
                                              20.0),
                                      top: 10.0,
                                      bottom: 10.0)
                                  : EdgeInsets.only(
                                      right: 10.0,
                                      left: 50.0,
                                      top: 10.0,
                                      bottom: 10.0),
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                messages[index]["message"].toString(),
                                // textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                    ),
                  ),
                  // Divider(
                  //   height: 3.0,
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 20.0, top: 10.0, left: 10.0, right: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              query = value;
                              // sendQuery(query);
                            },
                            controller: queryController,
                            // textInputAction: widget.textInputAction,
                            onFieldSubmitted: (value) {
                              // if (queryController.text.isEmpty) {
                              // Scaffold.of(context).showSnackBar(_snackBar);
                              // } else {
                              setState(() {
                                messages.insert(0, {
                                  "data": 1,
                                  "message": queryController.text
                                });
                              });

                              sendQuery(queryController.text);
                              queryController.clear();
                              // }
                            },
                            // focusNode: widget.focusNode,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.indigo.shade300,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.indigo.shade300,
                                  width: 2.0,
                                ),
                              ),
                              hintText: "Enter query",
                            ),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                // if (queryController.text.isEmpty) {
                                // Scaffold.of(context).showSnackBar(_snackBar);
                                // } else {
                                // sendQuery(query);
                                // // }
                                setState(() {
                                  messages.insert(0, {
                                    "data": 1,
                                    "message": queryController.text
                                  });
                                });
                                sendQuery(queryController.text);
                                print(messages);
                                // queryController.clear();
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.indigo.shade300,
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomActionBar(
              hasCart: false,
              hasBackArrow: true,
              hasBackBtnAction: true,
              hasBackGround: true,
              hasTitle: false,
              hasEditAction: false,
              hasSave: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
