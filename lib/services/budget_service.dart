import 'package:amplify_flutter/amplify.dart';
import 'package:budget_manager/models/Budget.dart';

class BudgetService {
  void createBudget(String name, double amountLeft, double setAmount,
      double spent, completionHandler) async {
    final budget = Budget(
        name: name, amountLeft: amountLeft, setAmount: setAmount, spent: spent);
    await Amplify.DataStore.save(budget).then((value) => completionHandler());
  }

  void updateBudget(Budget budget, String name, double setAmount, double spent,
      double amountLeft, completionHandler) async {
    final updatedBudget = budget.copyWith(
        name: name, setAmount: setAmount, spent: spent, amountLeft: amountLeft);
    await Amplify.DataStore.save(updatedBudget)
        .then((value) => completionHandler());
  }

  void deleteBudget(Budget budget) async {
    await Amplify.DataStore.delete(budget);
  }

  Future<List<Budget>> getBudgets() async {
    try {
      // List<Budget> budgets = await Amplify.DataStore.query(Budget.classType,
      //     where: Budget.AMOUNTLEFT.lt(100).and(Budget.SPENT.gt(1000)),
      //     sortBy: [Budget.SETAMOUNT.descending()]);
      List<Budget> budgets = await Amplify.DataStore.query(Budget.classType);
      return budgets;
    } catch (e) {
      print("Could not query DataStore: $e");
      return null;
    }
  }

  Future<List<Budget>> getBudgetWithID(String id) async {
    try {
      // List<Budget> budgets = await Amplify.DataStore.query(Budget.classType,
      //     where: Budget.AMOUNTLEFT.lt(100).and(Budget.SPENT.gt(1000)),
      //     sortBy: [Budget.SETAMOUNT.descending()]);
      List<Budget> budgets = await Amplify.DataStore.query(Budget.classType,
          where: Budget.ID.eq(id));
      return budgets;
    } catch (e) {
      print("Could not query DataStore: $e");
      return null;
    }
  }
}
