import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelasc/app/data/model/response_get_pinjam.dart';
import '../../../data/constant/endpoin.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';


class PeminjamanController extends GetxController with StateMixin<List<DataPinjam>>{

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  getData() async {
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.pinjam + '/${StorageProvider.read(StorageKey.idUser)}');
      if (response.statusCode == 200) {
        final ResponseGetPinjam responseGetPinjam = ResponseGetPinjam.fromJson(response.data);
        if (responseGetPinjam.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(responseGetPinjam.data, status: RxStatus.success());
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
