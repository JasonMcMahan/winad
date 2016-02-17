require 'puppetlabs_spec_helper/module_spec_helper'

describe Puppet::Type.type(:winad_features) do

  it "should throw an error for the empty name" do
    expect {
      described_class.new(
          :name         => '',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for an invalid value in name" do
    expect {
      described_class.new(
        :name         => 'somethingelse',
      )
    }.to raise_error(/Invalid value/)
  end


  it "should accept all the valid values for net framework core feature" do
    expect {
      described_class.new(
        :name                   => 'net_framework_core',
      )
    }.to_not raise_error
  end
  
  it "should accept all the valid values for ad domain services feature" do
    expect {
      described_class.new(
        :name                   => 'ad_domain_services',
      )
    }.to_not raise_error
  end

end
