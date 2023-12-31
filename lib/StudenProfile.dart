// ignore_for_file: file_names, non_constant_identifier_names, duplicate_ignore
import 'package:flutter/material.dart' show Alignment, AppBar, AssetImage, Border, BorderRadius, BoxDecoration, BuildContext, Center, Color, Colors, Column, Container, CrossAxisAlignment, DataCell, DataColumn, DataRow, DataTable, DecorationImage, DefaultTabController, EdgeInsets, FlexColumnWidth, FontWeight, Icon, IconThemeData, Icons, IntrinsicColumnWidth, Key, ListView, MainAxisAlignment, Padding, Positioned, Scaffold, SizedBox, Stack, State, StatefulWidget, Tab, TabBar, TabBarView, Table, TableBorder, TableCell, TableCellVerticalAlignment, TableColumnWidth, TableRow, Text, TextStyle, Widget;
class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  // ignore: non_constant_identifier_names
  List AcademicInfo =["Institution","Board/Training","Pass Year","Symbol Number","Percentage","Division / Grade","Major Subject","Remark"];
  List sscInfo = ["SSC","COMILLA","2017","","","4.05","SCIENCE",""];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  color: Colors.blue,
                ),
                Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: const DecorationImage(image:AssetImage("assets/mypic.jpg")),
                          border: Border.all(color: Colors.white,),
                          borderRadius: BorderRadius.circular(100)
                      ),
                )),
                Positioned(
                  top: 80,
                    left: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("RAIHAN HOSSAIN",style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                ),),
                        Text("Reg. No.: 111121017",style: TextStyle(
                            color: Colors.white70,
                        )),
                        Text("3ND SEMESTER (CSE)",style: TextStyle(
                            color: Colors.white70,
                        )),
                        Text("01863995432,",style: TextStyle(
                            color: Colors.white70,
                        ))
                      ],
                    ))

              ],
            ),
            const TabBar( unselectedLabelColor: Colors.black26,
                automaticIndicatorColorAdjustment: true,
                isScrollable: true,
                tabs: [
              Tab(
                text: "Profile",
                icon: Icon(Icons.person),
              ),
              Tab(
                text: "Academic",
                icon: Icon(Icons.account_balance_outlined),
              ),Tab(
                text: "Documents",
                icon: Icon(Icons.account_balance_wallet_sharp),
              ),Tab(
                text: "Notes",
                icon: Icon(Icons.account_balance_wallet_sharp),
              ),Tab(
                text: "Login Access",
                icon: Icon(Icons.key_rounded),
              ),
            ]),
            SizedBox(
              height: 400,
              child: TabBarView(children: [
                ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          const Text("REGISTRATION DETAIL",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              border: TableBorder.all(color: Colors.black26),
                              columnWidths: const <int, TableColumnWidth>{
                                0: IntrinsicColumnWidth(),
                                1: FlexColumnWidth(),
                                2: IntrinsicColumnWidth(),
                                3:FlexColumnWidth(),
                              },
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                OurTableRow(FirstTitle: "Faculty :",frstContent: "B.SC IN COMPUTER SCIENCE & ENGINEERING (CSE)",SecondTitle: "Semester :",SecondConter: "3ND SEMESTER (CSE)"),
                                OurTableRow(FirstTitle: "Reg. No. :",frstContent: "111121017",SecondTitle: "Reg. Date :",SecondConter: "13/03/2021"),
                                OurTableRow(FirstTitle: "DOB :",frstContent: "06/06/2001",SecondTitle: "Gender :",SecondConter: "MALE"),
                                OurTableRow(FirstTitle: "Nationality :",frstContent: "BANGLADESHI",SecondTitle: "Mother Tongue :",SecondConter: "BANGLA"),
                                OurTableRow(FirstTitle: "E-mail :",frstContent: "cse111121017@ccnust.edu.bd",SecondTitle: "Mobile No :",SecondConter: "01863995432"),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    Center(
                      child: DataTable(
                        columnSpacing: 200,
                          columns: const [
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),
                          ],
                          rows: List.generate(8, (index) => DataRow(cells: [
                            DataCell(Text(AcademicInfo[index])),
                            DataCell(Text(sscInfo[index])),
                          ]))
                    ),),
                  ],
                ),
                const Center(
                  child: Text("It's rainy here"),
                ),const Center(
                  child: Text("It's sunny  here"),
                ),const Center(
                  child: Text("It's sunny  here"),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  TableRow OurTableRow({FirstTitle,frstContent,SecondTitle,SecondConter}) {
    return TableRow(
                            children: <Widget>[
                              Container(alignment: Alignment.centerRight,
                                padding: const EdgeInsets.all(8.0),
                                color: const Color.fromRGBO(237,243,244,1),
                                child: Text(FirstTitle,style: bluetextcolor,),),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(frstContent),
                                )
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.centerRight,
                                color: const Color.fromRGBO(237,243,244,1),
                                child: Text(SecondTitle,style: bluetextcolor,),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(SecondConter),
                                )
                              )
                            ],

                          );
  }

  TextStyle get bluetextcolor {
    return const TextStyle(
                                  color: Color(-12951921)
                                );
  }
}
