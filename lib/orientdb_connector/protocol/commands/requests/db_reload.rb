module OrientDBConnector
  module Protocol
    module Commands
      module Requests

        class DBReload < BinData::Record

          endian :big

          int8 :operation_type, :value => OrientDBConnector::Protocol::PROTOCOL_DATA[:DB_RELOAD][:code]

          int32 :session_id

        end

      end
    end
  end
end