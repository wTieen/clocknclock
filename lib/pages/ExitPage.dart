import 'package:flutter/material.dart';

class ExitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lấy thời gian hiện tại
    DateTime now = DateTime.now();

    // Kiểm tra thời gian để chọn hình ảnh phù hợp
    // Cứ 4 tiếng hình nền thay đổi 1 lần
    String imagePath;
    if (now.hour >= 0 && now.hour < 4) {
      imagePath = 'assets/images/hinh_nen_1.gif';
    }
    else if (now.hour >= 4 && now.hour < 8) {
      imagePath = 'assets/images/hinh_nen_2.gif';
    }
    else if (now.hour >= 8 && now.hour < 12) {
      imagePath = 'assets/images/hinh_nen_3.gif';
    }
    else if (now.hour >= 12 && now.hour < 16) {
      imagePath = 'assets/images/hinh_nen_4.gif';
    }
    else if (now.hour >= 16 && now.hour < 20) {
      imagePath = 'assets/images/hinh_nen_5.gif';
    }
    else {
      imagePath = 'assets/images/hinh_nen_6.gif';
    }
    //Chưa xét trường hợp nếu các ảnh bị lỗi thì sao (-_-)?

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 5,
                right: 250,
                child: GestureDetector(
                  onTap: () {
                    print('out');
                    // Chuyển về màn hình chính
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
