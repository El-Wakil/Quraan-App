import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/core/app_colors.dart';

import '../../../core/ayat_quran.dart';

class DetailsScreen extends StatefulWidget {
  final AyatSour sourItem;

  const DetailsScreen(this.sourItem, {super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double fontSize = 24.0;
  bool isBookmarked = false;
  bool _isScrolled = false;
  double _dragButtonLeft = -50;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    if (widget.sourItem.displayqoran.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('خطأ', style: GoogleFonts.amiri()),
          backgroundColor: AppColors.primary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'لا يوجد نص متاح لهذه السورة',
                style: GoogleFonts.amiri(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.secondary, AppColors.background],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.sourItem.name,
                            style: GoogleFonts.amiri(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${widget.sourItem.ayat} آية',
                              style: GoogleFonts.amiri(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.cardBackground.withOpacity(0.3),
                          AppColors.cardBackground.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.border.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels > 50 && !_isScrolled) {
                          setState(() {
                            _isScrolled = true;
                          });
                        } else if (scrollInfo.metrics.pixels <= 50 &&
                            _isScrolled) {
                          setState(() {
                            _isScrolled = false;
                          });
                        }
                        return true;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            // بسم الله الرحمن الرحيم
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                                style: GoogleFonts.amiri(
                                  fontSize: fontSize + 2,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  height: 1.5,
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildFormattedText(widget.sourItem.displayqoran),
                            const SizedBox(height: 20),
                            // صدق الله العظيم
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'صدق الله العظيم',
                                style: GoogleFonts.amiri(
                                  fontSize: fontSize + 2,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  height: 1.5,
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Draggable font size button - ظاهر دائماً
          Positioned(
            left: _dragButtonLeft,
            top: MediaQuery.of(context).size.height * 0.5,
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  _isDragging = true;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _dragButtonLeft += details.delta.dx;
                  if (_dragButtonLeft < -50) _dragButtonLeft = -50;
                  if (_dragButtonLeft >
                      MediaQuery.of(context).size.width - 80) {
                    _dragButtonLeft = MediaQuery.of(context).size.width - 80;
                  }
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _isDragging = false;
                  if (_dragButtonLeft < 20) {
                    _dragButtonLeft = -50;
                  }
                });
              },
              onTap: () {
                _showFontSizeDialog();
              },
              child: AnimatedContainer(
                duration: _isDragging
                    ? Duration.zero
                    : const Duration(milliseconds: 300),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.text_fields,
                    color: AppColors.background,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),

          // Edge indicator للسحب - ظاهر عند الإخفاء
          if (_dragButtonLeft <= -40)
            Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height * 0.5 - 20,
              child: Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          'حجم الخط',
          style: GoogleFonts.amiri(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: AppColors.primary),
                onPressed: () {
                  setState(() {
                    if (fontSize > 16) fontSize -= 2;
                  });
                  this.setState(() {});
                },
              ),
              Text(
                fontSize.toInt().toString(),
                style: GoogleFonts.amiri(
                  fontSize: 18,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: AppColors.primary),
                onPressed: () {
                  setState(() {
                    if (fontSize < 32) fontSize += 2;
                  });
                  this.setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormattedText(String qoranText) {
    try {
      return Text(
        qoranText,
        style: GoogleFonts.amiri(
          fontSize: fontSize,
          height: 2.0,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w400,
          wordSpacing: 1.5,
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.justify,
      );
    } catch (e) {
      return Text(
        'خطأ في عرض النص',
        style: GoogleFonts.amiri(
          fontSize: fontSize,
          color: AppColors.textSecondary,
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      );
    }
  }
}
