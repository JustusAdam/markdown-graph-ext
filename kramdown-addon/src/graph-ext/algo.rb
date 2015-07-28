require "graph-ext/algo/base"
require 'graph-ext/algo/dne'

module GraphExt
  module Algorithm
    def self.get(id)
      Object.const_get(DEFAULT_IMPL)
    end
    
    private

    DEFAULT_IMPL = 'DegreeNormalizedEigenvectorDraw'
  end
end
