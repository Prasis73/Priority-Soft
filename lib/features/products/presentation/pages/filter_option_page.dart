import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';

class FilterOptionsPage extends StatefulWidget {
  final Map<String, dynamic> currentFilters;

  const FilterOptionsPage({super.key, required this.currentFilters});

  @override
  _FilterOptionsPageState createState() => _FilterOptionsPageState();
}

class _FilterOptionsPageState extends State<FilterOptionsPage> {
  String? selectedBrand;
  RangeValues selectedPriceRange = const RangeValues(0, 1750);
  String? selectedColor;

  String _selectedSort = '';
  String _selectedGender = '';
  String _selectedColor = '';
  List brands = ['Nike', 'Jordan', 'Adidas'];
  List color = ['black', 'white', 'red', 'green'];
  @override
  void initState() {
    super.initState();
    selectedBrand = widget.currentFilters['brand'];
    selectedColor = widget.currentFilters['colors'];
    if (widget.currentFilters.containsKey('priceRange')) {
      selectedPriceRange = RangeValues(
        widget.currentFilters['priceRange']['min'],
        widget.currentFilters['priceRange']['max'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Brands"),
                const SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(brands.length, (index) {
                      String img = "${brands[index]}.svg";
                      return InkWell(
                          onTap: () {
                            setState(() {
                              selectedBrand = brands[index];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              const Color(0xffF3F3F3),
                                          maxRadius: 25,
                                          child: SvgPicture.asset(
                                            'assets/svg/$img',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: selectedBrand == brands[index]
                                            ? const Icon(Icons.check_circle)
                                            : const SizedBox())
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  brands[index],
                                  style: AppTextStyles.boldStyle14,
                                )
                              ],
                            ),
                          ));
                    })),
                const SizedBox(height: 20),
                Text(
                  "Price Range",
                  style: AppTextStyles.boldStyle14,
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Colors.black.withOpacity(0.3),
                    trackHeight: 4.0, // Increase the track height
                    thumbColor: Colors.black,
                    overlayColor: Colors.black.withOpacity(0.2),
                    thumbShape: CustomThumbShape(),
                    valueIndicatorShape:
                        const PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.black,
                    valueIndicatorTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: RangeSlider(
                    values: selectedPriceRange,
                    min: 0,
                    max: 1750,
                    divisions: 100,
                    labels: RangeLabels(
                      '\$${selectedPriceRange.start.round()}',
                      '\$${selectedPriceRange.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        selectedPriceRange = values;
                      });
                    },
                  ),
                ),
                Text('Sort By', style: AppTextStyles.boldStyle14),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSortButton('Most recent', _selectedSort == ''),
                      _buildSortButton('Lowest price', _selectedSort == ''),
                      _buildSortButton('Highest price', _selectedSort == ''),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Gender',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildGenderButton('Man', _selectedGender == 'Man'),
                      _buildGenderButton('Woman', _selectedGender == 'Woman'),
                      _buildGenderButton('Unisex', _selectedGender == 'Unisex'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Color',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildColorButton('Black', _selectedColor == 'Black'),
                      _buildColorButton('White', _selectedColor == 'White'),
                      _buildColorButton('Red', _selectedColor == 'Red'),
                      _buildColorButton('Green', _selectedColor == 'Red'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                          context,
                          {
                            'brand': null,
                            'priceRange': null,
                            'colors': null,
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 156,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Text(
                            'RESET',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectedPriceRange.start == 0 &&
                                selectedPriceRange.end == 1000
                            ? Navigator.pop(
                                context,
                                {
                                  'brand': selectedBrand,
                                  'colors': selectedColor,
                                },
                              )
                            : Navigator.pop(
                                context,
                                {
                                  'brand': selectedBrand,
                                  'priceRange': {
                                    'min': selectedPriceRange.start,
                                    'max': selectedPriceRange.end,
                                  },
                                  'colors': selectedColor,
                                },
                              );
                      },
                      child: Container(
                        height: 50,
                        width: 156,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Text(
                            'APPLY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSortButton(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedSort = label;
          });
        },
        child: Container(
          height: 40,
          width: 127,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: _selectedSort == label ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(label,
                style: AppTextStyles.regularStyle16.copyWith(
                    color:
                        _selectedSort == label ? Colors.white : Colors.black)),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedGender = label;
          });
        },
        child: Container(
          height: 40,
          width: 127,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: _selectedGender == label ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(label,
                style: AppTextStyles.regularStyle16.copyWith(
                    color: _selectedGender == label
                        ? Colors.white
                        : Colors.black)),
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedColor = label.toLowerCase();
            _selectedColor = label.toLowerCase();
          });
        },
        child: Container(
          height: 50,
          width: 156,
          decoration: BoxDecoration(
              border: Border.all(
                  color: _selectedColor.toLowerCase() == label.toLowerCase()
                      ? Colors.black
                      : Colors.grey),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                      color: _getColorFromName(label.toLowerCase())),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(label,
                    style: AppTextStyles.regularStyle16
                        .copyWith(color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  static const double _thumbRadius = 12.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(_thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Draw the outer circle (black border)
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the inner circle (white fill)
    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw the outer circle
    canvas.drawCircle(center, _thumbRadius, borderPaint);

    // Draw the inner circle
    canvas.drawCircle(center, _thumbRadius - 2, fillPaint);
  }
}

Color _getColorFromName(String colorName) {
  final colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
    'white': Colors.white,
    'black': Colors.black
    // Add more colors as needed
  };

  return colorMap[colorName.toLowerCase()] ??
      Colors.grey; // Default color if not found
}
