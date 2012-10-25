module OrientDBConnector
  module Protocol
    module Commands
      module Requests

        class DBClose < BinData::Record

          endian :big

          int8 :operation_type, :value => OrientDBConnector::Protocol::Commands::COMMAND_DATA[:DB_CLOSE][:code]

          int32 :session_id

        end

      end
    end
  end
end