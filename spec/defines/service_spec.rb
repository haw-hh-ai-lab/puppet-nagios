#
# behaviour testing for the nagios puppet module
# 
require 'spec_helper'

describe 'nagios::service' do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
  
  concatdir            = '/var/lib/puppet/concat'
    
  let(:facts) { {
                 # the module concat needs this. Normaly set by concat through pluginsync
                 :concat_basedir         => concatdir,
                   
                 :domain                 => 'example.com',
				 :fqdn                   => 'testnode.example.com',
                 :hostname               => 'testnode',
                 :operatingsystem        => 'Ubuntu',
                 :operatingsystemrelease => '13.10',
                 :osfamily => 'Debian',
                 :ipaddress => '192.168.0.1'} }

  context 'minimal service' do
    let(:params) { {
                  :check_command        => 'check_ping',
                  :service_description => 'a test service' 
                 } }
                 
    let(:title) { 'minimal_ping' }
    
    it do

      should compile.with_all_deps
      
      # unfortunately, rspec-puppet cannot test exported resources 
      # should contain_puppet_service('nagios_service').with_name('testnode.example.com_minimal_ping')
      
    end
  end

end