require 'spec_helper'

describe 'btsync' do

  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }

  it { should contain_class('singleton') }
  it { should contain_package('singleton_package_wget') }

  context "with default param" do

    it do
      should contain_file('btsync install dir').with({
        'ensure'    => 'directory',
        'path'  => '/opt/btsync',
      })
    end

    it do
      should contain_file('btsync conf dir').with({
        'ensure'    => 'directory',
        'path'  => '/opt/btsync/.sync',
      })
    end

    it do
      should contain_exec('download btsync').with({
        'cwd'     => '/tmp',
        'path'    => '/bin:/usr/bin',
        'command' => 'wget -O btsync_glibc23_x64.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-glibc23-x64/track/stable',
        'creates' => '/tmp/btsync_glibc23_x64.tar.gz',
        'notify'  => 'Exec[untar btsync]',
        'require' => 'Package[wget]',
      })
    end

    it do
      should contain_exec('untar btsync').with({
        'cwd'     => '/tmp',
        'path'    => '/bin:/usr/bin',
        'command' => 'tar -zxvf btsync_glibc23_x64.tar.gz -C /opt/btsync',
        'creates' => '/opt/btsync/btsync',
        'require' => 'File[btsync install dir]',
      })
    end

    it do
      should contain_file('btsync conf file').with({
        'ensure'  => 'present',
        'path'    => '/opt/btsync/btsync.json',
        'require' => 'File[btsync install dir]',
      })
    end

    it do
      should contain_exec('btsync').with({
        'cwd'    => '/opt/btsync',
        'command'    => '/opt/btsync/btsync --config btsync.json',
        'require' => ['Exec[untar btsync]', 'File[btsync conf file]', 'File[btsync conf dir]'],
      })
    end

  end

  context "with glibc23 param" do
    let(:params) { {:glibc23 => false} }

    it do
      should contain_exec('download btsync').with({
        'cwd'     => '/tmp',
        'path'    => '/bin:/usr/bin',
        'command' => 'wget -O btsync_x64.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable',
        'creates' => '/tmp/btsync_x64.tar.gz',
        'notify'  => 'Exec[untar btsync]',
        'require' => 'Package[wget]',
      })
    end

    it do
      should contain_exec('untar btsync').with({
        'cwd'     => '/tmp',
        'path'    => '/bin:/usr/bin',
        'command' => 'tar -zxvf btsync_x64.tar.gz -C /opt/btsync',
        'creates' => '/opt/btsync/btsync',
        'require' => 'File[btsync install dir]',
      })
    end

  end

  context "with arch param" do
    let(:params) { {:glibc23 => false} }
    let(:facts) { {:architecture => 'i386'} }

    it do
      should contain_exec('download btsync').with({
        'cwd'     => '/tmp',
        'path'    => '/bin:/usr/bin',
        'command' => 'wget -O btsync_i386.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-i386/track/stable',
        'creates' => '/tmp/btsync_i386.tar.gz',
        'notify'  => 'Exec[untar btsync]',
        'require' => 'Package[wget]',
      })
    end

    it do
      should contain_exec('untar btsync').with({
        'cwd'     => '/tmp',
        'path'    => '/bin:/usr/bin',
        'command' => 'tar -zxvf btsync_i386.tar.gz -C /opt/btsync',
        'creates' => '/opt/btsync/btsync',
        'require' => 'File[btsync install dir]',
      })
    end

  end

end
at_exit { RSpec::Puppet::Coverage.report! }
