String addNewlines(String input, int maxLength) {
  List<String> words = input.split(' ');
  StringBuffer result = StringBuffer();
  int currentLineLength = 0;
  int lineCount = 1;

  for (var i = 0; i < words.length; i++) {
    var word = words[i];

    // Check if adding this word would exceed max length
    bool exceedsLength =
        (currentLineLength + word.length + (currentLineLength > 0 ? 1 : 0)) >
            maxLength;

    if (exceedsLength) {
      // If we're already on line 2, add ellipsis and break
      if (lineCount == 2) {
        // Remove trailing space if it exists
        String currentText = result.toString();
        if (currentText.endsWith(' ')) {
          result =
              StringBuffer(currentText.substring(0, currentText.length - 1));
        }
        result.write('...');
        break;
      }

      // Otherwise, move to next line
      result.write('\n');
      currentLineLength = 0;
      lineCount++;
    } else if (currentLineLength > 0) {
      result.write(' ');
      currentLineLength += 1;
    }

    result.write(word);
    currentLineLength += word.length;
  }

  return result.toString();
}
