module OrientDBConnector
  module Protocol
    module Commands
      module Responses

        class DBClose < BinData::Record

          endian :big

          # no response here, the socket is just closed on the server's side

        end

      end
    end
  end
end