define btsync::instance(
  $clientname        = $name,
  $device_name       = 'My Sync Device',

  # 0 - randomize port
  $listening_port    = 0,
  
  # storage_path dir contains auxilliary app files
  # if no storage_path field: .sync/${listening_port} dir created in the directory
  # where binary is located.
  # otherwise user-defined directory will be used
  $storage_path      = undef,

  $pid_file          = undef,
  $check_for_updates = false,

  # use UPnP for port mapping
  $use_upnp          = true,

  # limits in kB/s
  # 0 - no limit
  $download_limit    = 0,
  $upload_limit      = 0,

  $use_gui           = false,

  # leave "listen" field undef to disable WebUI
  # leave "login" and "password" fields undef to disable credentials check
  $webui             = {},

  # !!! if you set shared folders in config file WebUI will be DISABLED !!!
  # shared directories specified in config file
  # override the folders previously added from WebUI.
  $shared_folders    = [],
  
  $conf             = {},
  $sentinel         = false,
  $default_template = true,

# Add these var for unit test
  $version          = $redis::version,
  $conf_dir         = $redis::conf_dir,
  $data_dir         = $redis::data_dir,
  $tmp              = $redis::tmp,
) {

  if ( $storage_path == '' ) {
    $storage_path_tmp = "/opt/btsync/.sync/${listening_port}"
  } else {
    $storage_path_tmp = $storage_path
  }

  file { "btsync storage dir ${listening_port}":
    ensure  => directory,
    path    => $storage_path_tmp,
    require => File['btsync storage dir'],
  }

  if ( $pid_file == '' ) {
    $pid_file_tmp = "/var/run/btsync_${listening_port}.pid"
  } else {
    $pid_file_tmp = $pid_file
  }
}