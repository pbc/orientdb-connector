module OrientDBConnector
  module Protocol
    module Commands
      module Responses

        class DBOpen < BinData::Record

          endian :big
          int8 :response_status
          int32 :session_id

          int32 :new_session_id
          int16 :number_of_clusters

          array :clusters, :initial_length => :number_of_clusters do
            string32 :cluster_name
            int16 :cluster_id
            string32 :cluster_type
            int16 :cluster_data_segment_id
          end

          bytes32 :cluster_config

        end

      end
    end
  end
end