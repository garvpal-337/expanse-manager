import 'package:flutter/material.dart';
import './transections.dart';
import 'package:date_format/date_format.dart';
import './chartBar.dart';

class Chart extends StatelessWidget {

  final List<Transaction> NewTransaction;
  Chart(this.NewTransaction);

  List<Map<String,Object>> get BarsList {

    return List.generate(7, (index)  {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalsum=0.0;
      for(var i=0 ; i< NewTransaction.length ; i++){
        if(NewTransaction[i].Date.day == weekDay.day &&
           NewTransaction[i].Date.month == weekDay.month &&
           NewTransaction[i].Date.year == weekDay.year){
          totalsum += NewTransaction[i].Amount;
        }
      }


      return {'day':formatDate(weekDay, [D]).substring(0,3),'amount':totalsum};


    }).reversed.toList();

  }
   double get totalspendings {
    return BarsList.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build()  Chart');
   // print(BarsList);
    return   Container(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 10,
        shadowColor: Colors.blue.withOpacity(0.3),
        child: Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
         // margin: EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue,width: 2),
            color: Colors.lightBlue.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: BarsList.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: chartBar(
                    label: data['day'] as String,
                    totalpercentage: totalspendings == 0.0 ? 0.0 :(data['amount'] as double )/   totalspendings,
                    totaltransactions: data['amount'] as double
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
