Puppet::Type.type(:winad_user).provide(:powershell) do
    confine :operatingsystem => :windows
    defaultfor :operatingsystem => :windows
    
    commands :powershell => Powershell.getPowershellCommand

    def create
        self.class.send_log(:info, "call create()")

        powershell(["import-module activedirectory;","New-ADUser",
        " -Name #{name}",
        " -Samaccountname #{name}",
        " -Description  #{desc}",
        " -Path #{path}",
        " -PasswordNeverExpires $#{@resource[:password_never_expires]}",
        " -AccountPassword (ConvertTo-SecureString '#{@resource[:password]}' -AsPlainText -force)",
        " -Enabled $#{@resource[:enabled]}"])

    end

    def destroy
      self.class.send_log(:info, "call destroy()")
        powershell([ "import-module activedirectory;","Remove-ADUser","-Identity \"CN=#{@resource[:name]},#{@resource[:path]}\""," -Confirm:$false"])

    end

    def exists?
      self.class.send_log(:info, "call exists?")
      myreturnvalue =   powershell([ "import-module activedirectory;","Get-ADUser -Filter {(name -eq \"#{@resource[:name]}\")} -SearchBase \"#{@resource[:path]}\""])

      self.class.send_log(:info, "Get-ADUser: The return value is : #{myreturnvalue} ")

      if myreturnvalue == ""
        false
      else
        true
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

    def password_never_expires
      "$" + @resource[:password_never_expires]
    end
    
    def to_boolean(str)
      str.to_downcase == 'true'
    end



    def displayname
      "\"" + @resource[:displayname].to_s + "\""
    end

end
