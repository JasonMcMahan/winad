Puppet::Type.newtype(:winad_features) do
      @doc = %q{Installs Windows AD Features.

        Example:

            winad_features { 'net_framework_core':
                ensure      => present,
            }
            winad_features { 'ad_domain_services':
                ensure                  => present,
                with_management_tools   => true,
            }

      }
      
      validate do
        fail('name is a required attribute') if self[:name].nil? 
      end

      ensurable
      newparam(:name, :namevar => :true) do
        desc "The name of the feature to be installed. Possible values are \"net_framework_core\" , \"ad_domain_services\"."
        newvalues("net_framework_core", "ad_domain_services")
      end   
      
      newparam(:with_management_tools) do
        desc "Install the mangement tools along with AD Domain services. Default to true."
        defaultto true
        newvalues(:true, :false)
      end  
end
