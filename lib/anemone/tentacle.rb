require 'anemone/http'

module Anemone
  class Tentacle
    
    #
    # Create a new Tentacle
    #
    def initialize(link_queue, page_queue, opts = {})
      @link_queue = link_queue
      @page_queue = page_queue
      @http = Anemone::HTTP.new(opts)
      @opts = opts
    end
    
    #
    # Gets links from @link_queue, and returns the fetched
    # Page objects into @page_queue
    #
    def run
      loop do
        link, from_page = @link_queue.deq
        
        break if link == :END

        @page_queue << @http.fetch_page(link, from_page)

        delay
      end
    end

    private

    def delay
      sleep @opts[:delay] if @opts[:delay]
    end

  end
end