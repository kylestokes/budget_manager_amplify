import 'package:budget_manager/pages/add_budget.dart';
import 'package:budget_manager/services/budget_service.dart';
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
      title: 'Flutter Demo',
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
      await Amplify.configure(amplifyconfig).then((value) => {_getBudgets()});
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
            ? Center(
                child: Text("No budgets"),
              )
            : ListView.builder(
                itemCount: _budgets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_budgets[index].name),
                    subtitle: Text(
                        "${currency.format(_budgets[index].spent)} spent of ${currency.format(_budgets[index].setAmount)}"),
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
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
