<<<<<<< HEAD
import '../models/order_stats_model.dart';

class MockOrderService {
  // Fungsi untuk mengambil data ringkasan order
  static OrderStatsModel getSummary() {
    return OrderStatsModel(
      newOrders: 35,
      pendingOrders: 9,
    );
  }
=======
import '../models/order_stats_model.dart';

class MockOrderService {
  // Fungsi untuk mengambil data ringkasan order
  static OrderStatsModel getSummary() {
    return OrderStatsModel(
      newOrders: 35,
      pendingOrders: 9,
    );
  }
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
}