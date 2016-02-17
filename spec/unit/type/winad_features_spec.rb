require 'puppetlabs_spec_helper/module_spec_helper'

describe Puppet::Type.type(:winad_features) do

  it "should throw an error for the absence of name" do
    expect {
      described_class.new(
        :ensure       => present,
      )
    }.to raise_error(/must be provided/)
  end

  it "should throw an error for an invalid value in name" do
    expect {
      described_class.new(
        :name         => 'somethingelse',
      )
    }.to raise_error(/is a required attribute/)
  end


  it "should accept all the valid values for net framework core feature" do
    expect {
      described_class.new(
        :name                   => 'net_framework_core',
        :ensure                 => present,
      )
    }.to_not raise_error
  end
  
  it "should accept all the valid values for ad domain services feature" do
    expect {
      described_class.new(
        :name                   => 'ad_domain_services',
        :ensure                 => present,
      )
    }.to_not raise_error
  end

end
