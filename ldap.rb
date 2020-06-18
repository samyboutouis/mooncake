require 'rubygems'
require 'net/ldap'

class LdapAuthorize 
end
    def authorize
        ldap = Net::LDAP.new
        ldap.host = "ldap.duke.edu"
        base = "dc=duke,dc=edu"
        ldap.port = 389
        auth = {:method => :simple, :username => "ms858", :password => "66Mary"}
        auth = auth
        if ldap.bind
            puts "authentication succeeded"
        else
            puts "authentication failed"
        end
        # puts "enter netid: "
        # netid = gets.chomp()
        # puts "#{netid}"
        # user = User.find_or_create_by(email: email)
        ldap = Net::LDAP.new :host => "ldap.duke.edu", :port => 389
        filter = Net::LDAP::Filter.eq( "Email", "maryam.shahid@duke.edu" )
        
        ldap.search( :base => base, :filter => filter ) do |entry|
            puts "DN: #{entry.dn}"
            entry.each do |attribute, values|
              puts "   #{attribute}:"
              values.each do |value|
                puts "      --->#{value}"
              end
            end
        end
        p ldap.get_operation_result
            
    end

    authorize





# ldap = Net::LDAP.new
# ldap.host = ldap.duke.edu
# ldap.port = 389
# ldap.auth "joe_user", "opensesame"
# if ldap.bind
#   # authentication succeeded
# else
#   # authentication failed
# end

# puts "enter netid: "
# netid = gets.chomp()
# ldap = Net::LDAP.new :host => server_ip_address,
#      :port => 389,
#      :auth => {
#            :method => :simple,
#            :username => "dc=duke,dc=edu",
#            :password => "opensesame"
#      }

# filter = Net::LDAP::Filter.eq( "cn", "George*" )
# treebase = "dc=example,dc=com"

# ldap.search( :base => treebase, :filter => filter ) do |entry|
#   puts "DN: #{entry.dn}"
#   entry.each do |attribute, values|
#     puts "   #{attribute}:"
#     values.each do |value|
#       puts "      --->#{value}"
#     end
#   end
# end

# p ldap.get_operation_result