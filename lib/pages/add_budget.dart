import 'package:budget_manager/services/budget_service.dart';
import 'package:flutter/material.dart';

class AddBudgetPage extends StatefulWidget {
  @override
  _AddBudgetPageState createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  String _name;
  String _amount;
  BudgetService _budgetService = BudgetService();

  @override
  Widget build(BuildContext context) {
    void _createBudget(completionHandler) {
      _budgetService.createBudget(_name, double.parse(_amount),
          double.parse(_amount), 0.0, completionHandler);
    }

    Widget _showNameTextFormField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15.0, 8.0),
        child: TextFormField(
          initialValue: "",
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
            _createBudget(Navigator.of(context).pop);
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
      appBar: AppBar(
          title: Text(
        "Create Budget",
      )),
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
          _createBudget(Navigator.of(context).pop);
        },
      ),
    );
  }
}
