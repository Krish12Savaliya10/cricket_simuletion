import 'package:flutter/material.dart';

class RunButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final bool isLarge;

  const RunButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: isLarge ? 80 : 60,
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isLarge ? 24 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreboardPanel extends StatelessWidget {
  final int runs;
  final int wickets;
  final String overs;
  final String? crr;

  const ScoreboardPanel({
    super.key,
    required this.runs,
    required this.wickets,
    required this.overs,
    this.crr,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    '$runs/$wickets',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'OVERS',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    overs,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (crr != null)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'CRR: $crr',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}
