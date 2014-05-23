#
# behaviour testing for the nagios puppet module
# 
require 'spec_helper'

describe 'nagios::apache' do
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

  context 'basic apache web-frontend' do
    let(:params) { { } }
    
    it do

      should compile
      
    end
  end

  context 'apache web-frontend with ldap based access control' do
    let(:params) { {
                    :auth_type    => 'ldap',
                    :auth_config  => {
                        :ldap_require   => 'ldap-group cn=a_group,ou=Groups,ou=dept,o=example',
                        :ldap_url       => 'ldap://myldap.example.com/ou=Users,ou=dept,o=example?uid??(objectClass=posixAccount) TLS',
                        :ldap_bind_dn   => 'cn=auth-obj,ou=Admin,ou=dept,o=company',
                        :ldap_bind_pw   => 'myVerySecretPW',
                     },
                  } }
    
    it do

      should compile
      
    end
  end

end