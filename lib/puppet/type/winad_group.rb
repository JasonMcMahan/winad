Puppet::Type.newtype(:winad_group) do
      @doc = %q{Create a new Windows AD Group.

        Example:

            winad_group { 'SQLAccessGroup':
                ensure                              => present,
                path                                => 'ou=CRM,DC=SHONESLABS,DC=com',
                group_scope                         => 'DomainLocal',
                group_category                      => 'Security',
                displayname                         => 'SQL Access Group',
            }

      }

      validate do
        fail('name is a required attribute') if self[:name].nil?
        fail('path is a required attribute') if self[:path].nil?
      end

      ensurable

      newparam(:name, :namevar => :true) do
        desc "Name of the Windows AD Group."
        validate do |value|
            fail Puppet::Error, "Windows AD Group '#{value}' must not contain the following values: <,>,:,\",/,\,|,?,*" if value =~ /[<,>,:,",\/,\\,|,?,*]/
        end
      end

      newparam(:path) do
        desc "Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created."
      end

      newproperty(:group_scope) do
        desc "Specifies the group scope of the group. Possible values of this parameter are DomainLocal or Global or Universal."
        newvalues("DomainLocal", "Global", "Universal")
        defaultto "DomainLocal"
      end

      newproperty(:group_category) do
        desc "Specifies the category of the group. Possible values of this parameter are Distribution or Security."
        newvalues("Distribution", "Security")
        defaultto "Security"
      end

      newproperty(:desc) do
        desc "Specifies a description of the object. This parameter sets the value of the Description property for the object. The LDAP Display Name (ldapDisplayName) for this property is \"description\"."
        defaultto 'Windows AD Group Managed by Puppet'

        validate do |value|
          fail Puppet::Error, "Invalid value. Must not contain any wild char characters." if Validator.is_valid_winadnames(value) != true
        end
      end

      newproperty(:displayname) do
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



      newparam(:homepage) do
        desc "Specifies the URL of the home page of the object. DAP Display Name (ldapDisplayName) for this property is \"wWWHomePage\""
      end

      newproperty(:credential) do
        desc "Specifies the user account credentials to use to perform this task."
      end

      newproperty(:instance) do
        desc "Specifies an instance of a group object to use as a template for a new group object."
      end

      newproperty(:managedby) do
        desc "Specifies the user or group that manages the object."
      end

      newparam(:other_attribs) do
        desc "Specifies object attribute values for attributes that are not represented by cmdlet parameters."
      end

      newproperty(:sam_account_name) do
        desc "Specifies the Security Account Manager (SAM) account name of the user, group, computer, or service account."
        validate do |value|
          fail Puppet::Error, "Not in range. Exceed 256 Characters." if value.length > 256
        end
      end

      newproperty(:server) do
        desc "Specifies the Active Directory Domain Services instance to connect to, by providing Active Directory Lightweight Domain Services, Active Directory Domain Services or Active Directory Snapshot instance."
      end


end
