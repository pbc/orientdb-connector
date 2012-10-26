module OrientDBConnector
  module Protocol
    module Commands
      class ResponseFactory
        class << self
          def response_class(command_type)
            OrientDBConnector::Protocol::PROTOCOL_DATA[command_type.to_s.upcase.to_sym][:response_class]
          end

          def create(command_type, *args)
            (eval "OrientDBConnector::Protocol::Commands::Responses::#{response_class(command_type)}").new(*args)
          end
        end
      end
    end
  end
end
