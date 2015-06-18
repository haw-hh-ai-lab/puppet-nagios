#
# behaviour testing for the imap/pop3 check commands
# 
require 'spec_helper'

describe 'nagios::rsp_test', :type => :class do
    
  context 'set commands for default environment' do

    it { should contain_file('/tmp/dummy') }
    it { should have_file_count(1) }
    it { should contain_file('/tmp/dummy2') }
    it { should have_nagios_command_count(1) }
    it { should contain_nagios_command('check_imap_ssl') } 
    it { should contain_nagios_command('check_imap_ssl').that_requires('Package[nagios]') }

  end


end