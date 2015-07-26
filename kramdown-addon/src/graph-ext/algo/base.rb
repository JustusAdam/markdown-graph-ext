module GraphExt
  module Algorithm
    class Base
      def initialize(vertices, edges)
        @vertices = vertices
        @edges = edges
      end

      def calc
      end

      protected

      def unwind_graphs

        graphs = []
        edgemap = Hash.new { |hash, key| hash[key] = [] }

        edges.each do |elem|
          edgemap[elem.operand_1] << elem.operand_2
          edgemap[elem.opernad_2] << elem.operand_1
        end

        edgemap.each_value {|elem| elem.uniq! }

        vertices.each do |vertex|

          graph = graphs.select {|g| g.includes? vertex.name }

          if graph.nil?
            graph = {}
            graphs << graph
          end

          clear_all = Proc.new do |inner_vertex|
            list = edgemap.delete inner_vertex
            graph[inner_vertex] = list
            list.each clear_all
          end

          clear_all vertex.name

        end

        graphs

      end
    end
  end
end
