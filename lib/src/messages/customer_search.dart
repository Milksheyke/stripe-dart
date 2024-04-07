import 'package:stripe/messages.dart';

class CustomerSearchResult {
  final bool hasMore;
  final bool isEmpty;
  final List<Customer> customers;

  CustomerSearchResult(
      {required this.customers, required this.hasMore, this.isEmpty = false});

  factory CustomerSearchResult.fromJson(Map<String, dynamic> json) {
    final List<dynamic> customersJsonList = json['data'];
    List<Customer> customersList = [];
    bool hasMore = json['has_more'];
    if (customersJsonList.isEmpty) {
      return CustomerSearchResult(customers: [], hasMore: false, isEmpty: true);
    }

    for (var element in customersJsonList) {
      final customer = Customer.fromJson(element);
      customersList.add(customer);
    }
    return CustomerSearchResult(customers: customersList, hasMore: hasMore);
  }
}
