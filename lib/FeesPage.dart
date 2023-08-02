// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
class FeesPage extends StatefulWidget {
  const FeesPage({super.key});


  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          Center(child: Text("Payment History",style: bluetextcolor(fontsize: 20.0)),),
          const SizedBox(height: 5,),
          const Divider(),
          const SizedBox(height: 5,),
          Table(
            border: TableBorder.all(color: Colors.black26),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: <Widget>[
                  Container(alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("Semester/Section",style: bluetextcolor(fontsize: 16.0),),),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("Paid",style: bluetextcolor(fontsize: 16.0),),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("Remark",style: bluetextcolor(fontsize: 16.0),),
                  ),
                ],

              ),
              OurTableRow(frstContent: "3RD SEMESTER (CSE)",SecondConter: "18000",thirdContent:"Jannatul Ferdausi"),
              OurTableRow(frstContent: "",thirdContent: "Jannatul Ferdausi",SecondConter: "9000"),
              OurTableRow(frstContent: "",thirdContent: "Jannatul Ferdausi",SecondConter: "9000"),
              OurTableRow(frstContent: "2ND SEMESTER (CSE)",thirdContent: "Jannatul Ferdausi",SecondConter: "17999"),
              OurTableRow(frstContent: "",thirdContent: "Jannatul Ferdausi",SecondConter: "1500"),
              OurTableRow(frstContent: "",thirdContent: "Jannatul Ferdausi",SecondConter: "1500"),
              OurTableRow(frstContent: "",thirdContent: "Jannatul Ferdausi",SecondConter: "1500"),
              OurTableRow(frstContent: "",thirdContent: "Jannatul Ferdausi",SecondConter: "1500"),
              OurTableRow(frstContent: "",thirdContent: "Jannatul Ferdausi",SecondConter: "1500"),
              OurTableRow(frstContent: "",thirdContent: "Jannatul Ferdausi",SecondConter: "1500"),
              TableRow(
                children: <Widget>[
                  Container(alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.redAccent,
                    child: const Text("Total",style: TextStyle(
                      color: Colors.white
                    ),),),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("66500",style: bluetextcolor(fontsize: 16.0),),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: const Color.fromRGBO(237,243,244,1),
                    child: Text("Remark",style: bluetextcolor(fontsize: 16.0),),
                  ),
                ],

              ),
            ],
          ),
        ],
      ),
    );

  }
  TableRow OurTableRow({frstContent,SecondTitle,SecondConter,thirdContent}) {
    return TableRow(
      children: <Widget>[
        TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(frstContent),
            )
        ),
        TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(SecondConter),
            )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
              child: Text(thirdContent)
          ),)
      ],

    );
  }
  TextStyle bluetextcolor({fontsize}) {
    return TextStyle(
        color: const Color(-12951921),
      fontWeight: FontWeight.bold,
      fontSize: fontsize
    );
  }
}
