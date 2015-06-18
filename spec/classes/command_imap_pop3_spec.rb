#
# behaviour testing for the imap/pop3 check commands
# 
require 'spec_helper'

describe 'nagios::command::imap_pop3', :type => :class do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
    
  context 'set commands for default environment' do

    let :facts do
      {
      :operatingsystem        => 'NonExistant',
      :osfamily               => 'NoFamily',
      }
    end

    
#    it { should have_nagios_command_count(5) }
   
    it { should contain_nagios_command('check_imap_ssl') } # .that_requires('Package[nagios]')
    it { should contain_nagios_command('check_pop3') } # .that_requires('Package[nagios]')
    it { should contain_nagios_command('check_pop3_ssl') } # .that_requires('Package[nagios]')
    it { should contain_nagios_command('check_managesieve') } # .that_requires('Package[nagios]')

    it { should contain_nagios_command('check_imap') } #.that_requires('Package[nagios-plugins]')
  end

  context 'set commands for Ubuntu/Debian' do

    let(:facts) { {
                   :operatingsystem        => 'Ubuntu',
                   :osfamily               => 'Debian',
                   } }

#    it { should have_nagios_command_count(1) }
      
    it { should contain_nagios_command('check_imap_ssl') } # .that_requires('Package[nagios]')
    it { should contain_nagios_command('check_pop3')  } # .that_requires('Package[nagios]')
    it { should contain_nagios_command('check_pop3_ssl') } # .that_requires('Package[nagios]')
    it { should contain_nagios_command('check_managesieve') } # .that_requires('Package[nagios]')

      it { should_not contain_nagios_command('check_imap') }
      
  end

end