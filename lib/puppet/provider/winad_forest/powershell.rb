require 'puppet/util/powershell'
Puppet::Type.type(:winad_forest).provide(:powershell) do
    confine :operatingsystem => :windows
    defaultfor :operatingsystem => :windows

    commands :powershell => Powershell.getPowershellCommand

    def create
        self.class.send_log(:info, "call create()")

        powershell(["Import-Module ADDSDeployment;","Install-ADDSForest",
        " -DomainName #{domain_name}",
        " -DomainNetbiosName #{domain_netbios_name}",
        " -DomainMode #{domain_mode}",
        " -ForestMode #{forest_mode}",
        " -DatabasePath  #{database_path}",
        " -LogPath  #{log_path}",
        " -SysvolPath #{sys_vol_path}",
        " -InstallDns:$true",
        " -NoRebootOnCompletion:$false",
        " -SafeModeAdministratorPassword (ConvertTo-SecureString '#{@resource[:password]}' -AsPlainText -force)",
        " -CreateDnsDelegation:$false",
        " -Force:$true"])
        
    end

    def destroy
      self.class.send_log(:info, "call destroy()")

      powershell(["Import-Module ADDSDeployment;","Uninstall-ADDSDomainController",
      " -LocalAdministratorPassword (ConvertTo-SecureString '#{@resource[:password]}' -asplaintext -force)",
      " -DemoteOperationMaster:$True",
      " -ForceRemoval:$True",
      " -Force:$True"])
    end

    def exists?
      self.class.send_log(:info, "call exists?")
      begin
        isADModuleAvailable = powershell(["Get-Module -ListAvailable | where {$_.Name -eq \"ActiveDirectory\"} "] )
            
        unless isADModuleAvailable.nil? || isADModuleAvailable.empty?
          
            myreturnvalue =   powershell([ "import-module ActiveDirectory;","Get-ADForest -Identity #{domain_name}"])

            self.class.send_log(:debug, "Get-ADForest: The return value is : #{myreturnvalue} ")

            if myreturnvalue == ""
              false
            else
                
              true
            end
        else
            fail Puppet::Error, "Module for Active Directory is not available on this machine."
        end    
      rescue Puppet::ExecutionFailure => e
        #  self.class.send_log(:err, "Error In Commands: " + e)
          false
      end
          
    end

    def name
      "" + @resource[:name].to_s + ""
    end

    def domain_name
      "\"" + @resource[:domain_name].to_s + "\""
      #TODO, if domain name is absent, take name
    end

    def domain_netbios_name
      "\"" + @resource[:domain_netbios_name].to_s + "\""
    end

    def domain_mode
      "\"" + @resource[:domain_mode].to_s + "\""
    end

    def forest_mode
      "\"" + @resource[:forest_mode].to_s + "\""
    end

    def database_path
      "\"" + @resource[:database_path].to_s + "\""
    end

    def log_path
      "\"" + @resource[:log_path].to_s + "\""
    end

    def sys_vol_path
      "\"" + @resource[:sys_vol_path].to_s + "\""
    end

    def install_dns
      ":$" + @resource[:install_dns]
    end

    def no_reboot_oncompletion
      ":$" + @resource[:no_reboot_oncompletion]
    end

end
