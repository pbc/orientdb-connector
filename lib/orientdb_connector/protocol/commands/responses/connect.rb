module OrientDBConnector
  module Protocol
    module Commands
      module Responses

        class Connect < BinData::Record

          endian :big

          int8 :response_status
          int32 :session_id

          int32 :new_session_id

        end

      end
    end
  end
end