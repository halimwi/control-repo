class profile::accounts {
  accounts::user { 'mytestuser':
    ensure  => present,
    uid     => '1234',
    managehome => true,
  }

}
