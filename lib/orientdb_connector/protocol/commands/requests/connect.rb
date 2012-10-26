module OrientDBConnector
  module Protocol
    module Commands
      module Requests

        class Connect < BinData::Record

          endian :big

          int8 :operation_type, :value => OrientDBConnector::Protocol::PROTOCOL_DATA[:CONNECT][:code]

          #negative number here will allow to obtain new session
          int32 :session_id, :initial_value => -1111

          string32 :driver_name
          string32 :driver_version
          int16 :protocol_version
          string32 :client_id
          string32 :user_name
          string32 :user_password

        end

      end
    end
  end
end