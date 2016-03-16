#
# behaviour testing for the imap/pop3 check commands
#
require 'spec_helper'

describe 'nagios::command::nrpe' do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }

  let(:facts) { {
             :operatingsystem        => 'SLES',
             :osfamily               => 'SLES',
             } }

  context 'set nagios commands for nrpe checks' do


    it { should compile }
    it { should contain_class('nagios::command::nrpe') }

    it do

      should contain_nagios_command('check_nrpe')
      should contain_nagios_command('check_nrpe_1arg')

      should contain_nagios_command('check_nrpe_timeout')
      should contain_nagios_command('check_nrpe_1arg_timeout')


    end
  end

  context 'set nagios commands for nrpe checks' do

    let(:facts) { {
               :operatingsystem        => 'Ubuntu',
               :osfamily               => 'Debian',
               } }

    it do

      should contain_nagios_command('check_nrpe').with_ensure('absent')
      should contain_nagios_command('check_nrpe_1arg').with_ensure('absent')

      should contain_nagios_command('check_nrpe_timeout')
      should contain_nagios_command('check_nrpe_1arg_timeout')


    end
  end

end