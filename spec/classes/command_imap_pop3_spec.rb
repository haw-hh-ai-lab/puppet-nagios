#
# behaviour testing for the imap/pop3 check commands
# 
require 'spec_helper'

describe 'nagios::command::imap_pop3' do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
    
    
  context 'set commands for default environment' do
   
    
    it do

      should contain_nagios_command('check_imap_ssl')
      should contain_nagios_command('check_pop3').that_requires('Package[nagios]')
      should contain_nagios_command('check_pop3_ssl').that_requires('Package[nagios]')
      should contain_nagios_command('check_managesieve').that_requires('Package[nagios]')

      should contain_nagios_command('check_imap').that_requires('Package[nagios]')
          
    end
  end

  context 'set commands for Ubuntu/Debian' do

  let(:facts) { {
                 :operatingsystem        => 'Ubuntu',
                 :osfamily => 'Debian',} }
    
    it do

      should contain_nagios_command('check_imap_ssl').that_requires('Package[nagios3]')
      should contain_nagios_command('check_pop3').that_requires('Package[nagios]')
      should contain_nagios_command('check_pop3_ssl').that_requires('Package[nagios]')
      should contain_nagios_command('check_managesieve').that_requires('Package[nagios]')

      should_not contain_nagios_command('check_imap')
      
    end
  end

end