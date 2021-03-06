# winad

[![Build Status](https://travis-ci.org/shoneslab/winad.svg?branch=master)](https://travis-ci.org/shoneslab/winad)
![Windows Build Status](https://ci.appveyor.com/api/projects/status/fhjf2omybd5o14a6?svg=true)
[![Coverage Status](https://coveralls.io/repos/github/shoneslab/winad/badge.svg?branch=master)](https://coveralls.io/github/shoneslab/winad?branch=master)
[![Puppet Forge](https://img.shields.io/puppetforge/v/shoneslab/winad.svg)](https://forge.puppetlabs.com/shoneslab/winad)

#### Table of Contents

1. [Overview](#overview)
1. [Description](#description)
1. [Setup - The basics of getting started with winad](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with winad](#beginning-with-winad)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)



## Overview

The winad module manages Windows Active Directory tasks to create Organizanation Unit, Groups and Users.

## Description

Puppet Module manages Windows Active Directory components such as Organizanation Unit, Groups and Users.

## Setup

### Setup Requirements

This module expects the puppetlabs-powershell module installed on the system

~~~
puppet module install puppetlabs-powershell
~~~

Finally, install the module with

~~~
puppet module install shoneslab-winad
~~~

### Beginning with winad

The winad module allows you to manage windows system using the Puppet DSL. To create an organizational unit (OU), use the `winad_ou` type. The following code sets up a very basic organizantional unit.
```puppet
winad_ou { 'TestOU':
    ensure      => present,
    path        => 'DC=shoneslab,DC=win,DC=com',
    city        => 'Atlanta',
    state       => 'GA',
    postalcode  => '30329',
    country     => 'US',
} 
```


## Usage
###Installing Windows Feature - Net Framework Core:
```puppet
 winad_features { 'net_framework_core':
    ensure      => present,
 } 
```
###Installing Windows Feature - AD Domain Services:
```puppet
 winad_features { 'ad_domain_services':
    ensure      => present,
 } 
```

###Creating Windows AD Organizational Unit:
```puppet
winad_ou { 'TestOU':
    ensure      => present,
    path        => 'DC=shoneslab,DC=win,DC=com',
    city        => 'Atlanta',
    state       => 'GA',
    postalcode  => '30329',
    country     => 'US',
} 
```

###Creating Windows AD Group:
```puppet
winad_group { 'PrivUserGroup1':
    ensure          => present,
    path            => 'OU=TestOU,DC=shoneslab,DC=win,DC=com',
    group_scope     => 'DomainLocal',
    group_category  => 'Security',
}
```

###Creating Windows AD User:
```puppet
winad_user { 'PuppetUser01':
    ensure                      => absent,
    path                        => 'CN=Users,DC=shoneslab,DC=win,DC=com',
    password_never_expires      => true,
    password                    => 'V@grant@123',
    enabled                     => true,
    type                        => 'User',
}
```

## Reference

### Types

* `winad_ou`: Creates an Organizational Unit(OU).
* `winad_group`: Creates a Group.
* `winad_user`: Creates a User.

###Parameters

####Type: winad_ou

#####`ensure`
Specifies the basic state of the resource. Valid values are 'present', 'absent'.

#####`name`
Specifies the name of the organizational unit.

#####`desc`
Specifies the description of the organizational unit.

#####`path`
Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created.

#####`street_address`
Specifies the organizational unit's street address.

#####`city`
Specifies the organizational unit's state or province.

#####`country`
Specifies the country or region code for the user's language of choice.

#####`postalcode`
Specifies the user's postal code or zip code.


####Type: winad_group

#####`ensure`
Specifies the basic state of the resource. Valid values are 'present', 'absent'.

#####`name`
Specifies the name of the AD group.

#####`desc`
Specifies the description of the AD group.

#####`group_scope`
Specifies the group scope of the group. Valid values are "DomainLocal", "Global", "Universal".

#####`group_category`
Specifies the category of the group. Valid values are "Distribution", "Security"

####Type: winad_user

#####`ensure`
Specifies the basic state of the resource. Valid values are 'present', 'absent'.

#####`name`
Specifies the users name.

#####`desc`
Specifies the description of the user.

#####`path`
Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created.

#####`password_never_expires`
Specifies whether the password of an account can expire.

#####`password`
Specifies a new password value for an account.

#####`enabled`
Specifies if an account is enabled. An enabled account requires a password.

## Limitations
Currently, the winad module is tested on the following windows operating system versions:
* Windows 2012 R2

Other windows versions might be compatible, but are not being actively tested.

## Development

TODO - Precheck required for OU, Group and Users. Throws error if the forest/Domain Controller/AD is not configured.

TODO - Incorporate more attributes to the types

TODO - Update Features

TODO - Need to test on versions other than Win2012R2

TODO - Acceptance Testing Scripts

TODO - Documentation


