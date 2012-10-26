module OrientDBConnector
  module Protocol
    module Commands
      module Responses

        class DBDelete < BinData::Record

          endian :big

          int8 :response_status
          int32 :session_id

        end

      end
    end
  end
end