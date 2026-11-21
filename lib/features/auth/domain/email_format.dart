/// A cheap check before asking the server: something@something.tld. The
/// server's own rule is the real one.
bool isPlausibleEmail(String input) =>
    RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]{2,}$').hasMatch(input.trim());
