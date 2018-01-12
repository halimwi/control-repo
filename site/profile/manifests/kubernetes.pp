class profile::kubernetes (
  Boolean $helm = false,
  Boolean $rook = true,
){
  # ./kube_tool.rb -o redhat -v 1.9.0 -r docker -f kubernetes -i 192.168.5.130 -b 192.168.5.130 -e "etcd-k801=http://192.168.5.130:2380,etcd-k802=http://192.168.5.118:2380,etcd-k803=http://192.168.5.111:2380" -t "%{::ipaddress_eth0}" -a "%{::ipaddress_eth0}" -d true
  include kubernetes
  if $helm {
    include helm
    Class['kubernetes'] -> Class['helm']
    if $rook {
      include rook
      Class['helm'] -> Class['rook']
    }
  }
  host { $facts['fqdn']:
    ip => $::ipaddress,
    host_aliases => [$facts['hostname'], 'kubernetes'],
  }


}
