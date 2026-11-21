/// What the server still needs from a signed-in account before the app opens
/// (API `nextStep`). `none` means the account is fully through the gate.
enum AuthGate() {
  none,
  verifyEmail,
  addPhone,
  acceptTerms,
  mfa,
  mfaEnrol,
}
