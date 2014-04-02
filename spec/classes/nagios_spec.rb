#
# behaviour testing for the nagios puppet module
# 
require 'spec_helper'

describe 'nagios' do
  let(:hiera_config) { 'spec/fixtures/hiera/hiera.yaml' }
  
  context 'minimal setup' do
    let(:title) { 'Test NFS Mount' }

    it do

      should compile
      
    end
  end
end