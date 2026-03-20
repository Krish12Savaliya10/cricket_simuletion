// File: lib/widgets/ball_history_row.dart

import 'package:flutter/material.dart';

class BallHistoryRow extends StatelessWidget {
  final List<String> lastBalls;

  const BallHistoryRow({
    super.key,
    required this.lastBalls,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: lastBalls.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final ball = lastBalls[index];
          final isWicket = ball == 'W';
          final isBoundry = ball == '4' || ball == '6';

          return Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isWicket 
                ? Colors.red[100] 
                : isBoundry 
                  ? Colors.blue[100] 
                  : Colors.grey[200],
              shape: BoxShape.circle,
              border: Border.all(
                color: isWicket 
                  ? Colors.red 
                  : isBoundry 
                    ? Colors.blue 
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Text(
              ball,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isWicket 
                  ? Colors.red[900] 
                  : isBoundry 
                    ? Colors.blue[900] 
                    : Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }
}
