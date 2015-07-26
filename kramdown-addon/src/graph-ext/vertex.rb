module GraphExt
  class Vertex < GraphObj
    def initialize(name, content)
      @name = name
      @content = content
    end

    def hash
      @name.hash
    end

    def ==(other)
      @name == other
    end
  end
end
