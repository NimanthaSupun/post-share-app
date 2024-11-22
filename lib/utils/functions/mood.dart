
enum Mood {
  happy,
  sad,
  angry,
  excited,
  bored,
}

// mood extention >> num > name

extension MoodExtension on Mood {
  String get name {
    switch (this) {
      case Mood.happy:
        return "happy";

      case Mood.sad:
        return "sad";

      case Mood.angry:
        return "angry";

      case Mood.bored:
        return "bored";

      case Mood.excited:
        return "excited";

      default:
        return "";
    }
  }
  // return emoji

  // Get the emoji of the mood
  String get emoji {
    switch (this) {
      case Mood.happy:
        return '😊'; // Happy emoji
      case Mood.sad:
        return '😢'; // Sad emoji
      case Mood.angry:
        return '😡'; // Angry emoji
      case Mood.excited:
        return '🤩'; // Excited emoji
      case Mood.bored:
        return '😴'; // Bored emoji
      default:
        return '';
    }
  }

  // Convert a string to a Mood enum value , here we will use the firstWhere method to get the first value that match the string

  static Mood fromString(String moodString) {
    return Mood.values.firstWhere(
      (mood) => mood.name == moodString,
      orElse: () => Mood.happy,
    );
  }
}
