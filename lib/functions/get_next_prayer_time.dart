  Map<String, dynamic> getNextPrayerTime(Map<String, DateTime> prayerTimes) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final orderedPrayers = <String, DateTime>{
      for (var entry in prayerTimes.entries)
        entry.key: DateTime(
          today.year,
          today.month,
          today.day,
          entry.value.hour,
          entry.value.minute,
        ),
    };

    for (var entry in orderedPrayers.entries) {
      if (entry.value.isAfter(now)) {
        final remaining = entry.value.difference(now);
        return {"name": entry.key, "time": entry.value, "remaining": remaining};
      }
    }

    final firstPrayer = orderedPrayers.entries.first;
    final nextDayPrayer = firstPrayer.value.add(const Duration(days: 1));
    final remaining = nextDayPrayer.difference(now);
    return {
      "name": firstPrayer.key,
      "time": nextDayPrayer,
      "remaining": remaining,
    };
  }