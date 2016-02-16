require 'puppetlabs_spec_helper/module_spec_helper'

describe Puppet::Type.type(:winad_ou).provider(:powershell) do
  let(:resource) { Puppet::Type.type(:winad_ou).new(:provider => :powershell, :name => "TESTOU2") }
  let(:provider) { resource.provider }
  
end
