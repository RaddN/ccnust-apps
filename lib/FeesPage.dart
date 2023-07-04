import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class FeesPage extends StatefulWidget {

  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Center(child: Text("Payment History",style: bluetextcolor(fontsize: 20.0)),),
          SizedBox(height: 5,),
          Divider(),
          SizedBox(height: 5,),
          Table(
            border: TableBorder.all(color: Colors.black26),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: <Widget>[
                  Container(alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    color: Color.fromRGBO(237,243,244,1),
                    child: Text("Semester/Section",style: bluetextcolor(fontsize: 16.0),),),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text("Paid",style: bluetextcolor(fontsize: 16.0),),
                    color: Color.fromRGBO(237,243,244,1),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text("Remark",style: bluetextcolor(fontsize: 16.0),),
                    color: Color.fromRGBO(237,243,244,1),
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
                    child: Text("Total",style: TextStyle(
                      color: Colors.white
                    ),),),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text("66500",style: bluetextcolor(fontsize: 16.0),),
                    color: Color.fromRGBO(237,243,244,1),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text("Remark",style: bluetextcolor(fontsize: 16.0),),
                    color: Color.fromRGBO(237,243,244,1),
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
          ),)
      ],

    );
  }
  TextStyle bluetextcolor({fontsize}) {
    return TextStyle(
        color: Color(-12951921),
      fontWeight: FontWeight.bold,
      fontSize: fontsize
    );
  }
}
