require 'puppetlabs_spec_helper/module_spec_helper'

describe Puppet::Type.type(:winad_ou) do

  it "should throw an error for an invalid path" do
  end

  it "should throw an error for an invalid country code" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :country  => 'Australia',
      )
    }.to raise_error(/Country 'Australia' is not a valid country or not in the acceptable country list. Eg: country => 'IN'/)
  end

  it "should allow a valid country code" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :country  => 'IN',
      )
    }.to_not raise_error
  end

  it "should throw an error for an invalid zip code" do
  end

  it "should allow a valid zip code" do
  end

  it "should throw an error for the absence of acceptable values (Negotiate or Basic) in authtype attribute" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :authtype => 'somethingelse',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in city attribute" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :city     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in state attribute" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :state     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in street_address attribute" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :street_address     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in postalcode attribute" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :postalcode     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in desc attribute" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :desc     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in displayname attribute" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name     => 'MyOU01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :displayname     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should accept all the valid values" do
    expect {
      Puppet::Type.type(:winad_ou).new(
        :name                               => 'UserAccountsOU',
        :desc                               => 'Organizantional Unit Managed by Puppet',
        :path                               => 'DC=SHONESLABS,DC=win,DC=com',
        :server                             => 'SHONESLABS-srv1:60000',
        :protected_from_accidental_deletion => false,
        :state                              => 'GA',
        :city                               => 'Atlanta',
        :country                            => 'US',
        :postalcode                         => '30329',
      )
    }.to_not raise_error
  end



end
