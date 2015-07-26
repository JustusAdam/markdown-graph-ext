require 'kramdown/converter/html'


module GraphExt
  module Converter
    module GraphConverter
      def initialize_graphs

        vertices, edges, links = @root.children.reduce [[],[],[]] do |memo, element|
          if element.is_a? GraphExt::Vertex
            memo[0] << element
          elsif element.is_a? GraphExt::Edge
            memo[1] << element
          elsif element.is_a? GraphExt::Link
            memo[2] << element
          else
            memo
          end
        end

        algo = GraphExt::Algorithm::get(:default)
        @data[:graph_data] = algo(vertices, edges).calc
      end

      def graph_initialized
        @data.fetch(:graph_data, false) == true
      end

      def convert_graph_vertex(element,line)
        initialize_graphs unless graph_initialized
        ""
      end

      def convert_graph_edge(element,line)
        initialize_graphs unless graph_initialized
        ""
      end

      def convert_graph_link(element, line)
        initialize_graphs unless graph_initialized
        data = @data[:graph_data]
        render_graph(data, element)
      end
    end

    module HtmlRenderer
      def render_graph(graph_data, element)
        ""
      end
    end

    module PdfRenderer
      def render_graph(graph_data, element)
        ""
      end
    end
  end
end

class Kramdown::Converter::Html
  include GraphExt::Converter::GraphConverter
  include GraphExt::Converter::HtmlRenderer
end


# class Kramdown::Converter::Pdf
#   include GraphExt::Converter::GraphConverter
#   include GraphExt::Converter::PdfRenderer
# end
