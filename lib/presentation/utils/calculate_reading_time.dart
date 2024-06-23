int calculateReadingTime(String blogContent) {
  // Step 1: Define the average reading speed
  const int averageReadingSpeedWPM = 200;

  // Step 2: Count the words in the blog content
  int totalWords = blogContent.split(' ').length;

  // Step 3: Calculate the reading time in minutes
  int readingTimeMinutes = (totalWords / averageReadingSpeedWPM).ceil();

  return readingTimeMinutes;
}
