import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: MyHome()));
}

class MyHome extends StatelessWidget {
  MyHome({super.key});

  final _counter = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Sheet'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Obx(() => Text('Jumlah item is ${_counter.value}')),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => _counter.value--,
                    child: const Text('Decrement counter')),
                ElevatedButton(
                    onPressed: () => _counter.value++,
                    child: const Text('Increment counter')),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _showBottomSheet,
                child: const Text('Show bottom sheet')),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() async {
    await Get.bottomSheet(
      Wrap(children: List.generate(_counter.value, _buildItem).toList()),
      isScrollControlled: true,
    );
    _dialogKonfirmasi();
  }

  Widget _buildItem(int index) {
    return Container(
      alignment: Alignment.center,
      color: Colors.accents[index % Colors.accents.length].shade100,
      height: 100,
      child: Text('item nomor ${index + 1}'),
    );
  }
  
  void _dialogKonfirmasi() {
    Get.defaultDialog(
      title: 'Konfirmasi',
      content: const Text('Tutup bottom sheet?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            _showBottomSheet();
          },
          child: const Text('TIDAK'),
        ),
        ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text('TUTUP'),
        ),
      ],
      barrierDismissible: false,
    );
  }
}
