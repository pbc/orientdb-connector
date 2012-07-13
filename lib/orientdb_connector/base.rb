module OrientDBConnector
  class Base

    class << self

      def configure(&block)
        class_eval(&block)
      end

      def config
        OrientDBConnector::Config.instance
      end


    end

  end
end