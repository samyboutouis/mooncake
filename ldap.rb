require 'rubygems'
require 'net/ldap'

class LdapAuthorize
end
    def authorize
        ldap = Net::LDAP.new
        ldap.host = "ldap.duke.edu"
        base = "dc=duke,dc=edu"
        ldap.port = 389
        if ldap.bind
            puts "authentication succeeded"
        else
            puts "authentication failed"
        end
        puts "enter netid: "
        netid = gets.chomp()
        filter = Net::LDAP::Filter.eq( "cn", netid )

        result = ldap.search( :base => base, :filter => filter ) do |entry|
            puts "DN: #{entry.dn}"
            entry.each do |attribute, values|
              values.each do |value|
                puts " #{attribute} --->#{value}"
              end
            end
        end
        ldap.get_operation_result

        puts "****************************"
        puts "*****Authorizaing.......****"
        puts "****************************"
        
        information = result.pop
        affiliation = information["edupersonprimaryaffiliation"]


        if affiliation[0] == "staff"
            puts "You are authorized"
        else
            puts "Not Authorized!"
        end

    end

    authorize
