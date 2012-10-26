module OrientDBConnector
  module Protocol
    module Commands
      module Requests

        class DBSize < BinData::Record

          endian :big

          int8 :operation_type, :value => OrientDBConnector::Protocol::PROTOCOL_DATA[:DB_SIZE][:code]

          int32 :session_id

        end

      end
    end
  end
end