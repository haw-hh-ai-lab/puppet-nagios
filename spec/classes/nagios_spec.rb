#
# behaviour testing for the nagios puppet module
# 
require 'spec_helper'

describe 'nagios' do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
  
  let(:facts) { {:domain => 'example.com',
				 :fqdn => 'testnode.example.com',
                 :hostname => 'testnode',
                 :operatingsystem => 'Ubuntu',
                 :operatingsystemrelease => '13.10',
                 :osfamily => 'Debian',
                 :ipaddress => '192.168.0.1'} }
  
  context 'minimal setup' do
    let(:title) { 'Test NFS Mount' }

    it do

      should compile
      
    end
  end
end