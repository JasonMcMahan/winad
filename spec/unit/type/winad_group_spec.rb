require 'puppetlabs_spec_helper/module_spec_helper'

describe Puppet::Type.type(:winad_group) do

  it "should throw an error for an invalid path" do
  end

  it "should throw an error for the absence of acceptable values in group_scope attribute" do
    expect {
      Puppet::Type.type(:winad_group).new(
        :name     => 'MyGroup01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :group_scope => 'somethingelse',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the absence of acceptable values in group_category attribute" do
    expect {
      Puppet::Type.type(:winad_group).new(
        :name     => 'MyGroup01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :group_category => 'somethingelse',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in desc attribute" do
    expect {
      Puppet::Type.type(:winad_group).new(
        :name     => 'MyGroup01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :desc     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should throw an error for the presence of wild char characters in displayname attribute" do
    expect {
      Puppet::Type.type(:winad_group).new(
        :name     => 'MyGroup01',
        :path     => 'DC=shoneslabs,DC=win,DC=com',
        :displayname     => '*<>ghh?',
      )
    }.to raise_error(/Invalid value/)
  end

  it "should accept all the valid values" do
    expect {
      Puppet::Type.type(:winad_group).new(
        :name           => 'MyGroup01',
        :desc           => 'Organizantional Unit Managed by Puppet',
        :path           => 'OU=TestOU,DC=shoneslabs,DC=win,DC=com',
        :group_scope    => 'DomainLocal',
        :group_category => 'Security',
        :displayname    => 'MyGroup01',
      )
    }.to_not raise_error
  end



end
