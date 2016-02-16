#require "countries_list"
require Pathname.new(__FILE__).dirname + '../../puppet/util/data/countries_list'
class Validator

  def self.is_valid_country_code(code)
    Puppet.info("Validating Country Code")
    return COUNTRY_CODE.include?(code)
  end
  
  def self.is_valid_password(password)
    Puppet.info("Validating Windows AD password")
    
    unless (password.length < 8)
        hasUpperCase = /[A-Z]/ =~ password ? 1:0
        hasLowerCase = /[a-z]/ =~ password ? 1:0
        hasNumbers = /\d/ =~ password ? 1:0 
        hasNonalphas = /\W/ =~ password ? 1:0 
        if (hasUpperCase + hasLowerCase + hasNumbers + hasNonalphas < 3)
            return false
        else
            return true
        end
    end
    return true
  end
  
  def self.is_valid_winadnames(names)
    Puppet.info("Validating Win AD names")
    return /[\\\/:*?<>|]/ =~ names ? false : true
  end
end
