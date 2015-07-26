require 'kramdown/converter/html'


module GraphExt
  module Converter
    module Graph
      def initialize_graphs
        @root.children.each do |element|
          ""
        end
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
  include GraphExt::Converter::Graph
  include GraphExt::Converter::HtmlRenderer
end


# class Kramdown::Converter::Pdf
#   include GraphExt::Converter::Graph
#   include GraphExt::Converter::PdfRenderer
# end
