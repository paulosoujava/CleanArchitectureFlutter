class AccountEntity extends Comparable<AccountEntity> {
  final String token;

  AccountEntity(this.token);

  @override
  int compareTo(AccountEntity other) {
    return this == other ? 1 : -1;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AccountEntity && o.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
