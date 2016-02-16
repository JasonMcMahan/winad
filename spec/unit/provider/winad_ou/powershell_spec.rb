require 'puppetlabs_spec_helper/module_spec_helper'
require 'spec_helper'
require 'puppet/type'
require 'puppet/type/winad_ou'

describe Puppet::Type.type(:winad_ou).provider(:powershell) do
  let(:resource) { Puppet::Type.type(:wget).winad_ou(
    :provider     => :powershell,
    :name         => "TestOU3",
    :ensure       => present,
    :path         => 'DC=shoneslabs,DC=win,DC=com',
    :city         => 'Atlanta',
    :state        => 'GA',
    :postalcode   => '30329',
    :country      => 'US',
  )}
  let(:provider) { resource.provider }

  describe ".create" do
    let(:the_response) { mock('response') }

    context "when provide a path" do
      it "should create the organizational unit" do
      end
    end

    context "when not provide a path" do
      it "should raise the appropriate error" do
        #ole.stubs(:create).returns(2)
        #expect{provider.create}.to raise_error(/Access Denied/)
      end
    end

  end

  describe ".destroy" do
  end

  describe ".exists?" do
  end


end
