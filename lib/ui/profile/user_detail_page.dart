import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:link_up/ui/home_page.dart';

import '../../get_controller/ChatController.dart';
import '../../model/user_model.dart';

class UserDetailPage extends StatefulWidget {
  final UserModel endUser;
  UserDetailPage({required this.endUser});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    // AuthController authController = Get.find(tag: AuthController().toString());
    AuthController authController = Get.find(tag: AuthController().toString());

    ChatController chatController = Get.find(tag: ChatController().toString());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    imagePickerDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            // shape:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // insetPadding: EdgeInsets.all(19),
            child: Container(
              width: 190,
              height: 250,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white
                  //
                  ),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 148),
                  child: Image.asset(
                    "assets/image/popup.jpg",
                    width: 320,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 58),
                  child: Text(
                    "Upload Photos from",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.folder,
                              size: 50,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              authController.getImage('gallery');
                            },
                          ),
                          Text(
                            // 'browse_image'.tr,
                            'Your Photos',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.camera_alt,
                              size: 50,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              authController.getImage('camera');
                            },
                          ),
                          Text(
                            // 'take_photo'.tr,
                            'Camera',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Container(
              //       height: 100,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         shape: BoxShape.rectangle,
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.blue,
              //         image: DecorationImage(
              //             image: AssetImage("assets/image/hjhhjhj.png"),
              //             fit: BoxFit.cover),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.only(top: 10, left: 35),
              //         child: Text(
              //           "Upload Photos from",
              //          style: TextStyle(color: Colors.white, fontSize: 16),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Column(
              //           children: [
              //             GestureDetector(
              //               child: Icon(
              //                 Icons.folder,
              //                 size: 50,
              //               ),
              //               onTap: () {
              //                 Navigator.pop(context);
              //                 authController.getImage('gallery');
              //               },
              //             ),
              //             Text(
              //               // 'browse_image'.tr,
              //               'Your Photos',
              //              style: TextStyle(color: Colors.black),
              //             )
              //           ],
              //         ),
              //         SizedBox(
              //           width: 50,
              //         ),
              //         Column(
              //           children: [
              //             GestureDetector(
              //               child: Icon(
              //                 Icons.camera_alt,
              //                 size: 50,
              //               ),
              //               onTap: () {
              //                 Navigator.pop(context);
              //                 authController.getImage('camera');
              //               },
              //             ),
              //             Text(
              //               // 'take_photo'.tr,
              //               'Camera',
              //              style: TextStyle(color: Colors.black),
              //             )
              //           ],
              //         ),
              //       ],
              //     )
              //   ],
              // ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 218,
              width: double.infinity,
              color: Color.fromARGB(255, 56, 171, 216),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${widget.endUser.avatar}"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Color.fromARGB(255, 56, 171, 216), BlendMode.color),
                    opacity: 150,
                  ),
                ),
              ),
            ),
          ),

          // Column(
          //   children: [
          // Container(
          //   height: 218,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(
          //         "assets/Group 163959 (2).png",
          //       ),
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          //   child: Container(
          //     height: 200,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: NetworkImage("${widget.endUser.avatar}"),
          //         fit: BoxFit.fill,
          //         colorFilter: ColorFilter.mode(
          //             Color.fromARGB(255, 56, 171, 216), BlendMode.color),
          //         opacity: 150,
          //       ),
          //     ),
          //   ),
          // ),
          //   ],
          // ),
          ListView(
            children: [
              Column(
                children: [
                  // Image.asset("assets/image/Vector Smart Object 2 (1).png"),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: Image.network(
              //     "${widget.endUser.avatar}",
              //     height: 150,
              //     width: 150,
              //   ),
              // ),
              CircleAvatar(
                radius: 70,
                child: Container(
                  height: 200,
                  width: 140,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: NetworkImage(widget.endUser.avatar.toString()),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // Container(
              //   height: 100,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     color: Colors.amber,
              //     borderRadius: BorderRadius.circular(50),
              //     image: DecorationImage(
              //       image: NetworkImage(widget.endUser.avatar.toString()),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.endUser.firstName} ${widget.endUser.lastName}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 56, 171, 216),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.endUser.age}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 26,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 56, 171, 216)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/image/male-gender (1).png"),
                            Text(
                              "Straight Man",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 26,
                        width: 157,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 56, 171, 216)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/image/distance (1).png"),
                            Text(
                              "${widget.endUser.country}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 26,
                    width: 137,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          width: 1.5, color: Color.fromARGB(255, 56, 171, 216)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/image/location(4) (3).png"),
                        Text(
                          "53 Miles away",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "Photos",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Image.asset("assets/image/Group 163989 (3).png"),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 56, 171, 216),
                      borderRadius: BorderRadius.circular(150),
                      image: DecorationImage(
                        image:
                            NetworkImage(widget.endUser.morePhotos.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Why I am here",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.endUser.whyarewehere,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "About Me",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.endUser.aboutMe,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),

                  Text(
                    "What City Do You Live in",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 24,
                    width: 79,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.endUser.newCity1,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "Interests",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.endUser.interests.toString()),
                        // Container(
                        //   height: 23,
                        //   width: 110,
                        //   decoration: BoxDecoration(
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(9),
                        //     border: Border.all(
                        //         width: 1.5,
                        //         color: Color.fromARGB(255, 56, 171, 216)),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Text(
                        //         "Photography",
                        //        style: TextStyle(fontSize: 12),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   height: 24,
                        //   width: 79,
                        //   decoration: BoxDecoration(
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(9),
                        //     border: Border.all(
                        //         width: 1.5,
                        //         color: Color.fromARGB(255, 56, 171, 216)),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Text(
                        //         "Cooking",
                        //        style: TextStyle(fontSize: 12),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   height: 24,
                        //   width: 79,
                        //   decoration: BoxDecoration(
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(9),
                        //     border: Border.all(
                        //         width: 1.5,
                        //         color: Color.fromARGB(255, 56, 171, 216)),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Text(
                        //         "Dancing",
                        //        style: TextStyle(fontSize: 12),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   height: 24,
                        //   width: 86,
                        //   decoration: BoxDecoration(
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(9),
                        //     border: Border.all(
                        //         width: 1.5,
                        //         color: Color.fromARGB(255, 56, 171, 216)),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Text(
                        //         "Shopping",
                        //        style: TextStyle(fontSize: 12),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),

                  Text(
                    "Job Title",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 24,
                    width: 79,
                    // decoration: BoxDecoration(
                    //   color: Colors.transparent,
                    //   borderRadius: BorderRadius.circular(9),
                    //   border: Border.all(
                    //       width: 1.5, color: Color.fromARGB(255, 56, 171, 216)),
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.endUser.job,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "University",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 24,
                    width: 79,
                    // decoration: BoxDecoration(
                    //   color: Colors.transparent,
                    //   borderRadius: BorderRadius.circular(9),
                    //   border: Border.all(
                    //       width: 1.5, color: Color.fromARGB(255, 56, 171, 216)),
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.endUser.university,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.to(HomePage());
                          },
                          child: Image.asset("assets/image/Group 4 (1).png")),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/image/Group 5 (1).png"),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/image/Group 164006 (1).png"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 4, size.height - 40, size.width / 2, size.height - 20)
      ..quadraticBezierTo(
          3 / 4 * size.width, size.height, size.width, size.height - 30)
      ..lineTo(size.width, 0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
