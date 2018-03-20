require 'puppet/util/powershell'
Puppet::Type.type(:winad_ou).provide(:powershell) do
    confine :operatingsystem => :windows
    defaultfor :operatingsystem => :windows

    commands :powershell => Puppet::Util::Powershell.getPowershellCommand

    def create
      self.class.send_log(:info, "call create()")

          powershell(["import-module activedirectory;","New-ADOrganizationalUnit",
          " -Name #{name}",
          " -Description #{desc}",
          " -Path #{path}",
          " -DisplayName #{displayname}",
          " -StreetAddress #{street_address}",
          " -City #{city}",
          " -State #{self.state}",
          " -Country #{country}",
          " -PostalCode #{postalcode}",
          " -ProtectedFromAccidentalDeletion $false"])
    end

    def destroy
        self.class.send_log(:info, "call destroy()")
        powershell([ "import-module activedirectory;","Set-ADOrganizationalUnit"," -ProtectedFromAccidentalDeletion $false"," -Identity \"OU=#{@resource[:name]},#{@resource[:path]}\";"])
        powershell([ "import-module activedirectory;","Remove-ADOrganizationalUnit","-Identity \"OU=#{@resource[:name]},#{@resource[:path]}\""," -Confirm:$false -Recursive;"])

    end

    def exists?
      self.class.send_log(:info, "call exists?")
      begin
        isADModuleLoaded =   powershell([ "Import-Module ADDSDeployment;Get-Module | where {$_.Name -eq \"ActiveDirectory\"}"])
        # 
        self.class.send_log(:info, "isADModuleLoaded "+isADModuleLoaded)
          #TODO Why the above commands return null. Directly from Powershell return value
       # unless isADModuleLoaded.nil? || isADModuleLoaded.empty?

            myreturnvalue =   powershell([ "import-module ActiveDirectory;","Get-ADOrganizationalUnit -Filter {(name -eq \"#{@resource[:name]}\")}"])
            self.class.send_log(:info, "Get-ADOrganizationalUnit: The return value is : #{myreturnvalue} ")

            if myreturnvalue == ""
                false
            else
                true
            end
      #  else
        #      fail Puppet::Error, "Module for Active Directory is not loaded on this machine. Please run winad_forest to install the forest."
       #     false
      #  end
      rescue Puppet::ExecutionFailure => e1
        self.class.send_log(:err, "Error In Commands: ")
        false
      rescue NoMethodError => e2
        self.class.send_log(:err, "NoMethodError " )
        false
      end  
    end

    def path
      "\"" + @resource[:path].to_s + "\""
    end

    def desc
      "\"" + @resource[:desc].to_s + "\""
    end

    def desc=(value)
    end

    def street_address
      "\"" + @resource[:street_address].to_s + "\""
    end
    def street_address=(value)
    end

    def city
      "\"" + @resource[:city].to_s + "\""
    end
    def city=(value)
    end

    def state
      "\"" + @resource[:state].to_s + "\""
    end
    def state=(value)
    end

    def country
      "\"" + @resource[:country].to_s + "\""
    end
    def country=(value)
    end

    def postalcode
      "\"" + @resource[:postalcode] + "\""
    end
    def postalcode=(value)
    end

    def name
      "" + @resource[:name].to_s + ""
    end

    def displayname
      "\"" + @resource[:displayname].to_s + "\""
    end
end
