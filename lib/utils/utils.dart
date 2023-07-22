import 'package:get/get.dart';

class Utils extends GetxController {
  String getFormattedText(String text) {
    List<String> words = text.split(' ');
    List<String> formattedLines = [];
    int lineCount = words.length ~/
        2; // Membagi panjang teks dengan 2 untuk mendapatkan jumlah baris yang diinginkan

    for (int i = 0; i < lineCount; i++) {
      int startIndex = i * 2;
      int endIndex = startIndex + 1;
      String formattedLine = '${words[startIndex]} ${words[endIndex]}';
      formattedLines.add(formattedLine);
    }

    return formattedLines
        .join('\n'); // Menggabungkan baris dengan karakter baris baru (\n)
  }
}
