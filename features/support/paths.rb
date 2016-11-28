# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^login page$/
      '/'
    when /^manage users page$/
      '/users'
    when /^introduction page$/
      '/introduction'
    when /^the add user page$/
      '/users/new'
    when /^the security setup page$/
      '/users/setup_users'
    when /^the admin user page$/
      '/users/setup_users'
    when /^the user access page$/
      '/users/setup_users'
    when /^the all users page$/
      '/users'
    when /^the active users page$/
      '/users'
    when /^the super user activity log page$/
      '/users/report_users'
    when /^the login attempts log page$/
      '/users/report_users'
    when /^the super user activity log page$/
      '/users/report_users'
    when /^the user activity log page$/
      '/users/report_users'
    when /^the user details page$/
      '/users/report_users'
    when /^the locked users page$/
      '/users'
    when /^the user details log page$/
      '/users/report_users'
    when /^the terminated users page$/
      '/users'
    when /^the reset password page$/
      '/users'
    when /^the set maximum login attempts page$/
      '/users/setup_users'
    when /^the set super user page$/
      '/users/setup_users'
    when /^view master setup page$/
      '/master_setups'
    when /^the departmental sdbips generate report page$/
      '/departmental_sdbip_progresses'
    when /^the generate graphs page$/
      '/departmental_sdbip_progresses'
    when /^the generate report page$/
      '/departmental_sdbip_progresses'
    when /^the ytd dashboard page$/
      '/departmental_sdbip_progresses'
    when /^the toplayer administrators setup page$/
      '/departmental_administrators'
    when /^the view general headings page$/
      '/headings'
    when /^the departmental headings page$/
      '/headings'
    when /^the toplayer headings page$/
      '/headings'
    when /^the capital projects headings page$/
      '/headings'
    when /^the monthly cashflows headings page$/
      '/headings'
    when /^the revenue by source headings page$/
      '/headings'
    when /^the departmental view page$/
      '/departmental_sdbips'
    when /^the revenue by source headings page$/
      '/revenue_by_sources'
    when /^the monthly cashflows page$/
      '/monthly_cashflows'
    when /^kpi owners page$/
      '/departmental_administrators'
    when /^the add kpi page$/
      '/departmental_sdbips'
    when /^Department Setup page$/
      '/departments'
    when /^the create department page$/
      '/departments'
    when /^the deleted kpis page$/
      '/departmental_sdbips'
    when /^the create departmental administrators page$/
      '/departmental_administrators'
    when /^the create subdepartmental administrators page$/
      '/departmental_administrators'
    when /^the create heading page$/
      '/headings'
    when /^the time periods page$/
      '/sdbip_time_periods'
    when /^the import time periods page$/
      '/sdbip_time_periods'
    when /^the update all automatic time periods page$/
      '/sdbip_time_periods'
    when /^the add time period page$/
      '/sdbip_time_periods'
    when /^the system setup page$/
      '/setups'
    when /^the send kpi owner notifications page$/
      '/send_notification'
    when /^the update time period status page$/
      '/update_status'
    when /^the edit kpi page$/
      '/departmental_sdbips'
    when /^the update kpi page$/
      '/departmental_sdbips'
    when /^the import sdbip page$/
      '/departmental_sdbips'
    when /^the import top layers sdbip page$/
      '/top_layer_sdbips'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = Regexp.last_match(1).split(/\s+/)
        send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" \
              "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
