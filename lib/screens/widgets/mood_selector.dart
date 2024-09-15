import 'package:diary_mood/theme.dart';
import 'package:flutter/material.dart';

class MoodSelector extends StatefulWidget {
  final ValueChanged<List<String>> onMoodsSelected;

  MoodSelector({required this.onMoodsSelected});

  @override
  _MoodSelectorState createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  final List<int> _selectedIndices = [];
  final List<int> _selectedAdditionalIndices = [];

  final List<Map<String, String>> _moods = [
    {'image': 'images/joy.png', 'label': 'Радость'},
    {'image': 'images/fear.png', 'label': 'Страх'},
    {'image': 'images/rabies.png', 'label': 'Бешенство'},
    {'image': 'images/sadness.png', 'label': 'Грусть'},
    {'image': 'images/calm.png', 'label': 'Спокойствие'},
    {'image': 'images/strength.png', 'label': 'Сила'},
  ];

  final Map<String, List<String>> _additionalOptionsMap = {
    'Радость': [
      'Возбуждение',
      'Восторг',
      'Игривость',
      'Наслаждение',
      'Очарование',
      'Осознанность',
      'Смелость',
      'Удовольствие',
      'Чувственность',
      'Энергичность',
      'Экстравагантность',
    ],
    'Страх': [
      'Тревога',
      'Опасение',
      'Нервозность',
      'Смущение',
      'Паника',
      'Дрожь',
      'Застенчивость',
    ],
    'Бешенство': [
      'Раздражение',
      'Гнев',
      'Злость',
      'Агрессия',
      'Враждебность',
      'Нетерпимость',
    ],
    'Грусть': [
      'Сожаление',
      'Печаль',
      'Уныние',
      'Меланхолия',
      'Скука',
      'Одиночество',
    ],
    'Спокойствие': [
      'Расслабление',
      'Умиротворение',
      'Тишина',
      'Комфорт',
      'Успокоение',
      'Безмятежность',
    ],
    'Сила': [
      'Могущество',
      'Уверенность',
      'Энергия',
      'Стойкость',
      'Терпение',
      'Смелость',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _moods.length,
            itemBuilder: (context, index) {
              return _buildMoodCard(index);
            },
          ),
        ),
        const SizedBox(height: 10),
        if (_selectedIndices.isNotEmpty) ...[
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _getAllAdditionalOptions(),
          ),
        ],
      ],
    );
  }

  Widget _buildMoodCard(int index) {
    bool isSelected = _selectedIndices.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedIndices.remove(index);
          } else {
            _selectedIndices.add(index);
          }
          widget.onMoodsSelected(
              _selectedIndices.map((i) => _moods[i]['label']!).toList());
        });
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(47),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _moods[index]['image']!,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 8),
            Text(
              _moods[index]['label']!,
              style: AppTextStyles.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getAllAdditionalOptions() {
    Set<String> selectedMoods =
        _selectedIndices.map((index) => _moods[index]['label']!).toSet();

    List<String> allAdditionalOptions = [];
    for (String mood in selectedMoods) {
      allAdditionalOptions.addAll(_additionalOptionsMap[mood] ?? []);
    }

    allAdditionalOptions = allAdditionalOptions.toSet().toList();

    return List.generate(
      allAdditionalOptions.length,
      (index) => _buildAdditionalOption(index, allAdditionalOptions),
    );
  }

  Widget _buildAdditionalOption(int index, List<String> options) {
    bool isSelected = _selectedAdditionalIndices.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedAdditionalIndices.remove(index);
          } else {
            _selectedAdditionalIndices.add(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          options[index],
          style: AppTextStyles.buttonText.copyWith(
            color: isSelected ? Colors.orange : Colors.black,
          ),
        ),
      ),
    );
  }
}
