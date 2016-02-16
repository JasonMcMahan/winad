# Class: winad
# ===========================
#
# Full description of class winad here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'winad':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class winad {

notify { "Welcome to Puppet Windows Active Directory Module": }

    winad_forest { 'shoneslabs':
        ensure                  => present,
        domain_name             => 'devops.shoneslabs.com',
        domain_netbios_name     => 'SHONESLABS',
        password                => 'V@grant@123',
    }->
    
    winad_ou { 'TestOU2':
        ensure      => present,
        path        => 'DC=devops,DC=shoneslabs,DC=com',
        city        => 'Atlanta',
        state       => 'GA',
        postalcode  => '30338',
        country     => 'US',
    } 


    notify { "Goodbye from Puppet Windows Active Directory Module": }
}
