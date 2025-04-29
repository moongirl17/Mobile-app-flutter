import 'package:flutter_batch_6_project/data/remote_data/network_service/network_service.dart';
import 'package:flutter_batch_6_project/models/product_model.dart';

abstract class ProductRemoteData {
  Future<List<Product>> getProduct({
    int? page,
    int? size,
  });
}

class ProductRemoteDataImpl implements ProductRemoteData {
  late final NetworkService _networkService;

  ProductRemoteDataImpl(this._networkService);

  @override
  Future<List<Product>> getProduct({
    int? page,
    int? size,
  }) async {
    final response = await _networkService.get(
      url: "/api/product/list",
      queryParameters: {
        "page": page,
        "size": size,
      },
    );
    return (response.data['data']['data'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
  }
}