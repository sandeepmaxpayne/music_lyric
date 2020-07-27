class AppString {
  static String musicChart =
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=c7afada2f5e01705e3fe7a4b1b32cf54";
  static String musicTrackGet(String trackID) =>
      "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackID&apikey=c7afada2f5e01705e3fe7a4b1b32cf54";
  static String musicLyric(String trackID) =>
      "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackID&apikey=c7afada2f5e01705e3fe7a4b1b32cf54";
}
