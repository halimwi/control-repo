class profile::base::solaris (
  Optional[Array] $packages = lookup('profile::base::solaris::packages', 'unique', undef)
) {
  class { '::ntp':
    package_manage => false,
  }
  package { $packages :
    ensure  => present,
  }
}
