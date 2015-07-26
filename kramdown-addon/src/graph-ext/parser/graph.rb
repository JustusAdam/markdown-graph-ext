require 'kramdown/parser/kramdown'


class Kramdown::Parser::GraphParser < Kramdown::Parser::Kramdown

  def initialize(source, options)
    super
  #  @span_parsers.unshift(:erb_tags)
    @span_parsers.unshift(:graph_vertice_tags)
    @span_parsers.unshift(:graph_edge_tags)
    @span_parsers.unshift(:graph_link_tags)
  end


  #  ERB_TAGS_START = /<%.*?%>/

  #  def parse_erb_tags
  #    @src.pos += @src.matched_size
  #    @tree.children << Element.new(:raw, @src.matched)
  #  end
  #  define_parser(:erb_tags, ERB_TAGS_START, '<%')

  GRAPH_TAG_IDENTIFICATION_STRING = 'v'
  IDENTIFIER_REGEX = '\w+'

  VERTICE_TAG = %r{
    # -----------------------------------------
    # identifier
    # -----------------------------------------
    (\A|\n)                 # start of the string
    #{GRAPH_TAG_IDENTIFICATION_STRING} # keyword for stating identifier
    \[                      # identifier starts with open brackets
      (?<identifier>        # identifier itself
      #{IDENTIFIER_REGEX}
      )
    \]                      # identifier ends with open brackets
    :                       # separator colon

    # -----------------------------------------
    # content
    # -----------------------------------------
    (

    # -----------------------------------------
    # first content version
    # -----------------------------------------
    (
    [[:blank:]]             # one required whitespace
    (?<content>             # group name
    [^\n\r]*                # actual content - can be empty
    ?)                      # be non greedy with the whitespace
    [[:blank:]]*            # arbitrary trailing spaces to be ignored
    (?:\r?\n|\Z)            # newline or end of string

    )|(
    # -----------------------------------------
    # second content version
    # -----------------------------------------
    # the first required line
    [[:blank:]]*            # arbitrary whitespace
    \r?\n                   # newline required
    (?<content>             # group name as above
    (?<indent>              # block indentation
      ([ ]{2,})             # either at least two spaces
      |                     # or
      (\t+)                 # at least one tab character
    )
    [^\n\r]+                # actual content
    \r?\n                   # one required newline
    # repeating more lines
    (
      \g<indent>            # same indentation again
      [^\n\r]+              # more actual content
      \r?\n                 # a finishing newline
    )*                      # repeat as often as desired
    )
    # -----------------------------------------
    )
    # -----------------------------------------
    # end of content
    # -----------------------------------------
    )
  }x

  EDGE_TAG = %r{
    (\A|\n)                 # start of string
    (?<operand_1>           # first operand
      #{IDENTIFIER_REGEX}
    )
    [ ]*                    # optional whitespace
    (?<operators>
      (
        (#{GraphExt::Edge::VALID_OPERATORS.keys.join '|'}) # operators
        [[:blank:]]*?       # optional greedy whitespace
      )
      +                     # at least one required
    )
    [[:blank:]]*            # more optional whitespace
    (?<operand_2>           # second operand
      #{IDENTIFIER_REGEX}
    )
    [[:blank:]]*            # more optional whitespace
    (\r?\n|\Z)              # end of string or newline
  }x

  GRAPH_LINK_TAG = %r{
    <
    #{GRAPH_TAG_IDENTIFICATION_STRING}
    \|
      (?<identifier>#{IDENTIFIER_REGEX})
    >
  }x


  SINGLE_OPERATOR_REGEX = /(#{GraphExt::Edge::VALID_OPERATORS.keys.sort_by {|a| a.length }.join '|'})/

  def parse_graph_vertice_tags
    @src.pos += @src.matched_size
    match = @src.matched().match VERTICE_TAG
    @tree.children << Element.new(:graph_vertex, GraphExt::Vertice.new(match[:identifier], match[:content]))
  end
  define_parser(:graph_vertice_tags, VERTICE_TAG)

  def parse_graph_edge_tags
    @src.pos += @src.matched_size
    match = @src.matched().match EDGE_TAG
    match[:operators].scan SINGLE_OPERATOR_REGEX do |operator|
      @tree.children << Element.new(:graph_edge, GraphExt::Edge.new(match[:operand_1], match[:operand_2], operator))

    end


  end
  define_parser(:graph_edge_tags, EDGE_TAG)

  def parse_graph_link_tag
    @src.pos += @src.matched
    match = @src.matched().match GRAPH_LINK_TAG
    @tree.children << Element.new(:graph_link, GraphExt::Link.new(match[:identifier]))
  end
  define_parser(:graph_link_tags, GRAPH_LINK_TAG)


end
