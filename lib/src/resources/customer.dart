import 'dart:async';

import 'package:stripe/messages.dart';
import 'package:stripe/src/messages/customer_search.dart';

import '../client.dart';
import '_resource.dart';

class CustomerResource extends Resource<Customer> {
  CustomerResource(Client client) : super(client);

  Future<Customer> create(CreateCustomerRequest request) async {
    final response = await post('customers', data: request.toJson());
    return Customer.fromJson(response);
  }

  Future<Customer> retrieve(String customerId) async {
    final map = await get('customers/$customerId');
    return Customer.fromJson(map);
  }

  Future<CustomerSearchResult?> searchCustomers(String email) async {
    final customersMap = await get('customers/search',
        queryParameters: {"query": 'email:"$email"'});
    CustomerSearchResult customerSearchResult =
        CustomerSearchResult.fromJson(customersMap);
    if (customerSearchResult.isEmpty) {
      return null;
    } else {
      return customerSearchResult;
    }
  }

  Future<Customer> update(UpdateCustomerRequest request) async {
    final response =
        await post('customers/${request.id}', data: request.toJson());
    return Customer.fromJson(response);
  }
}
