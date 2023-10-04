import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './transections.dart';
import './newtransection.dart';
import './Chart.dart';
import 'package:flutter/services.dart';

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
  ]);*/
  runApp(Platform.isIOS
      ? CupertinoApp(
          home: ExpensesApp(),
        )
      : MaterialApp(
          home: ExpensesApp(),
        ));
}

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  List<Transaction> _UserTransaction = [];

  List<Transaction> get recentTransactions {
    return _UserTransaction.where((tx) {
      return tx.Date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void ShowAddtxSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransactions(AddNewTransaction),
          //onTap: () {},

          behavior: HitTestBehavior.opaque,
        );
      },
      elevation: 5,
    );
  }

  void AddNewTransaction(
      String NewName, double NewAmount, DateTime Choosendate) {
    final NewTx = Transaction(
      Name: NewName,
      id: DateTime.now().toString(),
      Amount: NewAmount,
      Date: Choosendate,
    );
    setState(() {
      _UserTransaction.add(NewTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _UserTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    print('Build()  Main');

    final dynamic Appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expenses Manager'),
            trailing: Row(
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => ShowAddtxSheet(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expenses Manager'),
            centerTitle: true,
            // backgroundColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                  onPressed: () => ShowAddtxSheet(context),
                  icon: Icon(Icons.add))
            ],
          );

    List<Widget> landScapeMode(final ListOfTx) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Show Chart'),
            Switch.adaptive(
              value: showChart,
              onChanged: (bool? val) {
                setState(() {
                  showChart = val!;
                });
              },
            ),
          ],
        ),
        if (showChart)
          Container(
              height: (mediaQuery.size.height -
                      Appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.6,
              child: Chart(recentTransactions)),
        ListOfTx,
      ];
    }

    List<Widget> portraitMode(final ListOfTx) {
      return [
        Container(
            height: (mediaQuery.size.height -
                    Appbar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.25,
            child: Chart(recentTransactions)),
        ListOfTx,
      ];
    }

    final ListofTransactions = Container(
        height: (mediaQuery.size.height -
                Appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_UserTransaction, deleteTransaction));

    final pageBody = SafeArea(
      child: Container(
        child: ListView(
          children: [
            if (isLandscape) ...landScapeMode(ListofTransactions),
            if (!isLandscape) ...portraitMode(ListofTransactions),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: Appbar,
          )
        : Scaffold(
            appBar: Appbar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      ShowAddtxSheet(context);
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
