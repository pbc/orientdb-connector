module OrientDBConnector
  module Protocol
    module Commands
      class RequestFactory

        def self.type_to_class(type)

        end

        def self.create(type, *args)
          (eval "OrientDBConnector::Protocol::Commands::Requests::#{type.to_s.capitalize}").new(*args)
        end
      end
    end
  end
end
