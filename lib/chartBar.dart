import 'package:flutter/material.dart';

class chartBar extends StatelessWidget {
  final String label;
  final double totaltransactions;
  final double totalpercentage;

  chartBar({
    required this.label,
    required this.totalpercentage,
    required this.totaltransactions});



  @override
  Widget build(BuildContext context) {
    print('Build()  Chart Bar');
    return  LayoutBuilder(builder: (context,Constraint) {
     return Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children:[
           Container(
             height: Constraint.maxHeight * 0.15,
             padding: EdgeInsets.symmetric(horizontal: 2),
             alignment: Alignment.center,
             child: FittedBox(
                  child: Text('₹${totaltransactions.toStringAsFixed(0)}',
                   style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600) ,
                 )
             ),
           ),
           SizedBox(
               height: Constraint.maxHeight * 0.03,
           ),
           Container(
             height: Constraint.maxHeight * 0.60,
             width:15,
             child: Stack(
               children: [
                 Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     border: Border.all(color: Colors.grey,width: 1),
                     color: Colors.white,
                   ),
                 ),
                 Container(
                   alignment: Alignment.bottomCenter,
                   child: FractionallySizedBox(
                     heightFactor: totalpercentage,
                     alignment: Alignment.bottomCenter,
                     child: Container(
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.black,width: 1),
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.blue,
                       ),
                     ),
                   ),
                 )
               ],
             ),
           ),
           SizedBox(
             height: Constraint.maxHeight * 0.03,
           ),
           Container(
             height: Constraint.maxHeight * 0.12,
             child: FittedBox(
               child: Text('$label',
                 style: TextStyle(fontWeight: FontWeight.w500) ,),
             ),
           ),
         ] );
    });
  }
}
