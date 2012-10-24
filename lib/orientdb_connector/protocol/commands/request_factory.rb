module OrientDBConnector
  module Protocol
    module Commands
      class RequestFactory
        class << self
          def request_class(command_type)
            OrientDBConnector::Protocol::Commands::COMMAND_DATA[command_type.to_s.upcase.to_sym][:request_class]
          end

          def create(command_type, *args)
            (eval "OrientDBConnector::Protocol::Commands::Requests::#{request_class(command_type)}").new(*args)
          end
        end
      end
    end
  end
end
