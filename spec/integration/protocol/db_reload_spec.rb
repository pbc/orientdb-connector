require "spec_helper"

describe "DB_RELOAD command" do

  include Helpers

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  context "single server configuration (no clusters)" do

    it "should be possible to send DB_RELOAD request and receive correct DB_RELOAD response" do


      db_open_response = simple_client.send_request(:db_open, prepared_db_open_request)

      db_reload_request = simple_client.create_request_object(:db_reload)
      db_reload_request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBReload

      db_reload_request.session_id = db_open_response.new_session_id

      db_reload_response = simple_client.send_request(:db_reload, db_reload_request)
      db_reload_response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBReload

      db_reload_response.response_status.should == 0
      db_reload_response.session_id.should == db_open_response.new_session_id


      sorted_clusters = db_reload_response.clusters.to_a.sort do |x,y|
        x.cluster_id <=> y.cluster_id
      end

      db_reload_response.number_of_clusters.should >= 10 if DB_PARAMS[:type] == "graph"
      db_reload_response.number_of_clusters.should >= 8 if DB_PARAMS[:type] == "document"

      # checking few first clusters to see if response parsing went correctly

      sorted_clusters[0].cluster_id.should == 0
      sorted_clusters[0].cluster_name.should == "internal"
      sorted_clusters[0].cluster_type.should == "PHYSICAL"
      sorted_clusters[0].cluster_data_segment_id.should == 0

      sorted_clusters[1].cluster_id.should == 1
      sorted_clusters[1].cluster_name.should == "index"
      sorted_clusters[1].cluster_type.should == "PHYSICAL"
      sorted_clusters[1].cluster_data_segment_id.should == 0

      sorted_clusters[2].cluster_id.should == 2
      sorted_clusters[2].cluster_name.should == "manindex"
      sorted_clusters[2].cluster_type.should == "PHYSICAL"
      sorted_clusters[2].cluster_data_segment_id.should == 0

      sorted_clusters[3].cluster_id.should == 3
      sorted_clusters[3].cluster_name.should == "default"
      sorted_clusters[3].cluster_type.should == "PHYSICAL"
      sorted_clusters[3].cluster_data_segment_id.should == 0

      sorted_clusters[4].cluster_id.should == 4
      sorted_clusters[4].cluster_name.should == "orole"
      sorted_clusters[4].cluster_type.should == "PHYSICAL"
      sorted_clusters[4].cluster_data_segment_id.should == 0

      sorted_clusters[5].cluster_id.should == 5
      sorted_clusters[5].cluster_name.should == "ouser"
      sorted_clusters[5].cluster_type.should == "PHYSICAL"
      sorted_clusters[5].cluster_data_segment_id.should == 0

      simple_client.close_all_connections

    end

  end

end