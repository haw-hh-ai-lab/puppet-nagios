#
# behaviour testing for the imap/pop3 check commands
# 
require 'spec_helper'

describe 'nagios::command::nrpe' do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
    
  context 'set nagios commands for nrpe checks' do
    
    it do

      should contain_nagios_command('check_nrpe') # .that_requires('Package[nagios]')
      should contain_nagios_command('check_nrpe_1arg') # .that_requires('Package[nagios]')

      should contain_nagios_command('check_nrpe_timeout') # .that_requires('Package[nagios]')
      should contain_nagios_command('check_nrpe_1arg_timeout') # .that_requires('Package[nagios]')
          
      
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

      should contain_nagios_command('check_nrpe_timeout') # .that_requires('Package[nagios]')
      should contain_nagios_command('check_nrpe_1arg_timeout') # .that_requires('Package[nagios]')
          
      
    end
  end

end