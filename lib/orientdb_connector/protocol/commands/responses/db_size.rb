module OrientDBConnector
  module Protocol
    module Commands
      module Responses

        class DBSize < BinData::Record

          endian :big

          int8 :response_status
          int32 :session_id

          int64 :size_in_bytes

        end

      end
    end
  end
end