require 'puppet/util/powershell'
Puppet::Type.type(:winad_group).provide(:powershell) do
    confine :operatingsystem => :windows
    defaultfor :operatingsystem => :windows

    commands :powershell => Powershell.getPowershellCommand


    def create
        self.class.send_log(:info, "call create()")

        powershell(["import-module activedirectory;","New-ADGroup",
        " -Name #{name}",
        " -Description  #{desc}",
        " -Path #{path}",
        " -DisplayName #{displayname}",
        " -GroupScope #{group_scope}",
        " -GroupCategory #{group_category}"])
    end

    def destroy
        self.class.send_log(:info, "call destroy()")
        powershell([ "import-module activedirectory;","Remove-ADGroup","-Identity #{@resource[:name]}"," -Confirm:$false"])

    end

    def exists?
        self.class.send_log(:info, "call exists?")
        begin
            myreturnvalue =   powershell([ "import-module activedirectory;","Get-ADGroup -Filter {(name -eq \"#{@resource[:name]}\")}"])
            self.class.send_log(:debug, "Get-ADGroup: The return value is : #{myreturnvalue} ")

            if myreturnvalue == ""
                false
            else
                true
            end
        rescue Puppet::ExecutionFailure => e
            self.class.send_log(:err, "Error In Commands: " )
            false
        end
    end

    def name
        "\"" + @resource[:name].to_s + "\""
    end

    def path
        "\"" + @resource[:path].to_s + "\""
    end

    def desc
        "\"" + @resource[:desc].to_s + "\""
    end
    def desc=(value)
    end

    def group_scope
        "\"" + @resource[:group_scope].to_s + "\""
    end
    def group_scope=(value)
    end

    def group_category
        "\"#{@resource[:group_category]}\""
    end
    def group_category=(value)
    end

    def displayname
        "\"" + @resource[:displayname].to_s + "\""
    end

end
