import'dart:io';
import './adaptive_Flatbutton.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import './User_transections.dart';


class NewTransactions extends StatefulWidget {
  //const NewTransections({Key? key}) : super(key: key);

 Function NewTransaction;
 NewTransactions(this.NewTransaction);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
 final amountController = TextEditingController();
 final NameController = TextEditingController();
 DateTime? selecteddate;

 void SubmitedDate() {
   final EnteredName = NameController.text;
   final EnteredAmount = double.parse(amountController.text);

   if(EnteredName.isEmpty ||  EnteredAmount<0 || selecteddate == null) {
     return null;
   }

   widget.NewTransaction(
       EnteredName,
       EnteredAmount,
       selecteddate
   );

   Navigator.of(context).pop();

 }

  void presentDatePicker() {
     showDatePicker(
         context: context,
         initialDate: DateTime.now(),
         firstDate: DateTime(2022),
         lastDate: DateTime.now(),
     ).then((pickedDate)  {
       if(pickedDate==null){
         return Navigator.of(context).pop();
       }
       setState((){
        selecteddate =  pickedDate;
       });

     });
  }

  @override
  Widget build(BuildContext context) {
    print('Build()  New Transaction');
    return  SafeArea(
      child: Column(
                children: [
                  Container(
                    margin:EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: 10,
                        ),

                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Name',
                      ),
                      controller: NameController,
                      textCapitalization: TextCapitalization.sentences,
                     // keyboardAppearance: Brightness.light,

                    ),
                  ),
                  Container(

                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                        hintText: 'Enter Amount',
                      ),
                      controller: amountController,
                      keyboardType: TextInputType.number,

                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(selecteddate==null?'Please Choose date' : formatDate(selecteddate!, [dd,'/',MM,'/','/',yyyy])),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child:Platform.isIOS ?
                          CupertinoButton(
                            child:  Text('Choose',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            onPressed: presentDatePicker,
                          ) :TextButton(
                            child: Text('Choose',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            onPressed: presentDatePicker,
                          ),
                        ),
                        //adaptiveFlatButton(buttonName: 'Choose', onClick: presentDatePicker)
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed:SubmitedDate,

                      child: Text('Add')
                  ),

                ],



      ),
    );
  }
}
