class profile::puppetmaster (
  $hiera_yaml = "${::settings::confdir}/hiera.yaml"
){
  # Default Packages
  package { ['hiera-eyaml', 'deep_merge']:
    ensure   => present,
    provider => puppetserver_gem,
  }
  # Metric Collection
  include pe_metric_curl_cron_jobs
  # Hiera Data
  class { 'hiera':
    hierarchy  => [
      'nodes/%{::trusted.certname}',
      'virtual/%{::virtual}',
      'osfamily/%{::osfamily}',
      'common',
    ],
    #eyaml      => true,
    hiera_yaml => $hiera_yaml,
    datadir    => '/etc/puppetlabs/code/environments/%{environment}/hieradata',
    owner      => 'pe-puppet',
    group      => 'pe-puppet',
    notify     => Service['pe-puppetserver'],
  }
}
