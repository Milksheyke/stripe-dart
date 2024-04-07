part of '../../../messages.dart';

class CreateCustomerSearchRequest {
  final String querystring;
  final int? limit;
  final String? page;

  CreateCustomerSearchRequest({
    required this.querystring,
    this.limit,
    this.page,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result['query'] = querystring;
    if (limit != null) {
      result['limit'] = limit;
    }
    if (page != null) {
      result['page'] = page;
    }

    return result;
  }
}
