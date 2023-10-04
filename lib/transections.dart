import'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class TransactionList extends StatelessWidget {

  List<Transaction> transaction;
  Function deleteTx;
  TransactionList(this.transaction,this.deleteTx);


  @override
  Widget build(BuildContext context) {
    print('Build()  TransactionList');
    return  LayoutBuilder(builder: (context,constraint) {
      return Container(
        alignment: Alignment.center,
        child: transaction.isEmpty ?  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text('Not Transaction yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textBaseline: TextBaseline.ideographic,

                  ),
                ),
              ),
              SizedBox(
                height: constraint.maxHeight*0.1,
              ),
              Container(
                  alignment: Alignment.topCenter,
                  height: constraint.maxHeight * 0.5,
                  child: Image.network('https://th.bing.com/th/id/R.1bc4b7001fce78a307d650bc817b9783?rik=8pjydsuFro4MFQ&riu=http%3a%2f%2fcdn.onlinewebfonts.com%2fsvg%2fimg_435673.png&ehk=cCOKYuG3Z08Gm%2bF9b0p8breIz7kJh0QuT6T%2fryxoo7A%3d&risl=&pid=ImgRaw&r=0')),
            ]
        ) :ListView.builder(
          itemCount: transaction.length,
          itemBuilder: (ctx,index){
            return Card(
              margin: EdgeInsets.all(5),
              elevation: 6,
              child: ListTile(
                // tileColor: Colors.blue.withOpacity(0.2),
                leading:Container(
                  width: 90,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.blue,width: 2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.1)
                        )
                      ]
                  ),
                  child: FittedBox(
                    child: Text('₹${transaction[index].Amount.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),),
                  ),
                ),
                title: Text('${transaction[index].Name}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),),
                subtitle: Text('${formatDate(transaction[index].Date, [dd,'/',MM,'/',yyyy])}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),),
                trailing: MediaQuery.of(context).size.width > 450? TextButton.icon(
                    onPressed: (){
                      deleteDialogBox(context ,index);
                    },
                    icon: Icon(Icons.delete_forever_sharp,size: 30,color: Colors.black,),
                    label: Text('Delete')) : IconButton(
                  icon: Icon(Icons.delete_forever_sharp,size: 30,color: Colors.black,),
                  onPressed: (){
                   deleteDialogBox(context ,index);
                  },
                ),
                hoverColor: Colors.grey,

              ),
            );
            },
        ),
      );
    }) ;
  }

  void deleteDialogBox(BuildContext context, int num) { showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Delete transaction?'),
            ],
          ),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(

                  onPressed: () {
                    deleteTx(transaction[num].id);
                    Navigator.of(context).pop();
                  },
                  child: Text('Delete'),

                ),

                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'))

              ],
            )
          ],
        );
      });
  }

}





class Transaction{
  String Name;
  String id;
  double Amount;
  DateTime Date;
  Transaction({
    required this.Name,
    required this.id,
    required this.Amount,
    required this.Date,
  });
}