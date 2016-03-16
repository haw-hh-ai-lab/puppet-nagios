#
# behaviour testing for the imap/pop3 check commands
#
require 'spec_helper'

describe 'nagios::command::imap_pop3', :type => :class do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }

  let(:facts) { {
                 :operatingsystem        => 'SLES',
                 :osfamily               => 'SLES',
                 } }

  context 'set commands for non-ubuntu/Debian environment' do

    it { should compile }
    it { should contain_class('nagios::command::imap_pop3') }

    it do

      should contain_nagios_command('check_imap_ssl')
      should contain_nagios_command('check_pop3')
      should contain_nagios_command('check_pop3_ssl')
      should contain_nagios_command('check_managesieve')

      should contain_nagios_command('check_imap')

    end
  end

  context 'set commands for Ubuntu/Debian' do

  let(:facts) { {
                 :operatingsystem        => 'Ubuntu',
                 :osfamily               => 'Debian',
                 } }

    it do

      should contain_nagios_command('check_imap_ssl')
      should contain_nagios_command('check_pop3')
      should contain_nagios_command('check_pop3_ssl')
      should contain_nagios_command('check_managesieve')

      should_not contain_nagios_command('check_imap')

    end
  end

end