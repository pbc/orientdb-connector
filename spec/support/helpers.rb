module Helpers

  def command_request_object(type)
    OrientDBConnector::SimpleClient.new.create_request_object(type)
  end

  def command_response_object(type)
    OrientDBConnector::SimpleClient.new.create_response_object(type)
  end

  def prepared_db_open_request
    request = command_request_object(:db_open)
    request.session_id = -123
    request.driver_name = OrientDBConnector::DRIVER_NAME
    request.driver_version = OrientDBConnector::DRIVER_VERSION
    request.protocol_version = OrientDBConnector::Protocol::VERSION
    request.client_id = ""
    request.database_name = DB_PARAMS[:name]
    request.database_type = DB_PARAMS[:type]
    request.user_name = OrientDBConnector::Base.config.connection_params[:user]
    request.user_password = OrientDBConnector::Base.config.connection_params[:password]
    request
  end

  def prepared_connect_request
    request = command_request_object(:connect)
    request.session_id = -123
    request.driver_name = OrientDBConnector::DRIVER_NAME
    request.driver_version = OrientDBConnector::DRIVER_VERSION
    request.protocol_version = OrientDBConnector::Protocol::VERSION
    request.client_id = ""
    request.user_name = OrientDBConnector::Base.config.connection_params[:user]
    request.user_password = OrientDBConnector::Base.config.connection_params[:password]
    request
  end

end