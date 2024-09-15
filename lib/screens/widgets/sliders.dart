import 'package:diary_mood/theme.dart';
import 'package:flutter/material.dart';

class StressLevelSlider extends StatefulWidget {
  final ValueChanged<double> onChanged;

  StressLevelSlider({required this.onChanged});

  @override
  _StressLevelSliderState createState() => _StressLevelSliderState();
}

class _StressLevelSliderState extends State<StressLevelSlider> {
  double _stressLevel = 50;
  bool _isSliderMoved = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 103,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 0.1,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return Container(
                  width: 2,
                  height: 8,
                  color: Colors.grey,
                );
              }),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _stressLevel,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (newValue) {
                    setState(() {
                      _stressLevel = newValue;
                      _isSliderMoved = true;
                    });
                    widget.onChanged(_stressLevel);
                  },
                  activeColor: _isSliderMoved ? Colors.orange : Colors.grey,
                  inactiveColor: _isSliderMoved
                      ? Colors.orange.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Низкий",
                style: AppTextStyles.buttonText,
              ),
              Text(
                "Высокий",
                style: AppTextStyles.buttonText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ConfidenceLevelSlider extends StatefulWidget {
  final ValueChanged<double> onChanged;

  ConfidenceLevelSlider({required this.onChanged});

  @override
  _ConfidenceLevelSliderState createState() => _ConfidenceLevelSliderState();
}

class _ConfidenceLevelSliderState extends State<ConfidenceLevelSlider> {
  double _confidenceLevel = 50;
  bool _isSliderMoved = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 380,
        height: 103,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 0.1,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return Container(
                    width: 2,
                    height: 8,
                    color: Colors.grey,
                  );
                }),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _confidenceLevel,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: (newValue) {
                      setState(() {
                        _confidenceLevel = newValue;
                        _isSliderMoved = true;
                      });
                      widget.onChanged(_confidenceLevel);
                    },
                    activeColor: _isSliderMoved ? Colors.orange : Colors.grey,
                    inactiveColor: _isSliderMoved
                        ? Colors.orange.withOpacity(0.5)
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Неуверенность",
                  style: AppTextStyles.buttonText,
                ),
                Text(
                  "Уверенность",
                  style: AppTextStyles.buttonText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
