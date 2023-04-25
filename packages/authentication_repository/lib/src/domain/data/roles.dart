List<String> ROLES = ['ADMIN', 'MANAGER', 'CASHIER', 'WAITER'];
bool isAdimn(String role) {
  return ROLES.sublist(0, 2).contains(role);
}
