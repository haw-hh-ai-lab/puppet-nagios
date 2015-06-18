#
# behaviour testing for the nagios puppet module
# 
require 'spec_helper'

describe 'nagios' do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
  
  concatdir            = '/var/lib/puppet/concat'
    
  let(:facts) do
    {
       # the module concat needs this. Normaly set by concat through pluginsync
       :concat_basedir         => concatdir,

       :domain                 => 'example.com',
       :fqdn                   => 'testnode.example.com',
       :hostname               => 'testnode',
       :operatingsystem        => 'Ubuntu',
       :operatingsystemrelease => '13.10',
       :osfamily               => 'Debian',
       :ipaddress              => '192.168.0.1'
    }
  end
  
  context 'minimal setup' do

    it { should compile }
      
  end
end