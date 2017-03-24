class profile::base (
  Optional[Array] $packages = hiera_array('profile::base::packages', undef)
) {
  case $::kernel {
    'Windows': {
      class { 'profile::base::windows':
        packages => $packages,
      }
    }
    'Linux': {
      class { 'profile::base::linux':
        packages => $packages,
      }
    }
    'SunOS': {
      class { 'profile::base::solaris':
        packages => $packages,
      }
    }
    default: {  }
  }
}
