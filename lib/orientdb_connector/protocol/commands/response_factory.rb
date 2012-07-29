module OrientDBConnector
  module Protocol
    module Commands
      class ResponseFactory
        def self.create(type, *args)
          (eval "OrientDBConnector::Protocol::Commands::Responses::#{type.to_s.capitalize}").new(*args)
        end
      end
    end
  end
end
