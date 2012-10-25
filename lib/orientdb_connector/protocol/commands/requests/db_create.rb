module OrientDBConnector
  module Protocol
    module Commands
      module Requests

        class DBCreate < BinData::Record

          endian :big

          int8 :operation_type, :value => OrientDBConnector::Protocol::Commands::COMMAND_DATA[:DB_CREATE][:code]

          int32 :session_id

          string32 :database_name
          string32 :database_type

          string32 :storage_type

        end

      end
    end
  end
end