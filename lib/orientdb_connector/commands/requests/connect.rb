module OrientDBConnector
  module Commands
    module Requests
      class Connect < BinData::Record

        endian :big

        int8 :operation_type, :default => 2
        int32 :session_id, :default => 0

        compound_string :driver_name
        compound_string :driver_version
        int16 :protocol_version
        compound_string :client_id
        compound_string :user_name
        compound_string :user_password

      end
    end
  end
end