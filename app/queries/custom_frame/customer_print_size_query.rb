module CustomFrame
  class CustomerPrintSizeQuery
    def call(width, height)
      longest_side = [width, height].max
      shortest_side = [width, height].min

      CustomFrame::PrintSize.available
                            .where(['longest_side >= ? AND shortest_side >= ?', longest_side, shortest_side])
                            .order(:longest_side, :shortest_side)
                            .first
    end
  end
end
