module ClamScan
  class Client
    class << self
      def scan (opts={})
        response = Request.send(opts)

        if ::ClamScan.configuration.raise_unless_safe
          if response.virus?
            raise VirusDetected.new(response)
          elsif response.unknown?
            raise UnknownError.new(response)
          elsif !response.safe?
            raise ResponseError.new(response)
          end
        end

        response
      end
    end
  end
end
