# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
notify { "Welcome to Puppet Windows Active Directory Module": }

    winad_features { 'net_framework_core':
        ensure      => present,
    } ->
    
    winad_features { 'ad_domain_services':
        ensure      => present,
    } ->
    
    winad_forest { 'shoneslabs':
        ensure                  => present,
        domain_name             => 'devops.shoneslab.com',
        domain_netbios_name     => 'SHONESLABS',
        password                => 'V@grant@123',
    } ->  
    
    winad_ou { 'TestOU2':
        ensure      => present,
        path        => 'DC=devops,DC=shoneslab,DC=com',
        city        => 'Atlanta',
        state       => 'GA',
        postalcode  => '30329',
        country     => 'US',
    } 


    notify { "Goodbye from Puppet Windows Active Directory Module": }