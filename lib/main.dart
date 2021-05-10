import 'package:budget_manager/pages/add_budget.dart';
import 'package:budget_manager/pages/budget_detail_page.dart';
import 'package:budget_manager/services/budget_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Budget Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _amplifyConfigured = false;
  BudgetService _budgetService = BudgetService();
  List<Budget> _budgets = [];
  final currency = NumberFormat.simpleCurrency();

  @override
  void initState() {
    super.initState();
    _configureAmplify();

    // Amplify.Hub.listen([HubChannel.DataStore], (hubEvent) {
    //   print("=====>${hubEvent.eventName}");
    // });
  }

  void _configureAmplify() async {
    if (!mounted) return;

    Amplify.addPlugin(AmplifyAPI());
    // Add this in your app initialization
    AmplifyDataStore datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    Amplify.addPlugin(datastorePlugin);
    Amplify.addPlugin(AmplifyAuthCognito());

    try {
      await Amplify.configure(amplifyconfig).then((value) {
        _refreshBudgets();
      });
    } on AmplifyAlreadyConfiguredException {
      print("Amplify was already configured. Was the app restarted?");
    }
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getBudgets() async {
    _budgets = await _budgetService.getBudgets();
    setState(() {});
  }

  Future<void> _refreshBudgets() async {
    await _getBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
          onRefresh: _refreshBudgets,
          child: _budgets == null || _budgets.length == 0
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("No budgets"),
                      subtitle: Text("Add one to get started"),
                    );
                  },
                  itemCount: 1,
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return Dismissible(
                      child: ListTile(
                        title: Text(_budgets[index].name),
                        subtitle: Text(
                            "${currency.format(_budgets[index].spent)} spent of ${currency.format(_budgets[index].setAmount)}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BudgetDetailPage(
                                budget: _budgets[index],
                              ),
                            ),
                          ).whenComplete(() => _refreshBudgets());
                        },
                      ),
                      key: ObjectKey(_budgets[index].id),
                      direction: DismissDirection.endToStart,
                      resizeDuration: Duration(milliseconds: 200),
                      background: Container(
                        padding: EdgeInsets.only(right: 28.0),
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (child) {
                        _budgetService.deleteBudget(_budgets[index]);
                        setState(() {
                          _budgets.removeAt(index);
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: _budgets.length,
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AddBudgetPage(),
            ),
          ).whenComplete(() => _refreshBudgets());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
