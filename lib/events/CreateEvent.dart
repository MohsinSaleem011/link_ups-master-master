import 'package:flutter/material.dart';

class CreateEvent extends StatelessWidget {
  // const CreateEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Group 163959.png"),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Text(
                              "Create Event",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset("assets/search-normal.png"),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset("assets/+ (2).png"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Upload Cover Image",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/Ellipse 2139.png"))),
                        child: Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 56, 171, 216),
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/Ellipse 2139.png"))),
                        child: Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 56, 171, 216),
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/Ellipse 2139.png"))),
                        child: Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 56, 171, 216),
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/Ellipse 2139.png"))),
                        child: Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 56, 171, 216),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Largename('Enter Name'),
                SizedBox(
                  height: 10,
                ),
                smallname('Toyota'),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Largename('Event Category'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    smallname('Coorporate'),
                    SizedBox(
                      width: 220,
                    ),
                    Image.asset("assets/Polygon 10.png")
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Largename("Venu Address"),
                SizedBox(
                  height: 10,
                ),
                smallname("Address ..............."),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Largename("Event Type"),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: Color.fromARGB(255, 56, 171, 216),
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Public Event',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 12,
                            color: Color.fromARGB(255, 154, 154, 154)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.circle_outlined,
                        color: Color.fromARGB(255, 56, 171, 216),
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Private Event',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 12,
                            color: Color.fromARGB(255, 154, 154, 154)),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Largename("Price"),
                SizedBox(
                  height: 10,
                ),
                smallname("\$500"),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Largename('Date'),
                SizedBox(
                  height: 10,
                ),
                smallname('----'),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Largename("Time"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    smallname("Start Time"),
                    SizedBox(
                      width: 100,
                    ),
                    smallname("End Time"),
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 317,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Color.fromRGBO(56, 171, 216, 1)),
                      onPressed: () {},
                      child: Text(
                        "PUBLISH",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding smallname(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 12,
                color: Color.fromARGB(255, 154, 154, 154)),
          ),
        ],
      ),
    );
  }

  Padding Largename(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
