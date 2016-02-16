require 'puppetlabs_spec_helper/module_spec_helper'

describe Puppet::Type.type(:winad_forest) do

  it "should throw an error for the absence of name or domain_name" do
    expect {
      described_class.new(
        :password       => 'V@grant@123',
      )
    }.to raise_error(/must be provided/)
  end

  it "should throw an error for the absence of password attribute." do
    expect {
      described_class.new(
        :name         => 'devops.shoneslabs.com',
        :domain_name  => 'devops.shoneslabs.com',
      )
    }.to raise_error(/is a required attribute/)
  end

  it "should throw an error for meeting the requirements for password attribute." do
    expect {
      described_class.new(
        :name         => 'devops.shoneslabs.com',
        :domain_name  => 'devops.shoneslabs.com',
        :password     => 'vagrant123',
      )
    }.to raise_error(/is not meeting/)
  end

  it "should throw an error for the absence of password attribute." do
    expect {
      described_class.new(
        :name         => 'devops.shoneslabs.com',
        :domain_name       => 'devops.shoneslabs.com',
      )
    }.to raise_error(/is a required attribute/)
  end

  it "should throw an error for the presence of wild chars in name attribute." do
     expect {
      described_class.new(:name => '?*')
    }.to raise_error(/must not contain/)
  end

  it "should throw an error for the presence of wild chars in domain_name attribute." do
    expect {
      described_class.new(
        :name           => 'devops.shoneslabs.com',
        :domain_name => '?*'
      )
    }.to raise_error(/must not contain/)
  end

  it "should throw an error for the presence of invalid values in domain_mode attribute." do
    expect {
      described_class.new(
        :name         => 'devops.shoneslabs.com',
        :domain_mode  => 'Redhat'
      )
    }.to raise_error(Puppet::ResourceError, /Invalid value/)
  end

  it "should throw an error for the presence of wild chars in domain_netbios_name attribute." do
    expect {
      described_class.new(
        :name           => 'devops.shoneslabs.com',
        :domain_netbios_name  => '*&<>?',
        :password       => 'V@grant@123',
      )
    }.to raise_error(/must not contain wild char/)
  end

  it "should throw an error for the excess length of domain_netbios_name attribute." do
    expect {
      described_class.new(
        :name           => 'devops.shoneslabs.com',
        :domain_netbios_name  => 'a' * 16,
        :password       => 'V@grant@123',
      )
    }.to raise_error(/cannot exceed/)
  end

  it "should throw an error for the presence of invalid values in forest_mode attribute." do
    expect {
      described_class.new(
        :name                 => 'devops.shoneslabs.com',
        :domain_netbios_name  => 'a' * 10,
        :password             => 'V@grant@123',
        :forest_mode          => 'Redhat',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the invalid absolute path in database_path attribute." do
    expect {
      described_class.new(
        :name           => 'devops.shoneslabs.com',
        :database_path  => '/tmp/foo',
        :password       => 'V@grant@123',
      )
    }.to raise_error(/must be fully qualified/)
  end

  it "should throw an error for the invalid absolute path in log_path attribute." do
    expect {
      described_class.new(
        :name       => 'devops.shoneslabs.com',
        :log_path   => '/tmp/foo',
        :password   => 'V@grant@123',
      )
    }.to raise_error(/must be fully qualified/)
  end

  it "should throw an error for the invalid absolute path in sys_vol_path attribute." do
     expect {
      described_class.new(
        :name           => 'devops.shoneslabs.com',
        :sys_vol_path   => '/tmp/foo',
        :password       => 'V@grant@123',
      )
    }.to raise_error(/must be fully qualified/)
  end

  it "should throw an error for the absence of acceptable values (true or false) in install_dns attribute." do
    expect {
      described_class.new(
        :name                 => 'devops.shoneslabs.com',
        :domain_netbios_name  => 'a' * 10,
        :password             => 'V@grant@123',
        :forest_mode          => 'Redhat',
        :install_dns          => '123',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the absence of acceptable values (true or false) in no_reboot_oncompletion attribute." do
    expect {
      described_class.new(
        :name                   => 'devops.shoneslabs.com',
        :domain_netbios_name    => 'a' * 10,
        :password               => 'V@grant@123',
        :forest_mode            => 'Redhat',
        :no_reboot_oncompletion => '123',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should accept all the valid values" do
    expect {
      described_class.new(
        :name                   => 'devops.shoneslabs.com',
        :domain_name            => 'devops.shoneslabs.com',
        :domain_netbios_name    => 'SHONESLABS',
        :password               => 'V@grant@123',
        :domain_mode            => 'Win2012R2',
        :forest_mode            => 'Win2012R2',
        :database_path          => 'C:\Windows\NTDS',
        :sys_vol_path           => 'C:\Windows\SYSVOL',
        :log_path               => 'C:\Windows\NTDS',
        :install_dns            => true,
        :no_reboot_oncompletion => false,
      )
    }.to_not raise_error
  end

end
