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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.deepPurpleAccent,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: DropdownButton<String>(
          value: selectedLeague,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          underline: Container(), // Remove underline for cleaner look
          isExpanded: true,
          iconSize: 28,
          iconEnabledColor: Colors.deepPurpleAccent,
          items: famousLeagues.map((String league) {
            return DropdownMenuItem<String>(
              value: league,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  league,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
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
          dropdownColor: Colors.white, // Keep the dropdown background white for contrast
        ),
      ),
    );
  }
}
