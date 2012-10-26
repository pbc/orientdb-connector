module OrientDBConnector
  module Protocol
    module Commands
      module Requests

        class DBExist < BinData::Record

          endian :big

          int8 :operation_type, :value => OrientDBConnector::Protocol::PROTOCOL_DATA[:DB_EXIST][:code]

          int32 :session_id

          string32 :database_name

        end

      end
    end
  end
end