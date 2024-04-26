import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mediscan/main.dart';
import 'package:mediscan/theme/colors.dart';

class UploadPage extends StatefulWidget {
  final ShapeData shapeData;

  const UploadPage({super.key, required this.shapeData});

  @override
  UploadPageState createState() => UploadPageState();
}

class UploadPageState extends State<UploadPage> {
  bool isWarning = false; //경고 색상 표시 여부
  Image frontImage = Image.file(File(''));
  Image backImage = Image.file(File(''));

  void setWarning(bool warning) {
    setState(() {
      isWarning = warning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MediScan',
          style:
              TextStyle(color: mainColor, fontFamily: 'Inter900', fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PhotoUploadComponent(
              isWarning: isWarning,
              onWarningChanged: setWarning,
            ),
            LargeButton(
              buttonText: "결과 확인하기",
              onWarningChanged: setWarning,
              selectedShape: widget.shapeData.selectedShape,
              frontMark: widget.shapeData.frontMark,
              backMark: widget.shapeData.backMark,
              frontImage: frontImage,
              backImage: backImage,
            ),
            Text(
                '${widget.shapeData.selectedShape}, ${widget.shapeData.frontMark}, ${widget.shapeData.backMark}'),
          ],
        ),
      ),
    );
  }
}

class PhotoUploadComponent extends StatefulWidget {
  final bool isWarning;
  final Function(bool) onWarningChanged;

  const PhotoUploadComponent(
      {super.key, required this.isWarning, required this.onWarningChanged});

  @override
  PhotoUploadState createState() => PhotoUploadState();
}

class PhotoUploadState extends State<PhotoUploadComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 16, top: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '(필수) 정확성을 위해 알약의 앞, 뒤를 모두 업로드해주세요.',
              style: TextStyle(
                color: widget.isWarning ? redColor : deleteColor,
                fontFamily: 'NotoSans500',
                fontSize: 14,
              ),
            ),
          ),
        ),
        Divider(
          color: widget.isWarning ? redColor : deleteColor,
          thickness: 1,
          height: 0,
          indent: 0,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // 가로축 중앙 정렬
          children: [
            Column(
              children: [
                const Text(
                  '앞',
                  style: TextStyle(
                    fontFamily: 'NotoSans700',
                    fontSize: 20,
                    color: mainColor,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 140,
                  height: 140,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: whiteColor,
                      backgroundColor: whiteColor,
                      side: const BorderSide(color: mainColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/plus.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 32),
            Column(
              children: [
                const Text(
                  '뒤',
                  style: TextStyle(
                    fontFamily: 'NotoSans700',
                    fontSize: 20,
                    color: mainColor,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 140,
                  height: 140,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: whiteColor,
                      backgroundColor: whiteColor,
                      side: const BorderSide(color: mainColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/plus.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class LargeButton extends StatefulWidget {
  final String buttonText;
  final String selectedShape;
  final Function(bool) onWarningChanged;
  final String frontMark;
  final String backMark;
  final Image frontImage;
  final Image backImage;

  const LargeButton(
      {super.key,
      required this.buttonText,
      required this.selectedShape,
      required this.onWarningChanged,
      required this.frontMark,
      required this.backMark,
      required this.frontImage,
      required this.backImage});

  @override
  LargeButtonState createState() => LargeButtonState();
}

class LargeButtonState extends State<LargeButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 38, right: 38, top: 100),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (widget.selectedShape == '') {
                  widget.onWarningChanged(true);
                } else {
                  ShapeData data = ShapeData(
                      selectedShape: widget.selectedShape,
                      frontMark: widget.frontMark,
                      backMark: widget.backMark);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadPage(shapeData: data),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.buttonText,
                style: const TextStyle(
                    color: whiteColor, fontFamily: 'NotoSans500', fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
