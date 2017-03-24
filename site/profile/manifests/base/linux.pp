class profile::base::linux (
  Optional[Array] $packages = lookup('profile::base::linux::packages', 'unique', undef)
) {

  include ::ntp
  package { $packages :
    ensure  => present,
  }
}
