Puppet::Type.newtype(:winad_forest) do
      @doc = %q{Installs a new Windows AD Forest Configuration.

        Example:

            winad_forest { 'shoneslabs':
                ensure                  => present,
                domain_name             => 'devops.shoneslabs.com',
                domain_netbios_name     => 'SHONESLABS',
                password                => 'V@grant@123',
            }

      }

      validate do
        fail('domain_name or name is a required attribute') if self[:domain_name].nil? && self[:name].nil?
        fail('password is a required attribute') if self[:password].nil?
      end

      ensurable
      newparam(:name, :namevar => :true) do
        desc "Specifies the fully qualified domain name (FQDN) for the root (first) domain in the forest. If the domain_name is present, that will be taken as the domain name else the name attribute."
        validate do |value|
            forbidden = ['<', '>', ':', '"', '/', '\\', '|', '?', '*'].join(',')

            if value =~ Regexp.new("[#{forbidden}]")
                fail Puppet::Error,
                "Users Name '#{value}' must not contain the following values: #{forbidden}"
            end
         end
      end

      newparam(:password) do
        desc "Supplies the password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Services Restore Mode."
        validate do |value|
            raise ArgumentError, "Password  is not meeting Windows requirements." if Validator.is_valid_password(value) != true
        end
      end

      newparam(:domain_name) do
        desc "Specifies the fully qualified domain name (FQDN) for the root (first) domain in the forest."
        validate do |value|
            fail Puppet::Error, "domain_name must not contain wild char characters and pipeline input" if Validator.is_valid_winadnames(value) != true
        end
        #TODO Validate Not accept wild char characters and not accept pipeline input
      end

      newparam(:domain_mode) do
        desc "Specifies the domain functional level of the first domain in the creation of a new forest. Tested only againt Win2012R2. Possible values are \"Win2003\", \"Win2008\",\"Win2008R2\",\"Win2012\",\"Win2012R2\"."
        defaultto "Win2012R2"
        newvalues("Win2003", "Win2008","Win2008R2","Win2012","Win2012R2")
      end

      newparam(:domain_netbios_name) do
        desc "Specifies the NetBIOS name for the root domain in the new forest.If this parameter is not set, then the default is automatically computed from the value of the domain_name parameter."
        #TODO Validate Not accept wild char characters and not accept pipeline input
        #Cannot exceed 16 characters or more
        validate do |value|
            fail Puppet::Error, "Domain Netbios Name length cannot exceed 15 characters" if value.length > 15
            fail Puppet::Error, "Domain Netbios Name must not contain wild char characters and pipeline input" if Validator.is_valid_winadnames(value) != true
        end
        munge do |value|
          value.upcase
        end
      end

      newparam(:forest_mode) do
        desc "Specifies the forest functional level for the new forest. Tested only againt Win2012R2. Possible values are \"Win2003\", \"Win2008\",\"Win2008R2\",\"Win2012\",\"Win2012R2\"."
        defaultto "Win2012R2"
        newvalues("Win2003", "Win2008","Win2008R2","Win2012","Win2012R2")
      end

      newparam(:database_path) do
        desc "Specifies the fully qualified, non-Universal Naming Convention (UNC) path to a directory on a fixed disk of the local computer that contains the domain database. The default is \'C:\Windows\NTDS\'."
        defaultto 'C:\Windows\NTDS'
        validate do |value|
            is_absolute = Puppet::Util.absolute_path?(value, :windows)
            fail Puppet::Error, "File paths must be fully qualified, not '#{value}'" unless is_absolute
            fail Puppet::Error, "File paths must not end with a forward slash" if value =~ /\/$/
        end
      end

      newparam(:log_path) do
        desc "Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer where the log file for this operation will be written. Default to C:\Windows\NTDS."
        defaultto 'C:\Windows\NTDS'
        validate do |value|
            is_absolute = Puppet::Util.absolute_path?(value, :windows)
            fail Puppet::Error, "File paths must be fully qualified, not '#{value}'" unless is_absolute
            fail Puppet::Error, "File paths must not end with a forward slash" if value =~ /\/$/
        end
      end

      newparam(:sys_vol_path) do
        desc "Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer where the Sysvol file will be written. Default to C:\Windows\SYSVOL."
        defaultto 'C:\Windows\SYSVOL'
        validate do |value|
            is_absolute = Puppet::Util.absolute_path?(value, :windows)
            fail Puppet::Error, "File paths must be fully qualified, not '#{value}'" unless is_absolute
            fail Puppet::Error, "File paths must not end with a forward slash" if value =~ /\/$/
        end
      end

      newparam(:install_dns) do
        desc "Specifies whether the DNS Server service should be installed and configured for the new forest."
        defaultto true
        newvalues(:true, :false)
      end

      newparam(:no_reboot_oncompletion) do
        desc "Specifies that the computer is not to be rebooted upon completion of this command. Default to false."
        defaultto false
        newvalues(:true, :false)
      end

end
