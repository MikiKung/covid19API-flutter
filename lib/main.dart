import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(Covid());
}

class Covid extends StatefulWidget {
  const Covid({Key? key}) : super(key: key);

  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  late Map<String, dynamic> covid;
  bool loading = false;
  bool moreInfo = true;

  void fetch() async {
    final response = await http.get(
        Uri.parse("https://static.easysunday.com/covid-19/getTodayCases.json"));
    covid = jsonDecode(response.body);
    setState(() {
      loading = !loading;
    });
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal[200],
        body: SafeArea(
          child: SingleChildScrollView(
            child: loading
                ? Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Loading",
                              style: GoogleFonts.rubik(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        width: 200,
                        height: 200,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Header(covid: covid),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: Text(
                                          "ผู้ป่วยที่รักษาหายวันนี้",
                                          style: GoogleFonts.mitr(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        covid["todayRecovered"].toString(),
                                        style: GoogleFonts.rubik(
                                            fontSize: 40, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: Text(
                                          "ผู้ป่วยที่ติดเพิ่มวันนี้",
                                          style: GoogleFonts.mitr(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        covid["todayCases"].toString(),
                                        style: GoogleFonts.rubik(
                                            fontSize: 40, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25, left: 50, right: 50),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          width: double.infinity,
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ผู้ติดรวมทั้งหมด",
                                  style: GoogleFonts.mitr(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  covid["cases"].toString(),
                                  style: GoogleFonts.rubik(
                                      fontSize: 25, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25, left: 50, right: 50),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20)),
                          width: double.infinity,
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "รักษาเเล้วทั้งหมด",
                                  style: GoogleFonts.mitr(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  covid["recovered"].toString(),
                                  style: GoogleFonts.rubik(
                                      fontSize: 25, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      moreInfo
                          // ignore: dead_code
                          ? Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    moreInfo = !moreInfo;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 35,
                                  width: 160,
                                  child: Center(
                                    child: Text("ดูเพิ่มเติม",
                                        style: GoogleFonts.mitr(
                                            fontSize: 13, color: Colors.white)),
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 25, left: 50, right: 50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: double.infinity,
                                    height: 70,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ยอดผู้เสียชีวิต",
                                            style: GoogleFonts.mitr(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            covid["deaths"].toString(),
                                            style: GoogleFonts.rubik(
                                                fontSize: 25,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 25, left: 50, right: 50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.teal[300],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: double.infinity,
                                    height: 70,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "กำลังรักษาอยู่",
                                            style: GoogleFonts.mitr(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            covid["active"].toString(),
                                            style: GoogleFonts.rubik(
                                                fontSize: 25,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 25, left: 50, right: 50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: double.infinity,
                                    height: 70,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ผู้ป่วยอาการหนัก",
                                            style: GoogleFonts.mitr(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            covid["critical"].toString(),
                                            style: GoogleFonts.rubik(
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25, right: 5),
                                      child: Text(
                                        covid["DevBy"] + " & Miki",
                                        style: GoogleFonts.rubik(fontSize: 12,color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final Map<String, dynamic> covid;

  Header({Key? key, required this.covid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
              bottomLeft:
                  Radius.circular(MediaQuery.of(context).size.width * 0.07),
              bottomRight:
                  Radius.circular(MediaQuery.of(context).size.width * 0.07))),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      covid["UpdateDate"],
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    Text(
                      covid["continent"],
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Text(
              "ประเทศ",
              style: GoogleFonts.rubik(fontSize: 12, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ThaiFlat(),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Center(
                    child: Text(
                  covid["country"],
                  style: GoogleFonts.rubik(fontSize: 32, color: Colors.white),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ThaiFlat extends StatelessWidget {
  const ThaiFlat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.red,
        ),
        width: 45,
        height: 45,
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Flag_of_Thailand_%28non-standard_colours%29.svg/640px-Flag_of_Thailand_%28non-standard_colours%29.svg.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
