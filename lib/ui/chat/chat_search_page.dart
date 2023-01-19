import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/element/loading_screen.dart';
import 'package:link_up/get_controller/ChatController.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/model/SoulMateModel.dart';
import 'package:link_up/model/user_model.dart';
import 'chat_message_page.dart';

class ChatSearchPage extends StatefulWidget {
  final UserModel endUser;

  const ChatSearchPage({Key? key, required this.endUser}) : super(key: key);
  @override
  _ChatSearchPageState createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  AuthController authController = Get.find(tag: AuthController().toString());
  ChatController chatController = Get.find(tag: ChatController().toString());

  TextEditingController _searchController = new TextEditingController();
  bool _isInAsyncCall = true, _isSearchIcon = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<SoulMateModel> searchList = [];

  Future<void> initialSoulMate() async {
    int index = 0;
    await db
        .collection('users')
        .orderBy('firstname', descending: false)
        .limit(10)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc.id != authController.user!.value.uid) {
          setState(() {
            searchList.insert(
                index,
                SoulMateModel(
                  uid: doc.id,
                  avatar: doc.data()['avatar'],
                  firstname: doc.data()['firstname'],
                  lastname: doc.data()['lastname'],
                  country: doc.data()['country'],
                  phone: doc.data()['phone'],
                  gender: doc.data()['gender'],
                  age: doc.data()['birthday'],
                  job: doc.data()['job'],
                ));

            if (searchList.length == querySnapshot.docs.length - 1) {
              _isInAsyncCall = false;
            }
          });
          index++;
        }
      });
    });
  }

  Future<void> searchSoulMate(value) async {
    searchList.clear();
    int index = 0;
    await db
        .collection('users')
        .orderBy('firstname', descending: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if ((doc.data()['firstname'].toString().toLowerCase().contains(value) ||
                doc
                    .data()['lastname']
                    .toString()
                    .toLowerCase()
                    .contains(value)) &&
            doc.id != authController.user!.value.uid) {
          setState(() {
            searchList.insert(
                index,
                SoulMateModel(
                  uid: doc.id,
                  avatar: doc.data()['avatar'],
                  firstname: doc.data()['firstname'],
                  lastname: doc.data()['lastname'],
                  country: doc.data()['country'],
                  phone: doc.data()['phone'],
                  gender: doc.data()['gender'],
                  age: doc.data()['birthday'],
                  job: doc.data()['job'],
                ));
          });
          index++;
        }
      });
    });
  }

  @override
  void initState() {
    initialSoulMate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: authController,
        builder: (_) {
          return Scaffold(
            body: Container(
              width: width,
              height: height,
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.lightBlue[600],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        child: Container(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutePath.chat_home_page);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          cursorColor: Colors.white,
                          decoration: new InputDecoration(
                            suffixIcon: _isSearchIcon
                                ? IconButton(
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {
                                        _isSearchIcon = false;
                                      });
                                    },
                                  )
                                : null,
                            hintText: 'search'.tr,
                            hintStyle: TextStyle(
                                fontSize: 30,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.bold),
                          ),
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          onSubmitted: (value) {
                            searchSoulMate(value);
                          },
                          onChanged: (value) {
                            if (value.length >= 1) {
                              setState(() {
                                _isSearchIcon = true;
                              });
                            }
                            // searchSoulMate(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _isInAsyncCall
                      ? LoadingScreen()
                      : Container(
                          height: height * 0.75,
                          child: ListView.builder(
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black26,
                                              width: 0.5))),
                                  child: ListTile(
                                    leading: searchList[index].avatar != null
                                        ? Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black12,
                                              image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    searchList[index].avatar),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 45,
                                            height: 45,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black12,
                                            ),
                                            child: Text(
                                              searchList[index].firstname[0] +
                                                  searchList[index].lastname[0],
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  color: Colors.blue[700],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                    title: Text(
                                      searchList[index].firstname +
                                          ' ' +
                                          searchList[index].lastname,
                                    ),
                                    subtitle: Text(searchList[index].job != null
                                        ? searchList[index].job
                                        : ''),
                                    onTap: () {
                                      String chatID = chatController.makeChatId(
                                          authController.user!.value.uid,
                                          searchList[index].uid);
                                      Navigator.pushNamed(
                                          context, RoutePath.chat_message_page,
                                          arguments: {'end_user_id'});
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatMessagePage(
                                                  endUserID:
                                                      searchList[index].uid,
                                                  endUserName: searchList[index]
                                                          .firstname +
                                                      ' ' +
                                                      searchList[index]
                                                          .lastname,
                                                  chatID: chatID,
                                                )),
                                      );
                                    },
                                  ),
                                );
                              }),
                        ),
                ),
              ]),
            ),
          );
        });
  }
}
