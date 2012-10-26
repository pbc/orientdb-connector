module OrientDBConnector
  module Protocol
    module Commands
      module Responses

        class DBExist < BinData::Record

          endian :big

          int8 :response_status
          int32 :session_id

          int8 :result

        end

      end
    end
  end
end