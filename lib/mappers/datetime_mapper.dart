var defaultDateTime = DateTime(1900, 1, 1);

/// Convert a [String] to a [DateTime].
DateTime parseDateTime(String? value) => value != null && value.isNotEmpty ? DateTime.parse(value) : defaultDateTime;
