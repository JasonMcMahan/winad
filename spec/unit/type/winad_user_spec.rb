require 'puppetlabs_spec_helper/module_spec_helper'

describe Puppet::Type.type(:winad_user) do

  it "should throw an error for the presence of wild char characters in desc attribute" do
    expect {
      described_class.new(
        :name   => 'PuppetUser01',
        :password   => 'V@grant@123',
        :desc    => 'invalid desc@*<>',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the empty name" do
    expect {
      described_class.new(
        :password   => 'V@grant@123',
      )
    }.to raise_error(/must be provided/)
  end

  it "should throw an error for meeting the requirements for password attribute." do
    expect {
      described_class.new(
        :name         => 'PuppetUser01',
        :password     => 'vagrant123',
      )
    }.to raise_error(/is not meeting/)
  end

  it "should throw an error for the absence of acceptable values (true or false) in password_never_expires attribute." do
    expect {
      described_class.new(
        :name         => 'PuppetUser01',
        :password     => 'V@grant@123',
        :password_never_expires => 'Some Thing else',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the absence of acceptable values (true or false) in enabled attribute." do
    expect {
      described_class.new(
        :name         => 'PuppetUser01',
        :password     => 'V@grant@123',
        :enabled => 'Some Thing else',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in displayname attribute" do
    expect {
      described_class.new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :displayname     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should accept all the valid values" do
    expect {
      described_class.new(
        :name                        => 'PuppetUser01',
        :path                        => 'CN=Users,DC=shoneslabs,DC=win,DC=com',
        :desc                        => 'Users managed by Puppet',
        :password_never_expires      => true,
        :password                    => 'V@grant@123',
        :enabled                     => true,
      )
    }.to_not raise_error
  end



end
