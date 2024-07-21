import 'dart:async';

import 'package:stripe/messages.dart';

import '_resource.dart';

class SubscriptionResource extends Resource<Subscription> {
  SubscriptionResource(super.client);

  Future<Subscription> retrieve(String id) async {
    final response = await get('subscriptions/$id');
    return Subscription.fromJson(response);
  }

  Future<DataList<Subscription>> list(
      [ListSubscriptionsRequest? request]) async {
    final map = await get('subscriptions', queryParameters: request?.toJson());
    return DataList<Subscription>.fromJson(
        map, (value) => Subscription.fromJson(value as Map<String, dynamic>));
  }

  Future<DataList<Subscription>> search({
    /// https://docs.stripe.com/search#query-fields-for-subscriptions
    required String queryString,
  }) async {
    final Map<String, dynamic> map = await get(
      'subscriptions/search',
      queryParameters: {'query': queryString},
    );

    final subscriptions = DataList<Subscription>.fromJson(
      map,
      (subscriptionMap) =>
          Subscription.fromJson(subscriptionMap as Map<String, dynamic>),
    );

    return subscriptions;
  }

  /// https://docs.stripe.com/api/subscriptions/update
  Future<Subscription> update(
    String id, {
    required SubscriptionUpdate update,
  }) async {
    final response = await post(
      'subscriptions/$id',
      data: update.toJson(),
    );

    return Subscription.fromJson(response);
  }

  /// https://docs.stripe.com/api/subscriptions/cancel
  Future<Subscription> cancel(
    String id, {
    bool? invoiceNow,
    bool? prorate,
  }) async {
    final response = await delete(
      'subscriptions/$id',
      data: {
        if (invoiceNow != null) 'invoice_now': invoiceNow,
        if (prorate != null) 'prorate': invoiceNow,
      },
    );

    return Subscription.fromJson(response);
  }
}
