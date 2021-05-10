import 'package:budget_manager/models/Budget.dart';
import 'package:budget_manager/pages/edit_budget_page.dart';
import 'package:budget_manager/services/budget_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetDetailPage extends StatefulWidget {
  BudgetDetailPage({Key key, this.budget}) : super(key: key);

  final Budget budget;

  @override
  _BudgetDetailPageState createState() => _BudgetDetailPageState();
}

class _BudgetDetailPageState extends State<BudgetDetailPage> {
  final currency = NumberFormat.simpleCurrency();
  BudgetService _budgetService = BudgetService();
  Budget _budget;

  @override
  void initState() {
    super.initState();
    _budget = widget.budget;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildDetailText() {
      return Padding(
        padding: const EdgeInsets.only(top: 55),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "${currency.format(_budget.spent)}",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("spent of ${currency.format(_budget.setAmount)}",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Text("${currency.format(_budget.amountLeft)}",
                    style:
                        TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("left to spend",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${_budget.name}",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBudgetPage(budget: widget.budget),
                ),
              ).then((value) {
                _budgetService
                    .getBudgetWithID(widget.budget.id)
                    .then((budgets) {
                  if (budgets.length == 1) {
                    Budget budget = budgets.first;
                    setState(() {
                      _budget = budget;
                    });
                  }
                });
              });
            },
          )
        ],
      ),
      body: _buildDetailText(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.attach_money,
          size: 28,
        ),
        elevation: 0,
        onPressed: () {},
      ),
    );
  }
}
