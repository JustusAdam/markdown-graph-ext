module GraphExt
  class Edge < GraphObj

    VALID_OPERATORS = {
      '<-' => :to_left,
      '->' => :to_right,
      '<->' => :to_both,
      '-' => :to_neither
    }

    OPERATOR_VALUES = VALID_OPERATORS.invert

    def initilize(operand_1, operand_2, operator)
      @operand_1 = operand_1
      @operand_2 = operand_2

      @operator = VALID_OPERATORS.fetch operator do |key|
        if OPERATOR_VALUES.member? key
          key
        else
          raise "Unknown operator"
        end
      end
    end
  end
end
