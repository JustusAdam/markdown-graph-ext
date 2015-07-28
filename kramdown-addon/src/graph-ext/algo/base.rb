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

      def calc_laplacian_matrix(size, edges)
        deg_map = Array.new(size, 0)

        m = Matrix.build(size, size) { 0 }

        edges.each do | e |
          deg_map[e[0]] += 1
          deg_map[e[1]] += 1
          m[*e] = 1
        end

        deg_map.zip(0..deg_map.length).each { | d | m[d[1], d[1]] = d[0] }
        
        m
      end

      def calc_adjacency_matrix(size, edges)
        m = Matrix.build(size, size) { 0 }

        edges.each { | edge | m[*edge] = 1 }
      end

      def create_vertex_map(vertices)
        Hash[vertices.zip(0..vertices.length)]
      end

      def convert_edges(vertex_map, edges)
        edges.map { |e| [vertex_map[e.operand_1], vertex_map[e.operand_2]] }
      end

      # def unwind_graphs
      #
      #   graphs = []
      #   edgemap = Hash.new { |hash, key| hash[key] = [] }
      #
      #   edges.each do |elem|
      #     edgemap[elem.operand_1] << elem.operand_2
      #     edgemap[elem.opernad_2] << elem.operand_1
      #   end
      #
      #   edgemap.each_value {|elem| elem.uniq! }
      #
      #   vertices.each do |vertex|
      #
      #     graph = graphs.select {|g| g.includes? vertex.name }
      #
      #     if graph.nil?
      #       graph = {}
      #       graphs << graph
      #     end
      #
      #     clear_all = Proc.new do |inner_vertex|
      #       list = edgemap.delete inner_vertex
      #       graph[inner_vertex] = list
      #       list.each clear_all
      #     end
      #
      #     clear_all vertex.name
      #
      #   end
      #
      #   graphs
      #
      # end
    end
  end
end
