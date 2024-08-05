import 'package:get/get.dart';
import 'package:tractory/app/data/models/expense_Model.dart';
import 'package:tractory/app/data/models/tractor_Model.dart';
import 'package:tractory/app/data/services/expense_Services.dart';
import 'package:tractory/app/data/services/tractor_Services.dart';

class ExpenseController extends GetxController {
  var expenseList = <Expense>[].obs;
  var filteredExpenses = <Expense>[].obs;

  var tractorList = <Tractor>[].obs; // List of tractors
  var selectedTractorId = Rxn<int>(); // Selected tractor ID
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchExpenses();
    fetchTractors(); // Fetch tractors when controller initializes
    super.onInit();
  }

  void fetchExpenses() async {
    try {
      isLoading(true);
      var expenseService = Get.find<ExpenseService>();
      var expenses = await expenseService.getAllExpenses();
      expenseList.assignAll(expenses);
      filterExpenses(); // Apply filter after fetching expenses
    } catch (e) {
      errorMessage.value = 'Failed to load expenses: $e';
    } finally {
      isLoading(false);
    }
  }

  void fetchTractors() async {
    try {
      var tractorService = Get.find<TractorService>();
      var tractors = await tractorService.getAllTractors();
      tractorList.assignAll(tractors);
      if (tractorList.isNotEmpty) {
        selectedTractorId.value = tractorList.first.id;
      }
    } catch (e) {
      print(e);
    }
  }

  void addExpense(Expense expense) async {
    try {
      var expenseService = Get.find<ExpenseService>();
      await expenseService.addExpense(expense);
      fetchExpenses(); // Refresh the list
    } catch (e) {
      print(e);
    }
  }

  void updateExpense(Expense expense) async {
    try {
      var expenseService = Get.find<ExpenseService>();
      await expenseService.updateExpense(expense);
      fetchExpenses(); // Refresh the list
    } catch (e) {
      print(e);
    }
  }

  void deleteExpense(int id) async {
    try {
      var expenseService = Get.find<ExpenseService>();
      await expenseService.deleteExpense(id);
      fetchExpenses(); // Refresh the list
    } catch (e) {
      print(e);
    }
  }

  void filterExpenses() {
    var selectedId = selectedTractorId.value;
    if (selectedId == null) {
      filteredExpenses.assignAll(expenseList);
    } else {
      filteredExpenses.assignAll(
        expenseList.where((expense) => expense.tractorId == selectedId).toList()
          ..sort((a, b) => b.date.compareTo(a.date)), // Sort by date
      );
    }
  }

  String getTractorNameById(int? tractorId) {
    if (tractorId == null) return 'Unknown';
    final tractor = tractorList.firstWhereOrNull((t) => t.id == tractorId);
    return tractor?.name ?? 'Unknown';
  }
}
