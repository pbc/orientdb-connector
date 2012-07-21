module OrientDBConnector
  module Commands
    module Requests
      class Connect < BinData::Record

        endian :big
        string :driver_name
        string :driver_version
        int16 :protocol_version
        string :client_id
        string :user_name
        string :user_password

      end
    end
  end
end