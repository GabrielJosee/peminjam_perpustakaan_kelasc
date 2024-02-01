import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/model/response_user_book.dart';
import '../../../routes/app_pages.dart';
import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookView'),
        centerTitle: true,
      ),
        body: controller.obx(
              (state) => ListView.separated(
            itemCount: state!.length,
            itemBuilder: (context, index) {
              DataBook dataBook = state[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    "${dataBook.judul}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Penulis ${dataBook.penulis}\n${dataBook.penerbit} - ${dataBook.tahunTerbit}",
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: InkWell(
                    onTap: () => Get.toNamed(
                      Routes.ADD_PEMINJAMAN,
                      parameters: {
                        "id": (dataBook.id ?? 0).toString(),
                        'judul': dataBook.judul ?? '-',
                      },
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Pinjam",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
          onLoading: Center(child: const CircularProgressIndicator()),
        )

    );
  }
}
