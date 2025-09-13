extension DateFormatting on DateTime {
  String toDayMonth() {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return "${this.day} ${months[this.month - 1]}";
  }
}