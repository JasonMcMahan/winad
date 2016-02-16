require 'pathname'
require 'puppet/util/validator'
Puppet::Type.newtype(:winad_ou) do
      @doc = %q{Create a new Windows AD Organizantional Unit.

        Example:

            winad_ou { 'UserAccounts':
                ensure                              => present,
                desc                                => 'Organizantional Unit Managed by Puppet',
                path                                => 'DC=SHONESLABS,DC=com',
                server                              => 'SHONESLABS-srv1:60000',
                protected_from_accidental_deletion  => false,
                displayname                         => 'User Account OU',
            }

      }

    validate do
      fail('path is a required attribute') if self[:path].nil?
      fail('name is a required attribute') if self[:name].nil?
    end

    ensurable do
      defaultvalues
      defaultto :present
    end
      newparam(:name, :namevar => :true) do
        desc "Name of the Organizantional Unit."
        validate do |value|
            fail Puppet::Error, "Organizational Unit '#{value}' must not contain the following values: <,>,:,\",/,\,|,?,*" if value =~ /[<,>,:,",\/,\\,|,?,*]/
        end
      end

      newparam(:path) do
        desc "Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created."
        isrequired
      end

      newparam(:protected_from_accidental_deletion) do
        desc "Specifies whether to prevent the object from being deleted. When this property is set to true, you cannot delete the corresponding object without changing the value of the property."
        defaultto false
        newvalues(:true, :false)
      end

      newproperty(:desc) do
        desc "Specifies a description of the object. This parameter sets the value of the Description property for the object. The LDAP Display Name (ldapDisplayName) for this property is \"description\"."
        defaultto 'Organizantional Unit Managed by Puppet'

        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end
      end

      newparam(:authtype) do
        desc "Specifies the authentication method to use (Negotiate or Basic)"
        defaultto 'Negotiate'

        validate do |value|
          unless['Negotiate', 'Basic'].include? value
            raise ArgumentError, "Invalid value. Provide either Negotiate or Basic as the value"
          end
        end
      end

      newparam(:displayname) do
        desc "Specifies the display name of the object. The LDAP Display Name (ldapDisplayName) for this property is \"displayName\""

        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end
      end

      newproperty(:street_address) do
        desc "Specifies the organizational unit's street address."
        defaultto ''

        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end

      end

      newproperty(:state) do
        desc "Specifies the user's or Organizational Unit's state or province."
        defaultto ''
        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end

      end

      newproperty(:city) do
        desc "Specifies the user's town or city. The LDAP display name (ldapDisplayName) of this property is \"l\""
        defaultto ''
        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end
      end

      newparam(:country) do
        desc "Specifies the country or region code for the user's language of choice.The LDAP Display Name (ldapDisplayName) of this property is \"c\". This value is not used by Windows 2000."
        validate do |value|
            raise ArgumentError, "Country '#{value}' is not a valid country or not in the acceptable country list. Eg: country => \'IN\'" if Validator.is_valid_country_code(value) != true
        end

        munge do |value|
          value.upcase
        end
      end

      newproperty(:postalcode) do
        desc "Specifies the user's postal code or zip code. The LDAP Display Name (ldapDisplayName) of this property is \"postalCode\"."
        defaultto ''
        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end
      end




      newproperty(:credential) do
        desc "Specifies the user account credentials to use to perform this task."
      end

      newproperty(:instance) do
        desc "Specifies an instance of an organizational unit object to use as a template for a new organizational unit object."
      end

      newproperty(:managedby) do
        desc "Specifies the user or group that manages the object."
      end

      newproperty(:other_attribs) do
        desc "Specifies object attribute values for attributes that are not represented by cmdlet parameters."
      end

      newproperty(:server) do
        desc "Specifies the Active Directory Domain Services instance to connect to, by providing Active Directory Lightweight Domain Services, Active Directory Domain Services or Active Directory Snapshot instance."
      end

end
