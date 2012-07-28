module OrientDBConnector
  module Protocol
    module Commands
      module Responses

        class Error < BinData::Record

          endian :big

          int8 :response_status
          int32 :session_id

          int8 :content_start

          array :messages, :read_until => :eof do

            string32 :exception_class
            string32 :exception_message
            int8 :is_followed_by_next_message
          end

        end
      end
    end
  end
end