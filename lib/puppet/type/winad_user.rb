Puppet::Type.newtype(:winad_user) do
      @doc = %q{Create a new Windows AD User.

        Example:

            winad_user { 'shones':
                ensure                              => present,
                desc                                => 'Users Managed by Puppet',
                path                                => 'DC=SHONESLABS,DC=com',
                server                              => 'SHONESLABS-srv1:60000',
                displayname                         => 'User Account OU',
            }

      }

      validate do
        fail('name is a required attribute') if self[:name].nil?
        fail('password is a required attribute') if self[:password].nil?
      end

      ensurable
      newparam(:name, :namevar => :true) do
        desc "Users Name. he LDAP Display Name (ldapDisplayName) of this property is \"name\""
        validate do |value|
            fail Puppet::Error, "Users Name '#{value}' must not contain the following values: <,>,:,\",/,\,|,?,*" if value =~ /[<,>,:,",\/,\\,|,?,*]/
        end
      end


      newparam(:path) do
        desc "Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created."
        #TODO Make it mandatory
      end

      newparam(:password) do
        desc "Specifies a new password value for an account."
        defaultto 'Puppet@123'

        validate do |value|
            raise ArgumentError, "Password  is not meeting Windows requirements." if Validator.is_valid_password(value) != true
        end
      end

      newparam(:enabled) do
        desc "Specifies if an account is enabled. An enabled account requires a password."
        defaultto true
        newvalues(:true, :false)
      end

      newparam(:password_never_expires) do
        desc "Specifies whether the password of an account can expire."
        defaultto true
        newvalues(:true, :false)
      end

      newparam(:protected_from_accidental_deletion) do
        desc "Specifies whether to prevent the object from being deleted. When this property is set to true, you cannot delete the corresponding object without changing the value of the property."
        defaultto false
        newvalues(:true, :false)
      end

      newproperty(:desc) do
        desc "Specifies a description of the object. This parameter sets the value of the Description property for the object. The LDAP Display Name (ldapDisplayName) for this property is \"description\"."
        defaultto 'Windows AD User Managed by Puppet'

        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end
      end

      newparam(:surname) do
        desc "Specifies the user's last name or surname. The LDAP display name (ldapDisplayName) of this property is \"sn\""
        defaultto ''
      end

      newparam(:givenname) do
        desc "Specifies the user's given name. The LDAP display name (ldapDisplayName) of this property is \"givenName\""
        defaultto ''
      end

      newparam(:initials) do
        desc "Specifies the initials that represent part of a user's name. The LDAP display name (ldapDisplayName) of this property is \"initials\""
        defaultto ''
      end

      newparam(:type) do
        desc "Specifies the type of object to create."
        defaultto "User"
        newvalues("User", "InetOrgPerson")
      end

      newparam(:title) do
        desc "Specifies the user's title. The LDAP display name (ldapDisplayName) of this property is \"title\""
        defaultto ''
      end

      newparam(:company) do
        desc "Specifies the user's company. The LDAP display name (ldapDisplayName) of this property is \"company\""
        defaultto ''
      end

      newparam(:department) do
        desc "Specifies the user's department. The LDAP display name (ldapDisplayName) of this property is \"department\""
        defaultto ''
      end

      newparam(:division) do
        desc "Specifies the user's division. The LDAP display name (ldapDisplayName) of this property is \"division\""
        defaultto ''
      end

      newparam(:emailaddress) do
        desc "Specifies the user's e-mail address. The LDAP display name (ldapDisplayName) of this property is \"mail\""
        defaultto ''
      end

      newparam(:fax) do
        desc "Specifies the user's fax mobile number. The LDAP display name (ldapDisplayName) of this property is \"facsimileTelephoneNumber\""
        defaultto ''
        #TODO REGEX Verification
      end

      newparam(:homephone) do
        desc "Specifies the user's home telephone number. The LDAP display name (ldapDisplayName) of this property is \"homePhone\""
        defaultto ''
        #TODO REGEX Verification
      end

      newparam(:mobilephone) do
        desc "Specifies the user's mobile phone number. The LDAP display name (ldapDisplayName) of this property is \"mobile\""
        defaultto ''
        #TODO REGEX Verification
      end

      newparam(:employee_id) do
        desc "Specifies the user's employee ID. The LDAP display name (ldapDisplayName) of this property is \"employeeID\""
        defaultto ''
      end

      newparam(:employee_number) do
        desc "Specifies the user's employee number. The LDAP display name (ldapDisplayName) of this property is \"employeeNumber\""
        defaultto ''
      end

      newparam(:displayname) do
        desc "Specifies the display name of the object. The LDAP Display Name (ldapDisplayName) for this property is \"displayName\""

        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end
      end

      newparam(:authtype) do
        desc "Specifies the authentication method to use (Negotiate or Basic)"

        validate do |value|
          unless['Negotiate', 'Basic'].include? value
            raise ArgumentError, "Provide either Negotiate or Basic as the value"
          end
        end
      end

      newproperty(:home_directory) do
        desc "Specifies a user's home directory. The LDAP Display Name (ldapDisplayName) for this property is \"homeDirectory\"."
      end

      newproperty(:home_drive) do
        desc "Specifies a drive that is associated with the UNC path defined by the HomeDirectory property. The LDAP Display Name (ldapDisplayName) for this property is \"homeDrive\"."
      end

      newparam(:home_page) do
        desc "Specifies the URL of the home page of the object. The LDAP Display Name (ldapDisplayName) for this property is \"wWWHomePage\"."
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

      newproperty(:whatif) do
        desc "Describes what would happen if you executed the command without actually executing the command."
      end



      #Address
      newparam(:street_address) do
        desc "Specifies the organizational unit's street address."
        defaultto ''
      end

      newparam(:state) do
        desc "Specifies the user's or Organizational Unit's state or province."
        defaultto ''
      end

      newparam(:city) do
        desc "Specifies the user's town or city. The LDAP display name (ldapDisplayName) of this property is \"l\""
        defaultto ''
      end

      newparam(:country) do
        desc "Specifies the country or region code for the user's language of choice.The LDAP Display Name (ldapDisplayName) of this property is \"c\". This value is not used by Windows 2000."
        defaultto ''
        #TODO Validate for 2 digit character code
        munge do |value|
          value.upcase
        end
      end

      newparam(:pobox) do
        desc "Specifies the user's post office box number. The LDAP Display Name (ldapDisplayName) of this property is \"postOfficeBox\"."
        defaultto ''
        #TODO Regex for Postal Code
      end

      newparam(:postalcode) do
        desc "Specifies the user's postal code or zip code. The LDAP Display Name (ldapDisplayName) of this property is \"postalCode\"."
        defaultto ''
        #TODO Regex for Postal Code
      end

      newparam(:allow_reversible_password_encryption) do
        desc "Specifies whether reversible password encryption is allowed for the account."
        defaultto false
        newvalues(:true, :false)
      end

      newparam(:cannot_change_password) do
        desc "Specifies whether the account password can be changed."
        defaultto false
        newvalues(:true, :false)
      end

      newparam(:change_password_atlogon) do
        desc "Specifies whether a password must be changed during the next logon attempt."
        defaultto false
        newvalues(:true, :false)
      end
end
