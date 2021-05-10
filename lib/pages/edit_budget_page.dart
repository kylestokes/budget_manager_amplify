import 'package:budget_manager/models/Budget.dart';
import 'package:budget_manager/services/budget_service.dart';
import 'package:flutter/material.dart';

class EditBudgetPage extends StatefulWidget {
  EditBudgetPage({Key key, this.budget}) : super(key: key);

  final Budget budget;

  @override
  _EditBudgetPageState createState() => _EditBudgetPageState();
}

class _EditBudgetPageState extends State<EditBudgetPage> {
  String _name;
  String _amount;
  BudgetService _budgetService = BudgetService();

  @override
  void initState() {
    super.initState();

    _name = widget.budget.name;
    _amount = "${widget.budget.setAmount}";
  }

  @override
  Widget build(BuildContext context) {
    void _updateBudget(completionHandler) {
      _budgetService.updateBudget(
          widget.budget,
          _name,
          double.parse(_amount),
          widget.budget.spent,
          double.parse(_amount) - widget.budget.spent,
          completionHandler);
    }

    Widget _showNameTextFormField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15.0, 8.0),
        child: TextFormField(
          initialValue: "$_name",
          maxLines: 1,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autofocus: true,
          decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.red[300]),
            hintText: 'Name',
            hintStyle: TextStyle(color: Colors.grey),
            icon: Icon(
              Icons.gesture,
              color: Colors.grey[400],
              size: 32,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Name can\'t be empty';
            } else {
              return '';
            }
          },
          onChanged: (value) {
            setState(() {
              _name = value;
            });
          },
        ),
      );
    }

    Widget _showAmountTextFormField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15.0, 8.0),
        child: TextFormField(
          initialValue: "$_amount",
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
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _showNameTextFormField(),
                _showAmountTextFormField(),
              ],
            ),
          ));
    }

    // Swipe down to close
    return Scaffold(
      appBar: AppBar(title: Text("Edit ${widget.budget.name}")),
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
