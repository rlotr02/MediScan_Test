import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mediscan/largebutton.dart';
import 'package:mediscan/theme/colors.dart';

class SelectPage extends StatefulWidget {
  final ShapeData shapeData;

  const SelectPage({super.key, required this.shapeData});

  @override
  SelectPageState createState() => SelectPageState();
}

class SelectPageState extends State<SelectPage> {
  bool isWarning = false; //경고 색상 표시 여부
  int selectedId = 0;

  void setWarning(bool warning) {
    setState(() {
      isWarning = warning;
    });
  }

  void setCapsule(int id) {
    setState(() {
      selectedId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        title: const Text(
          'MediScan',
          style:
              TextStyle(color: mainColor, fontFamily: 'Inter900', fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PhotoComponent(
                      isWarning: isWarning,
                      onWarningChanged: setWarning,
                      frontImage: widget.shapeData.frontImage,
                      backImage: widget.shapeData.backImage),
                  CapsuleSelect(
                    isWarning: isWarning,
                    onWarningChanged: setWarning,
                    selectedId: selectedId,
                    onIdSelected: setCapsule,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoComponent extends StatefulWidget {
  final bool isWarning;
  final Function(bool) onWarningChanged;
  final File? frontImage;
  final File? backImage;

  const PhotoComponent(
      {super.key,
      required this.isWarning,
      required this.onWarningChanged,
      this.frontImage,
      this.backImage});

  @override
  PhotoState createState() => PhotoState();
}

class PhotoState extends State<PhotoComponent> {
  Widget buildImage(File? image) {
    return Column(
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: image == null
                ? const Text(
                    "이미지가 없습니다",
                    style: TextStyle(
                      backgroundColor: backColor,
                    ),
                  )
                : Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          alignment: Alignment.center,
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  '검색 결과',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'NotoSans700',
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/back.png',
                    width: 9,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  highlightColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.frontImage != null
                ? buildImage(widget.frontImage)
                : const Text(''),
            const SizedBox(width: 30),
            widget.backImage != null
                ? buildImage(widget.backImage)
                : const Text(''),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          child: Text(
            '알약을 선택해 주세요.',
            style: TextStyle(
              color: widget.isWarning ? redColor : backColor,
              fontFamily: 'NotoSans500',
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}

class CapsuleSelect extends StatefulWidget {
  final int selectedId;
  final Function(int) onIdSelected;
  final bool isWarning;
  final Function(bool) onWarningChanged;

  const CapsuleSelect(
      {super.key,
      required this.selectedId,
      required this.onIdSelected,
      required this.isWarning,
      required this.onWarningChanged});

  @override
  CapsuleSelectState createState() => CapsuleSelectState();
}

class CapsuleSelectState extends State<CapsuleSelect> {
  final List<int> buttonTexts = [1, 2, 3, 4, 5]; //리스트

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buttonTexts.map(
        (id) {
          return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onIdSelected(id);
                      if (widget.isWarning == true) {
                        widget.onWarningChanged(false);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: whiteColor,
                      side: BorderSide(
                          color:
                              widget.selectedId == id ? mainColor : subColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '알약 이름',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:
                              widget.selectedId == id ? whiteColor : blackColor,
                          fontFamily: 'NotoSans500',
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
