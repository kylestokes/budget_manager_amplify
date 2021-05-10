import 'package:budget_manager/models/Budget.dart';
import 'package:budget_manager/services/budget_service.dart';
import 'package:flutter/material.dart';

class AddPurchasePage extends StatefulWidget {
  AddPurchasePage({Key key, this.budget}) : super(key: key);

  final Budget budget;

  @override
  _AddPurchasePageState createState() => _AddPurchasePageState();
}

class _AddPurchasePageState extends State<AddPurchasePage> {
  String _amount;
  BudgetService _budgetService = BudgetService();

  @override
  Widget build(BuildContext context) {
    void _updateBudget(completionHandler) {
      _budgetService.updateBudget(
          widget.budget,
          widget.budget.name,
          widget.budget.setAmount,
          widget.budget.spent + double.parse(_amount),
          widget.budget.setAmount - widget.budget.spent - double.parse(_amount),
          completionHandler);
    }

    Widget _showAmountTextFormField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15.0, 8.0),
        child: TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.red[300]),
            hintText: 'Amount',
            hintStyle: TextStyle(color: Colors.grey),
            icon: Icon(
              Icons.attach_money,
              color: Colors.grey[400],
              size: 32,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Amount can\'t be empty';
            } else {
              return '';
            }
          },
          onFieldSubmitted: (value) {
            _updateBudget(Navigator.of(context).pop);
          },
          onChanged: (value) {
            setState(() {
              _amount = value;
            });
          },
        ),
      );
    }

    Widget _showBody() {
      return Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: _showAmountTextFormField(),
          ));
    }

    // Swipe down to close
    return Scaffold(
      appBar: AppBar(title: Text("Add Purchase")),
      body: Stack(
        children: <Widget>[
          _showBody(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black87,
        child: Icon(Icons.check),
        onPressed: () {
          _updateBudget(Navigator.of(context).pop);
        },
      ),
    );
  }
}
