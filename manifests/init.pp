
class btsync(
  $glibc23                = hiera('btsync::glibc23', 'glibc23'),
  $install_dir            = hiera('btsync::install_dir', '/opt/btsync'),
  $storage_conf_path      = hiera('btsync::storage_conf_path', hiera('btsync::install_dir')"/.sync"),
  $webui_ip               = hiera('btsync::webui_ip', '127.0.0.1'),
  $webui_port             = hiera('btsync::webui_port', '8888'),
  $webui_login            = hiera('btsync::webui_login'),
  $webui_pwd              = hiera('btsync::webui_pwd'),
  $api_key                = hiera('btsync::api_key'),
  $tmp                    = hiera('btsync::tmp', '/tmp'),
) {

  singleton_packages("wget")

  case $architecture {
    'x86_64':  { $arch = 'x64'}
    'i386':  { $arch = 'i386'}
  }

  file { "${install_dir}":
    ensure => directory,
  }

  file { "${storage_conf_path}":
    ensure => directory,
  }

  exec { "download btsync":
    cwd => "${tmp}",
    command => "/usr/bin/wget -O btsync_${glibc23}_${arch}.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-${glibc23}-${arch}/track/stable",
    creates => "${tmp}/btsync_${glibc23}_${arch}.tar.gz",
    notify => Exec['untar btsync'],
  }

  exec { "untar btsync":
    require => File["${install_dir}"],
    cwd => "${tmp}",
    command => "/bin/tar -zxvf btsync_${glibc23}_${arch}.tar.gz -C ${install_dir}",
    creates => "${install_dir}/btsync",
  }

  file { "${install_dir}/btsync.json":
    require => File["${storage_conf_path}"],
    content => template("${module_name}/btsync.json.erb"),
  }

  service { 'btsync':
    require => [Exec["untar btsync"], File["${install_dir}/btsync.json"]],
    enable => true,
    ensure => running,
    start => "${install_dir}/btsync --config btsync.json",
    hasrestart => false,
    hasstatus => false,
  }
}
