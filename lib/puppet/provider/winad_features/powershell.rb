require 'puppet/util/powershell'
Puppet::Type.type(:winad_features).provide(:powershell) do
    confine :operatingsystem => :windows
    defaultfor :operatingsystem => :windows

    commands :powershell => Powershell.getPowershellCommand

    def create
        self.class.send_log(:info, "call create()")
        
        case "#{name}"
        when "net_framework_core"
            powershell(["Install-WindowsFeature Net-Framework-Core"])
        when "ad_domain_services"
            if "true" == "#{name}"
                powershell(["Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools"])
            else
                powershell(["Install-windowsfeature -name AD-Domain-Services"])
            end
        else
            fail Puppet::Error, "Not a valid value."
        end        
    end

    def destroy
      self.class.send_log(:info, "call destroy()")
    end

    def exists?
      self.class.send_log(:info, "call exists?")
      begin
        (powershell(["(Get-WindowsFeature -Name " + getFeatureName(name) + ").Installed"] ).include? "True") ? true : false 
      rescue Puppet::ExecutionFailure => e
          self.class.send_log(:err, "Error In Commands: " + e.to_s)
          false
      end
          
    end

    def name
      "" + @resource[:name].to_s + ""
    end

    def with_management_tools
      "\"" + @resource[:with_management_tools].to_s + "\""
    end
    
    def getFeatureName(puppetModuleName)
        case puppetModuleName
        when "net_framework_core"
            return "Net-Framework-Core"
        when "ad_domain_services"
            return "-name AD-Domain-Services"
        when "net_framework_45_core"
            return "NET-Framework-45-Core"    
        else
            self.class.send_log(:err, "Error In Commands: ")       
        end  
    end
end



