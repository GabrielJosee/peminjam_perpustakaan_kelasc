import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelasc/app/data/model/response_user_book.dart';

import '../../../data/constant/endpoin.dart';
import '../../../data/provider/api_provider.dart';

class BookController extends GetxController with StateMixin<List<DataBook>>{


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    super.onClose();
  }
  getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(
        Endpoint.book,
      );
      if (response.statusCode == 200) {
        final ResponseUserBook responseUserBook = ResponseUserBook.fromJson(response.data);
        if (responseUserBook.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(responseUserBook.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal mengambil data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null,
              status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
