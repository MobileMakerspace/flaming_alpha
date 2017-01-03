# https://github.com/elplatt/seltzer/blob/master/crm/modules/billing/billing.inc.php
class BillMembersService
  def call(params)
    # when was the last time we billed
    @last_billing = params[:last_billing]

    @members = Contact.members

    @members.each do |member|
       if member.memberships.last.stop.nil?
         puts "#{member.name} is active."
       else
         puts "#{member.name} is not active."
       end
    end

  end
end
