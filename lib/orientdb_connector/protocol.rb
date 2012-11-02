module OrientDBConnector
  module Protocol

    VERSION = 12

    PROTOCOL_DATA = {
      # ERROR is not a command
      :ERROR => {
        :response_class => "Error"
      },
      :SHUTDOWN => {
        :code => 1,
        :request_class => "Shutdown",
        :response_class => "Shutdown"
      },
      :CONNECT => {
        :code => 2,
        :request_class => "Connect",
        :response_class => "Connect"
      },
      :DB_OPEN => {
        :code => 3,
        :request_class => "DBOpen",
        :response_class => "DBOpen"
      },
      :DB_CREATE => {
        :code => 4,
        :request_class => "DBCreate",
        :response_class => "DBCreate"
      },
      :DB_CLOSE => {
        :code => 5,
        :request_class => "DBClose",
        :response_class => "DBClose"
      },
      :DB_EXIST => {
        :code => 6,
        :request_class => "DBExist",
        :response_class => "DBExist"
      },
      :DB_DELETE => {
        :code => 7,
        :request_class => "DBDelete",
        :response_class => "DBDelete"
      },
      :DB_SIZE => {
        :code => 8,
        :request_class => "DBSize",
        :response_class => "DBSize"
      },
      :DB_COUNTRECORDS => {
        :code => 9,
        :request_class => "DBCountRecords",
        :response_class => "DBCountRecords"
      },
      :DATACLUSTER_ADD => {
        :code => 10,
        :request_class => "DataClusterAdd",
        :response_class => "DataClusterAdd"
      },
      :DATACLUSTER_REMOVE => {
        :code => 11,
        :request_class => "DataClusterRemove",
        :response_class => "DataClusterRemove"
      },
      :DATACLUSTER_COUNT => {
        :code => 12,
        :request_class => "DataClusterCount",
        :response_class => "DataClusterCount"
      },
      :DATACLUSTER_DATARANGE => {
        :code => 13,
        :request_class => "DataClusterDataRange",
        :response_class => "DataClusterDataRange"
      },

      :DATASEGMENT_ADD => {
        :code => 20,
        :request_class => "DataSegmentAdd",
        :response_class => "DataSegmentAdd"
      },
      :DATASEGMENT_REMOVE => {
        :code => 21,
        :request_class => "DataSegmentRemove",
        :response_class => "DataSegmentRemove"
      },


      :RECORD_LOAD => {
        :code => 30,
        :request_class => "RecordLoad",
        :response_class => "RecordLoad"
      },
      :RECORD_CREATE => {
        :code => 31,
        :request_class => "RecordCreate",
        :response_class => "RecordCreate"
      },
      :RECORD_UPDATE => {
        :code => 32,
        :request_class => "RecordUpdate",
        :response_class => "RecordUpdate"
      },
      :RECORD_DELETE => {
        :code => 33,
        :request_class => "RecordDelete",
        :response_class => "RecordDelete"
      },

      :COUNT => {
        :code => 40,
        :request_class => "Count",
        :response_class => "Count"
      },
      :COMMAND => {
        :code => 41,
        :request_class => "Command",
        :response_class => "Command"
      },

      :TX_COMMIT => {
        :code => 60,
        :request_class => "TXCommit",
        :response_class => "TXCommit"
      },

      :CONFIG_GET => {
        :code => 70,
        :request_class => "ConfigGet",
        :response_class => "ConfigGet"
      },
      :CONFIG_SET => {
        :code => 71,
        :request_class => "ConfigSet",
        :response_class => "ConfigSet"
      },
      :CONFIG_LIST => {
        :code => 72,
        :request_class => "ConfigList",
        :response_class => "ConfigList"
      },
      :DB_RELOAD => {
        :code => 73,
        :request_class => "DBReload",
        :response_class => "DBReload"
      }
    }

  end
end

require "orientdb_connector/protocol/response_statuses"
require "orientdb_connector/protocol/commands"
require "orientdb_connector/protocol/record"