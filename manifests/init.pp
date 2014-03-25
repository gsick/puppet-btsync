
class btsync(
  $glibc23                = hiera('btsync::glibc23', true),
  $install_dir            = hiera('btsync::install_dir', '/opt/btsync'),
  $storage_conf_path      = hiera('btsync::storage_conf_path', '/opt/btsync/.sync'),
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

  case $glibc23 {
    true:  { 
             $download_url = "http://download-lb.utorrent.com/endpoint/btsync/os/linux-glibc23-${arch}/track/stable"
             $file_name = "btsync_glibc23_${arch}.tar.gz"
           }
    false:  { 
             $download_url = "http://download-lb.utorrent.com/endpoint/btsync/os/linux-${arch}/track/stable"
             $file_name = "btsync_${arch}.tar.gz"
            }
  }

  file { 'btsync install dir':
    ensure => directory,
    path   => $install_dir,
  }

  file { 'btsync conf dir':
    ensure => directory,
    path   => $storage_conf_path,
  }

  exec { 'download btsync':
    cwd     => $tmp,
    path    => '/bin:/usr/bin',
    command => "wget -O ${file_name} ${download_url}",
    creates => "${tmp}/${file_name}",
    notify  => Exec['untar btsync'],
    require => Package['wget'],
  }

  exec { "untar btsync":
    require => File['btsync install dir'],
    cwd     => $tmp,
    path    => '/bin:/usr/bin',
    command => "tar -zxvf ${file_name} -C ${install_dir}",
    creates => "${install_dir}/btsync",
  }

  file { 'btsync conf file':
    ensure  => present,
    path    => "${install_dir}/btsync.json",
    require => File['btsync install dir'],
    content => template("${module_name}/btsync.json.erb"),
  }

  exec { 'btsync':
    require => [Exec['untar btsync'], File['btsync conf file', 'btsync conf dir']],
    cwd     => "${install_dir}",
    command => "${install_dir}/btsync --config btsync.json",
  }
}
