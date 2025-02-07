import 'package:flutter/material.dart';

class MatchFilterDropdown extends StatelessWidget {
  final String selectedLeague;
  final List<String> famousLeagues;
  final Function(String) onLeagueSelected;

  const MatchFilterDropdown({
    super.key,
    required this.selectedLeague,
    required this.famousLeagues,
    required this.onLeagueSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final borderColor =
        isDarkMode ? Colors.deepPurpleAccent.shade100 : Colors.deepPurpleAccent;
    final shadowColor = isDarkMode ? Colors.black54 : Colors.black26;
    final dropdownColor = isDarkMode ? Colors.grey[800] : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: DropdownButton<String>(
          value: selectedLeague,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          underline: Container(), // Remove underline for cleaner look
          isExpanded: true,
          iconSize: 28,
          iconEnabledColor: borderColor,
          items: famousLeagues.map((String league) {
            return DropdownMenuItem<String>(
              value: league,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  league,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onLeagueSelected(newValue);
            }
          },
          dropdownColor: dropdownColor, // Dynamic dropdown background
        ),
      ),
    );
  }
}
