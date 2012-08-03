class ApplicationController < ActionController::Base
  protect_from_forgery

  if Takeout::Conf[:basic_auth_name]
    http_basic_authenticate_with name: Takeout::Conf[:basic_auth_name],
                                 password: Takeout::Conf[:basic_auth_pass]
  end
end
