// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  final AppBar OurAppBar;
  final Drawer OurDrawer;

  const CoursesPage({super.key, required this.OurAppBar, required this.OurDrawer});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.OurAppBar,
      drawer: widget.OurDrawer,
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          Center(child: Text("B.SC IN COMPUTER SCIENCE & ENGINEERING (CSE) | 3RD SEMESTER (CSE)",style: bluetextcolor),),
          const SizedBox(height: 5,),
          const Divider(),
          const SizedBox(height: 5,),
          Table(
            border: TableBorder.all(color: Colors.black26),
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
              2: IntrinsicColumnWidth(),
              3:FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: <Widget>[
                  Container(alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("S.N.",style: bluetextcolor,),),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("COURSE TITLE",style: bluetextcolor,),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("MARKING",style: bluetextcolor,),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("INFO",style: bluetextcolor,),
                  ),
                ],

              ),
              OurTableRow(frstContent: "1",SecondConter: "DATA STRUCTURE - [CSE-107 ]",thirdContent:"FM (T) -	120\nPM (T) -	48\nFM (P) -\nPM (P) -	",fourthcontent:"Credit Hour -	3\nSubject Type -	Compulsory\nClass Type -	Theory\nTeacher/Staff -	IKBAL AHMED"),
              OurTableRow(frstContent: "2",thirdContent: "FM (T) -	120\nPM (T) -	48\nFM (P) -\nPM (P) -	",SecondConter: "DIGITAL ELECTRONICS & PULSE TECHNIQUES - [CSE-113 ]",fourthcontent:"Credit Hour -	3\nSubject Type -	Compulsory\nClass Type -	Theory\nTeacher/Staff -	MAISHA MALIHA"),
              OurTableRow(frstContent: "3",thirdContent: "FM (T) -	120\nPM (T) -	48\nFM (P) - \nPM (P) -	",SecondConter: "DIGITAL LOGIC DESIGN - [CSE-109 ]",fourthcontent:""),
              OurTableRow(frstContent: "4",thirdContent: "FM (T) -	80\nPM (T) -	32\nFM (P) - \nPM (P) -	",SecondConter: "HUMAN RESOURCE MANAGEMENT - [HUM-109(EEE) ]",fourthcontent:""),
              OurTableRow(frstContent: "5",thirdContent: "FM (T) -	120\nPM (T) -	48\nFM (P) -\nPM (P) -	",SecondConter: "NUMERICAL ANALYSIS - [CSE-111 ]",fourthcontent:""),
            ],
          ),
        ],
      ),
    );
  }
  TableRow OurTableRow({frstContent,SecondTitle,SecondConter,thirdContent,fourthcontent}) {
    return TableRow(
      children: <Widget>[
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(frstContent),
            )
        ),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(SecondConter),
            )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(thirdContent)
          ),),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(fourthcontent),
            )
        ),
      ],

    );
  }
  TextStyle get bluetextcolor {
    return const TextStyle(
        color: Color(-12951921),
      fontWeight: FontWeight.bold
    );
  }
}
