import 'package:flutter/material.dart';
import 'package:cashel_v2/data/models/user_order_model.dart';
import '../../../data/service/mock_data_table.dart';

class AdminTable extends StatelessWidget {
  const AdminTable({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserOrderModel> history = TableServices.getLatestHistory();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          columns: const [
            DataColumn(label: Text('No. Order')),
            DataColumn(label: Text('Pelanggan')),
            DataColumn(label: Text('Tanggal')),
            DataColumn(label: Text('Total')),
            DataColumn(label: Text('Status')),
          ],
          rows: history.map((data) {
            return DataRow(cells: [
              DataCell(Text(data.number)),
              DataCell(Text(data.userName)),
              DataCell(Text(data.date)),
              DataCell(Text('Rp ${data.totalPrice}')),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    // Logika warna status
                    color: _getStatusColor(data.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data.status,
                    style: TextStyle(
                      color: _getStatusColor(data.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  // Fungsi pembantu untuk warna status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Success': return Colors.green;
      case 'Pending': return Colors.orange;
      case 'Failed': return Colors.red;
      default: return Colors.grey;
    }
  }
}