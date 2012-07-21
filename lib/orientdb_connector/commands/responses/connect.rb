
module OrientDBConnector
  module Commands
    module Responses
      class Connect < BinData::Record

        endian :big
        int32 :session_id

      end
    end
  end
end