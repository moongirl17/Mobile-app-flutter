import 'package:flutter_batch_6_project/data/remote_data/network_service/network_service.dart';
import 'package:flutter_batch_6_project/models/sales_model.dart';

import '../../models/order_model.dart';

abstract class SalesRemoteData {
  Future<List<SalesInvoice>> getSalesInvoices({
    int? page,
    int? size,
  });

  Future<void> postCreateSales(OrderModel data);

}

class SalesRemoteDataImpl implements SalesRemoteData {
  late final NetworkService _networkService;

  SalesRemoteDataImpl(this._networkService);

  @override
  Future<List<SalesInvoice>> getSalesInvoices({
    int? page,
    int? size,
  }) async {
    final response = await _networkService.get(
      url: "/api/sales/list",
      queryParameters: {
        "page": page,
        "size": size,
      },
    );
    return (response.data['data']['data'] as List)
        .map((sales) => SalesInvoice.fromJson(sales))
        .toList();
  }

  @override
  Future<void> postCreateSales(OrderModel data) async {
    await _networkService.post(
      url: "/api/sales/create",
      data: data.toJson(),
    );
  }
}