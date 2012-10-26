require "spec_helper"

describe "DB_OPEN command" do

  let(:simple_client) { OrientDBConnector::SimpleClient.new() }

  context "single server configuration (no clusters)" do

    it "should be possible to send DB_OPEN request and receive correct DB_OPEN response" do

      request = simple_client.create_request_object(:db_open)
      request.class.should == OrientDBConnector::Protocol::Commands::Requests::DBOpen

      request.session_id = -123
      request.driver_name = OrientDBConnector::DRIVER_NAME
      request.driver_version = OrientDBConnector::DRIVER_VERSION
      request.protocol_version = OrientDBConnector::Protocol::VERSION
      request.client_id = ""
      request.database_name = DB_PARAMS[:name]
      request.database_type = DB_PARAMS[:type]
      request.user_name = OrientDBConnector::Base.config.connection_params[:user]
      request.user_password = OrientDBConnector::Base.config.connection_params[:password]

      response = simple_client.send_request(:db_open, request)

      response.class.should == OrientDBConnector::Protocol::Commands::Responses::DBOpen
      response.response_status.should == 0
      response.session_id.should == -123
      response.new_session_id.should > 0

      sorted_clusters = response.clusters.to_a.sort do |x,y|
        x.cluster_id <=> y.cluster_id
      end

      response.number_of_clusters.should >= 10 if DB_PARAMS[:type] == "graph"
      response.number_of_clusters.should >= 8 if DB_PARAMS[:type] == "document"

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


      response.cluster_config.should be_an(OrientDBConnector::PrimitiveTypes::Bytes32)

      # we are not using clustered servers so cluster_config should be empty
      response.cluster_config.length.should == 0

    end

  end

end