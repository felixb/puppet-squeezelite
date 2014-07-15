require 'spec_helper'

describe 'squeezelite' do

  ['x86', 'x86_64', 'arm'].each do |arch|

    let(:facts) {{ :architecture => arch }}

    context "with defaults for all parameters, architecture: #{arch}" do
      it { should contain_class('squeezelite') }
      it { should contain_class('squeezelite::install') }
      it { should contain_class('squeezelite::config') }
      it { should contain_class('squeezelite::service') }
      it { should contain_service('squeezelite') }
      it { should contain_file('/usr/local/bin/squeezelite') }
      it { should contain_file('/etc/init.d/squeezelite') }
      it { should contain_file('/etc/default/squeezelite') }
    end
  end

  # simplify tests, test only one arch
  let(:facts) {{
    :architecture => 'x86',
    :hostname     => 'foo.host.example.com',
  }}

  context 'test hostname' do
    it { should contain_file('/etc/default/squeezelite').with({
        'content' => /SL_NAME="foo.host.example.com"/
      })
    }
  end

  context 'test player_name param' do
    let(:params) {{ :player_name => 'booboooooom' }}
    it { should contain_file('/etc/default/squeezelite').with({
        'content' => /SL_NAME="booboooooom"/
      })
    }
  end

  describe 'package latest' do
    let(:params) {{ :package_ensure => 'latest' }}

    it { should contain_service('squeezelite') }
    it { should contain_file('/usr/local/bin/squeezelite').with({
      'ensure' => 'file'
    })}
    it { should contain_file('/etc/init.d/squeezelite').with({
      'ensure' => 'file'
    })}
    it { should contain_file('/etc/default/squeezelite').with({
      'ensure' => 'file'
    })}
  end

  describe 'package present' do
    let(:params) {{ :package_ensure => 'present' }}

    it { should contain_service('squeezelite') }
    it { should contain_file('/usr/local/bin/squeezelite').with({
      'ensure' => 'file'
    })}
    it { should contain_file('/etc/init.d/squeezelite').with({
      'ensure' => 'file'
    })}
    it { should contain_file('/etc/default/squeezelite').with({
      'ensure' => 'file'
    })}
  end

  describe 'package absent' do
    let(:params) {{ :package_ensure => 'absent' }}

    it { should_not contain_service('squeezelite') }
    it { should contain_file('/usr/local/bin/squeezelite').with({
      'ensure' => 'absent'
    })}
    it { should contain_file('/etc/init.d/squeezelite').with({
      'ensure' => 'absent'
    })}
    it { should contain_file('/etc/default/squeezelite').with({
      'ensure' => 'absent'
    })}
  end

  describe 'service unmanaged' do
    let(:params) {{ :service_manage => false }}

    it { should_not contain_service('squeezelite') }
    it { should contain_file('/usr/local/bin/squeezelite') }
    it { should contain_file('/etc/init.d/squeezelite') }
    it { should contain_file('/etc/default/squeezelite') }
  end
end
